package com.gstory.gpu_image.camera

import android.annotation.SuppressLint
import android.app.Activity
import android.content.Context
import android.graphics.Bitmap
import android.graphics.Matrix
import android.net.Uri
import android.os.Build
import android.os.Environment
import android.util.Log
import android.view.Surface
import android.view.View
import android.view.ViewGroup
import android.widget.FrameLayout
import androidx.annotation.RequiresApi
import androidx.camera.core.CameraSelector
import androidx.camera.core.ImageAnalysis
import androidx.camera.lifecycle.ProcessCameraProvider
import androidx.core.content.ContextCompat
import androidx.lifecycle.Lifecycle
import androidx.lifecycle.LifecycleOwner
import androidx.lifecycle.LifecycleRegistry
import com.gstory.gpu_image.util.FileUtil
import com.gstory.gpu_image.util.FilterTools
import com.gstory.gpu_image.util.YuvToRgbConverter
import com.gstory.gpu_image.util.doOnLayout
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.platform.PlatformView
import jp.co.cyberagent.android.gpuimage.GPUImage
import jp.co.cyberagent.android.gpuimage.GPUImageView
import jp.co.cyberagent.android.gpuimage.util.Rotation
import java.io.File
import java.util.concurrent.Executors

/**
 * @Author: gstory
 * @CreateDate: 2022/1/21 3:03 下午
 * @Description: 描述
 */

@RequiresApi(Build.VERSION_CODES.LOLLIPOP)
internal class CameraView(
    var context: Context,
    var activity: Activity,
    messenger: BinaryMessenger?,
    id: Int,
    params: Map<String?, Any?>
) :
    PlatformView, MethodChannel.MethodCallHandler, LifecycleOwner {

    var width: Double = params["width"] as Double
    var height: Double = params["height"] as Double
    private var mContainer = FrameLayout(activity)

    private val gpuImageView: GPUImageView by lazy {
        GPUImageView(activity)
    }

    private var cameraProvider: ProcessCameraProvider? = null
    private val executor = Executors.newSingleThreadExecutor()
    private var converter = YuvToRgbConverter(activity)
    private var bitmap: Bitmap? = null


    private var channel: MethodChannel = MethodChannel(messenger, "com.gstory.gpu_image/camera_$id")

    private val mRegistry = LifecycleRegistry(this)

    //是否后置摄像头
    private var isBackCamera = true

    init {
        channel.setMethodCallHandler(this)
        mContainer.layoutParams?.width = ViewGroup.LayoutParams.WRAP_CONTENT
        mContainer.layoutParams?.height = ViewGroup.LayoutParams.WRAP_CONTENT
        gpuImageView.layoutParams?.width = width.toInt()
        gpuImageView.layoutParams?.height = height.toInt()
        gpuImageView.setScaleType(GPUImage.ScaleType.CENTER_CROP)
//        gpuImageView.rotation = 90F
        gpuImageView.setRenderMode(GPUImageView.RENDERMODE_CONTINUOUSLY)
        val cameraProviderFuture = ProcessCameraProvider.getInstance(activity)
        cameraProviderFuture.addListener(Runnable {
            cameraProvider = cameraProviderFuture.get()
            startCameraIfReady()
        }, ContextCompat.getMainExecutor(activity))
        mContainer.addView(gpuImageView)
        mRegistry.currentState = Lifecycle.State.CREATED
        mRegistry.currentState = Lifecycle.State.RESUMED
    }

    @SuppressLint("UnsafeOptInUsageError")
    private fun startCameraIfReady() {
        val imageAnalysis =
            ImageAnalysis.Builder().setBackpressureStrategy(ImageAnalysis.STRATEGY_KEEP_ONLY_LATEST)
                .build()
        imageAnalysis.setAnalyzer(executor, ImageAnalysis.Analyzer {
            var bitmap = allocateBitmapIfNecessary(it.width, it.height)
            converter.yuvToRgb(it.image!!, bitmap)
            bitmap = if(isBackCamera){
                BitmapRotate(bitmap, 90f)
            }else{
                BitmapRotate(bitmap, 270f)
            }
            it.close()
            gpuImageView.post {
                gpuImageView.setImage(bitmap)
            }
        })
        var cameraSelector = if (isBackCamera) {
            CameraSelector.DEFAULT_BACK_CAMERA
        } else {
            CameraSelector.DEFAULT_FRONT_CAMERA
        }
        cameraProvider?.let {
            cameraProvider?.unbindAll()
            cameraProvider?.bindToLifecycle(
                this,
                cameraSelector, imageAnalysis
            )
        }
    }


    //使用Bitmap加Matrix来翻转
    fun BitmapRotate(bitmap: Bitmap, rotate: Float): Bitmap {
        val bmpWidth = bitmap.width
        val bmpHeight = bitmap.height
        val matrix = Matrix()
        matrix.postRotate(rotate)//旋转角度
        return Bitmap.createBitmap(bitmap, 0, 0, bmpWidth, bmpHeight, matrix, true)
    }

    private fun allocateBitmapIfNecessary(width: Int, height: Int): Bitmap {
        if (bitmap == null || bitmap!!.width != width || bitmap!!.height != height) {
            bitmap = Bitmap.createBitmap(width, height, Bitmap.Config.ARGB_8888)
        }
        return bitmap!!
    }

    override fun getView(): View {
        return mContainer
    }


    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        if ("setFilter" == call.method) {
            var arguments = call.arguments as Map<*, *>
            var filter = FilterTools.getFilter(arguments)
            Log.d("======>","$filter")
            if (filter != null) {
                gpuImageView.filter = filter
            }
        } else if ("switchCamera" == call.method) {
            isBackCamera = !isBackCamera
            startCameraIfReady()
        } else if("recordPhoto" == call.method){
            val folderName = "GPUImage"
            val fileName = System.currentTimeMillis().toString() + ".jpg"
            val path = Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_PICTURES)
            val file = File(path, "$folderName")
            if(!file.exists()){
                file.mkdirs()
            }
            gpuImageView.saveToPictures(folderName,fileName
            ) { uri ->
                var path: String? = uri?.path
                if (!path.isNullOrEmpty()) {
                    //高版本不返回真实路径 需要自己MediaStore转换
                    if (!uri?.path!!.endsWith(".jpg")) {
                        path = FileUtil().getRealPathFromURI(activity, uri)
                    }
                    var map: MutableMap<String, Any?> = mutableMapOf("path" to path)
                    channel.invokeMethod("recordPhoto", map)
                }
            }
        }
    }

    override fun dispose() {
        mRegistry.currentState = Lifecycle.State.CREATED
        mRegistry.currentState = Lifecycle.State.DESTROYED
    }

    override fun getLifecycle(): Lifecycle {
        return mRegistry
    }
}