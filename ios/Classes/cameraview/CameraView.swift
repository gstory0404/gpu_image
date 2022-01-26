//
//  CameraView.swift
//  gpu_image
//
//  Created by 郭维佳 on 2022/1/22.
//

import Foundation
import Flutter
import GPUImage
import AVFoundation

public class CameraView : NSObject,FlutterPlatformView{
    
    
    private var container : UIView
    var frame: CGRect;
    private var channel : FlutterMethodChannel?
    
    var renderView: RenderView!
    var camera:Camera!
    var filter:BasicOperation!
    
    let width : Int
    let height :Int
    //是否正在录制视频
    var isRecording = false
    //录制视频输出
    var movieOutput:MovieOutput? = nil
    //视频路径
    var videoName:String!
    //照片路径
    var photoName:String!
    
    init(_ frame : CGRect,binaryMessenger: FlutterBinaryMessenger , id : Int64, params :Any?) {
        let dict = params as! NSDictionary
        self.frame = frame
        self.container = UIView(frame: frame)
        self.width = Int(dict.value(forKey: "width") as! Double)
        self.height = Int(dict.value(forKey: "height") as! Double)
        super.init()
        self.channel = FlutterMethodChannel.init(name: "com.gstory.gpu_image/camera_" + String(id), binaryMessenger: binaryMessenger)
        initMethodCall()
        renderView = RenderView.init(frame: CGRect.init(x: 0, y: 0, width: self.width, height: self.height))
        startCamera()
        self.container.addSubview(renderView)
    }
    
    //初始化相机
    private func startCamera(){
        do {
            camera = try Camera(sessionPreset: .iFrame1280x720,location: .backFacing)
            camera.runBenchmark = false
            camera --> renderView
            camera.startCapture()
        } catch {
            fatalError("Could not initialize rendering pipeline: \(error)")
        }
    }
    
    public func view() -> UIView {
        return self.container
    }
    
    //切换滤镜
    private func setUpFilter(filter:BasicOperation?){
        self.camera.removeAllTargets()
        self.filter?.removeAllTargets()
        self.renderView.sources.removeAtIndex(0)
        self.filter = filter
        if(self.filter != nil ){
            self.camera --> self.filter --> self.renderView
        }else{
            self.camera  --> self.renderView
        }
    }
    
    
    //拍照
    private func recordPhoto(){
        do {
            // 设置保存路径
            guard let outputPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first else { return }
            self.photoName = String(Int(NSDate().timeIntervalSince1970))+".png"
            let photoUrl = URL(fileURLWithPath: outputPath + "/"+photoName)
            if(self.filter == nil){
                self.camera.saveNextFrameToURL(photoUrl, format: .png)
            }else{
                self.filter.saveNextFrameToURL(photoUrl, format: .png)
            }
            print(photoUrl)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
                //延迟0.5秒执行 可能会出现保存未完成的问题
                let map : NSDictionary = ["path":self.photoName]
                self.channel?.invokeMethod("recordPhoto",arguments: map)
            }
        } catch {
            fatalError("takePhoto, error: \(error)")
        }
        
    }
    
    //录制
    private func recordVideo(){
        if (!isRecording) {
            do {
                self.isRecording = true
                let documentsDir = try FileManager.default.url(for:.documentDirectory, in:.userDomainMask, appropriateFor:nil, create:true)
                self.videoName = String(Int(NSDate().timeIntervalSince1970))+".mp4"
                let videoUrl = URL(string:self.videoName, relativeTo:documentsDir)!
                self.movieOutput = try MovieOutput(URL:videoUrl, size:Size(width:Float(self.width), height:Float(self.height)), liveVideo:true)
                self.camera.audioEncodingTarget = self.movieOutput
                if(self.filter == nil){
                    self.camera --> movieOutput!
                }else{
                    self.camera --> filter --> movieOutput!
                }
                movieOutput!.startRecording()
                let map : NSDictionary = ["recordStatus":"startRecord",
                                          "path":self.videoName]
                self.channel?.invokeMethod("recordVideo",arguments: map)
            } catch {
                fatalError("Couldn't initialize movie, error: \(error)")
            }
        } else {
            movieOutput?.finishRecording{
                self.isRecording = false
                self.camera.audioEncodingTarget = nil
                self.movieOutput = nil
                let map : NSDictionary = ["recordStatus":"endRecord",
                                          "path":self.videoName]
                self.channel?.invokeMethod("recordVideo",arguments: map)
            }
        }
    }
    
    //监听flutter传过来的参数
    private func initMethodCall(){
        self.channel?.setMethodCallHandler { (call, result) in
            print(call.method)
            print(call.arguments)
            switch call.method {
            case "setFilter":
                if(call.arguments == nil){
                    return
                }
                let dict = call.arguments as! NSDictionary
                var filter = FilterUtil().getFilter(dict: dict)
                self.setUpFilter(filter: filter)
                break
            case "switchCamera":
                self.stopCamera()
                if(self.camera.location == .backFacing){
                    do {
                        self.camera = try Camera(sessionPreset: .iFrame960x540,location: .frontFacing)
                        self.camera.runBenchmark = false
                    } catch {
                        fatalError("Could not initialize rendering pipeline: \(error)")
                    }
                }else{
                    do {
                        self.camera = try Camera(sessionPreset: .iFrame1280x720,location: .backFacing)
                        self.camera.runBenchmark = false
                    } catch {
                        fatalError("Could not initialize rendering pipeline: \(error)")
                    }
                }
                self.camera.removeAllTargets()
                if(self.filter != nil){
                    self.filter.removeSourceAtIndex(0)
                }
                self.renderView.sources.removeAtIndex(0)
                if(self.filter != nil ){
                    self.camera --> self.filter --> self.renderView
                }else{
                    self.camera  --> self.renderView
                }
                self.camera.startCapture()
                break
            case "recordPhoto":
                self.recordPhoto()
                break
            case "recordVideo":
                self.recordVideo()
                break
            default:
                break
            }
            
        }
    }
    
    
    //释放相机
    private func stopCamera(){
        self.camera.stopCapture()
    }
    
    private func disposeView() {
        self.stopCamera()
        self.container.removeFromSuperview()
    }
    
}
