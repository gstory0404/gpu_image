package com.gstory.gpu_image.imageview

import android.app.Activity
import android.content.Context
import android.os.Build
import androidx.annotation.RequiresApi
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

/**
 * @Author: gstory
 * @CreateDate: 2022/1/20 10:02 上午
 * @Description: 描述
 */

internal class ImageViewFactory (private val messenger: BinaryMessenger, private val activity: Activity) : PlatformViewFactory(
    StandardMessageCodec.INSTANCE) {
    @RequiresApi(Build.VERSION_CODES.LOLLIPOP)
    override fun create(context: Context, id: Int, args: Any): PlatformView {
        val params = args as Map<String?, Any?>
        return ImageView(context, activity,messenger, id, params)
    }
}