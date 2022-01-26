//
//  VideoView.swift
//  gpu_image
//
//  Created by 郭维佳 on 2022/1/26.
//

import Foundation

import Foundation
import Flutter
import GPUImage
import AVFoundation

public class VideoView : NSObject,FlutterPlatformView{
    
    private var container : UIView
    var frame: CGRect;
    private var channel : FlutterMethodChannel?
    
    let width : Int
    let height :Int
    let path :String
    
    var renderView: RenderView!
    var filter:BasicOperation!
    var movie:MovieInput!
    
    init(_ frame : CGRect,binaryMessenger: FlutterBinaryMessenger , id : Int64, params :Any?) {
        let dict = params as! NSDictionary
        self.frame = frame
        self.container = UIView(frame: frame)
        self.width = Int(dict.value(forKey: "width") as! Double)
        self.height = Int(dict.value(forKey: "height") as! Double)
        self.path = dict.value(forKey: "path") as! String
        super.init()
        self.channel = FlutterMethodChannel.init(name: "com.gstory.gpu_image/video_" + String(id), binaryMessenger: binaryMessenger)
        self.initMethodCall()
        renderView = RenderView.init(frame: CGRect.init(x: 0, y: 0, width: self.width, height: self.height))
        initVideo()
        self.container.addSubview(renderView)
    }
    
    
    private func initVideo(){
        print(path)
        var movieURL : URL?
        if(path.starts(with: "http")){
            movieURL = URL(string: path)
        }else{
            guard let directory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first else { return }
            movieURL = URL(fileURLWithPath: directory + "/" + path)
        }
        if(movieURL == nil){
            print("movieURL is nil")
           return
        }
        do {
            movie = try MovieInput(url:movieURL!, playAtActualSpeed:true)
            if(filter == nil){
                movie --> renderView
            }else{
                movie --> filter --> renderView
            }
            movie.runBenchmark = false
            movie.start()
        } catch {
            print("Couldn't process movie with error: \(error)")
        }
    }
    
    
    public func view() -> UIView {
        return container
    }
    
    
    //切换滤镜
    private func setUpFilter(filter:BasicOperation?){
        if(self.movie == nil){
            return
        }
//        movie.cancel()
        self.movie.removeAllTargets()
        self.filter?.removeAllTargets()
        self.renderView.sources.removeAtIndex(0)
        self.filter = filter
        if(self.filter != nil){
            self.movie --> self.filter --> self.renderView
        }else{
            self.movie  --> self.renderView
        }
    }
    
    //播放视频
    private func playVideo(){
        if(self.movie == nil){
            return
        }
        self.movie.removeAllTargets()
        self.filter?.removeAllTargets()
        self.renderView.sources.removeAtIndex(0)
        if(self.filter != nil){
            self.movie --> self.filter --> self.renderView
        }else{
            self.movie  --> self.renderView
        }
        movie.start()
    }
    
    //停止播放
    private func stopVideo(){
        if(self.movie == nil){
            return
        }
        movie.removeAllTargets()
    }
    
    //保存图片
    private func saveImage(){
        // 设置保存路径
        guard let outputPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first else { return }
        let saveName = String(Int(NSDate().timeIntervalSince1970))+".mp4"
        let saveUrl = URL(fileURLWithPath: outputPath + "/"+saveName)
        print("开始保存滤镜图片")
        if(self.filter != nil){
            self.filter.saveNextFrameToURL(saveUrl, format: .png)
        }else{
            self.movie.saveNextFrameToURL(saveUrl, format: .png)
        }
//        picture.processImage()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            //延迟0.5秒执行 可能会出现保存未完成的问题
            print(saveUrl)
            let map : NSDictionary = ["path":saveName]
            self.channel?.invokeMethod("saveVideo",arguments: map)
        }
    }
    
    //监听flutter传过来的参数
    private func initMethodCall(){
        self.channel?.setMethodCallHandler { (call, result) in
            switch call.method {
            case "play":
                self.playVideo()
                break
            case "stop":
                self.stopVideo()
                break
            case "setFilter":
                let dict = call.arguments as! NSDictionary
                let filter = FilterUtil().getFilter(dict: dict)
                self.setUpFilter(filter: filter)
                break
            case "saveVideo":
                self.saveImage()
                break
            default:
                break
            }
        }
    }
}
