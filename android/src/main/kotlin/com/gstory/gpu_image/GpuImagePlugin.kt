package com.gstory.gpu_image

import android.app.Activity
import android.content.Context
import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** GpuImagePlugin */
class GpuImagePlugin: FlutterPlugin, MethodCallHandler, ActivityAware {
  private lateinit var channel : MethodChannel
  private var applicationContext: Context? = null
  private var mActivity: Activity? = null
  private var mFlutterPluginBinding: FlutterPlugin.FlutterPluginBinding? = null

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    mActivity = binding.activity
    GpuImageViewPlugin.registerWith(mFlutterPluginBinding!!, mActivity!!)
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    mActivity = binding.activity
  }

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "gpu_image")
    channel.setMethodCallHandler(this)
    applicationContext = flutterPluginBinding.applicationContext
    mFlutterPluginBinding = flutterPluginBinding
  }

  override fun onDetachedFromActivityForConfigChanges() {
    mActivity = null
  }

  override fun onDetachedFromActivity() {
    mActivity = null
  }


  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method == "getPlatformVersion") {
      result.success("Android ${android.os.Build.VERSION.RELEASE}")
    } else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
