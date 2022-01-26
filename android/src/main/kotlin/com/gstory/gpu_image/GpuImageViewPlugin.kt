package com.gstory.gpu_image

import android.app.Activity
import com.gstory.gpu_image.camera.CameraFactory
import com.gstory.gpu_image.imageview.ImageViewFactory
import io.flutter.embedding.engine.plugins.FlutterPlugin

/**
 * @Author: gstory
 * @CreateDate: 2022/1/20 10:08 上午
 * @Description: 描述
 */

object GpuImageViewPlugin {
    fun registerWith(binding: FlutterPlugin.FlutterPluginBinding, activity : Activity) {
        //注册相机
        binding.platformViewRegistry.registerViewFactory("com.gstory.gpu_image/camera", CameraFactory(binding.binaryMessenger,activity))
        //注册图片
        binding.platformViewRegistry.registerViewFactory("com.gstory.gpu_image/image", ImageViewFactory(binding.binaryMessenger,activity))
    }
}