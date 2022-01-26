import Flutter
import UIKit

public class SwiftGpuImagePlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "gpu_image", binaryMessenger: registrar.messenger())
        let instance = SwiftGpuImagePlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
        //注册cameraview
        let cameraViewFactory = CameraViewFactory(messenger: registrar.messenger())
        registrar.register(cameraViewFactory, withId: "com.gstory.gpu_image/camera")
        //注册iamgeview
        let imageViewFactory = ImageViewFactory(messenger: registrar.messenger())
        registrar.register(imageViewFactory, withId: "com.gstory.gpu_image/image")
        //注册videoview
        let videoViewFactory = VideoViewFactory(messenger: registrar.messenger())
        registrar.register(videoViewFactory, withId: "com.gstory.gpu_image/video")
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        result("iOS " + UIDevice.current.systemVersion)
    }
}
