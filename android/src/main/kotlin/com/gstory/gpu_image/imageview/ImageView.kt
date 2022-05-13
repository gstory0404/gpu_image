package com.gstory.gpu_image.imageview

import android.app.Activity
import android.content.Context
import android.net.Uri
import android.os.Environment
import android.util.Log
import android.view.View
import android.view.ViewGroup
import android.widget.FrameLayout
import androidx.camera.lifecycle.ProcessCameraProvider
import androidx.core.content.ContextCompat
import androidx.lifecycle.Lifecycle
import com.gstory.gpu_image.util.FileUtil
import com.gstory.gpu_image.util.FilterTools
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.platform.PlatformView
import jp.co.cyberagent.android.gpuimage.GPUImage
import jp.co.cyberagent.android.gpuimage.GPUImageView
import java.io.File

/**
 * @Author: gstory
 * @CreateDate: 2022/1/26 2:06 下午
 * @Description: 描述
 */

internal class ImageView(
    var context: Context,
    var activity: Activity,
    messenger: BinaryMessenger,
    id: Int,
    params: Map<String?, Any?>
) :
    PlatformView, MethodChannel.MethodCallHandler {

    var width: Double = params["width"] as Double
    var height: Double = params["height"] as Double
    var path: String = params["path"] as String

    private var mContainer = FrameLayout(activity)
    private val gpuImageView: GPUImageView by lazy {
        GPUImageView(activity)
    }
    private var channel: MethodChannel = MethodChannel(messenger, "com.gstory.gpu_image/image_$id")

    init {
        channel.setMethodCallHandler(this)
        mContainer.layoutParams?.width = ViewGroup.LayoutParams.WRAP_CONTENT
        mContainer.layoutParams?.height = ViewGroup.LayoutParams.WRAP_CONTENT
        gpuImageView.layoutParams?.width = width.toInt()
        gpuImageView.layoutParams?.height = height.toInt()
        gpuImageView.setScaleType(GPUImage.ScaleType.CENTER_CROP)
        gpuImageView.setRenderMode(GPUImageView.RENDERMODE_CONTINUOUSLY)
        mContainer.addView(gpuImageView)
        initImage()
    }

    private fun initImage() {
        if (path.startsWith("http")) {
            val imageUri = Uri.parse(path)
            gpuImageView.setImage(imageUri)
        } else {
            var file = File(path)
            gpuImageView.setImage(file)
        }
    }

    override fun getView(): View {
        return mContainer
    }

    override fun dispose() {

    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        if ("setFilter" == call.method) {
            var arguments = call.arguments as Map<*, *>
            var filter = FilterTools.getFilter(arguments)
            if (filter != null) {
                gpuImageView.filter = filter
            }
        } else if ("saveImage" == call.method) {
            val folderName = "GPUImage"
            val fileName = System.currentTimeMillis().toString() + ".jpg"
            gpuImageView.saveToPictures(
                folderName, fileName
            ) { uri ->
                var path: String? = uri.path
                if (!path.isNullOrEmpty()) {
                    //高版本不返回真实路径 需要自己MediaStore转换
                    if (!uri.path!!.endsWith(".jpg")) {
                        path = FileUtil().getRealPathFromURI(activity, uri)
                    }
                    var map: MutableMap<String, Any?> = mutableMapOf("path" to path)
                    channel.invokeMethod("saveImage", map)
                }
            }

        }
    }
}
