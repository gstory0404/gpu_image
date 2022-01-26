//
//  ImageView.swift
//  gpu_image
//
//  Created by 郭维佳 on 2022/1/24.
//

import Foundation
import Flutter
import GPUImage
import AVFoundation

public class ImageView : NSObject,FlutterPlatformView{
    
    private var container : UIView
    var frame: CGRect;
    private var channel : FlutterMethodChannel?
    
    let width : Int
    let height :Int
    let path :String
    
    var renderView: RenderView!
    var filter:BasicOperation!
    var picture:PictureInput!
    
    init(_ frame : CGRect,binaryMessenger: FlutterBinaryMessenger , id : Int64, params :Any?) {
        let dict = params as! NSDictionary
        self.frame = frame
        self.container = UIView(frame: frame)
        self.width = Int(dict.value(forKey: "width") as! Double)
        self.height = Int(dict.value(forKey: "height") as! Double)
        self.path = dict.value(forKey: "path") as! String
        super.init()
        self.channel = FlutterMethodChannel.init(name: "com.gstory.gpu_image/image_" + String(id), binaryMessenger: binaryMessenger)
        self.initMethodCall()
        renderView = RenderView.init(frame: CGRect.init(x: 0, y: 0, width: self.width, height: self.height))
        initPic()
        self.container.addSubview(renderView)
    }
    
    
    private func initPic(){
        print(path)
        if(path.starts(with: "http")){
            let url = NSURL(string: path)
            let data = NSData(contentsOf: url! as URL)
            let image = UIImage(data: data! as Data)
            picture = PictureInput(image:image!)
        }else{
            guard let outputPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first else { return }
            let photoPath = outputPath + "/" + path
            print(photoPath)
            if let image = UIImage(contentsOfFile: photoPath) {
                picture = PictureInput(image:image)
            } else {
                print("文件不存在")
                return
            }
        }
        picture --> renderView
        picture.processImage()
    }
    
    
    public func view() -> UIView {
        return container
    }
    
    
    //切换滤镜
    private func setUpFilter(filter:BasicOperation?){
        if(self.picture == nil){
            return
        }
        self.picture.removeAllTargets()
        self.filter?.removeAllTargets()
        self.renderView.sources.removeAtIndex(0)
        self.filter = filter
        if(self.filter != nil){
            self.picture --> self.filter --> self.renderView
        }else{
            self.picture  --> self.renderView
        }
        picture.processImage()
    }
    
    //保存图片
    private func saveImage(){
        // 设置保存路径
        guard let outputPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first else { return }
        let saveName = String(Int(NSDate().timeIntervalSince1970))+".png"
        let saveUrl = URL(fileURLWithPath: outputPath + "/"+saveName)
        print("开始保存滤镜图片")
        if(self.filter != nil){
            self.filter.saveNextFrameToURL(saveUrl, format: .png)
        }else{
            self.picture.saveNextFrameToURL(saveUrl, format: .png)
        }
        picture.processImage()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            //延迟0.5秒执行 可能会出现保存未完成的问题 
            print(saveUrl)
            let map : NSDictionary = ["path":saveName]
            self.channel?.invokeMethod("saveImage",arguments: map)
        }
    }
    
    //监听flutter传过来的参数
    private func initMethodCall(){
        self.channel?.setMethodCallHandler { (call, result) in
            switch call.method {
            case "setFilter":
                let dict = call.arguments as! NSDictionary
                let filter = FilterUtil().getFilter(dict: dict)
                self.setUpFilter(filter: filter)
                break
            case "saveImage":
                self.saveImage()
                break
            default:
                break
            }
        }
    }
}
