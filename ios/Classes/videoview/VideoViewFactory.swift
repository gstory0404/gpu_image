//
//  VideoViewFactory.swift
//  gpu_image
//
//  Created by 郭维佳 on 2022/1/26.
//

import Foundation

class VideoViewFactory: NSObject,FlutterPlatformViewFactory {
    private var messenger: FlutterBinaryMessenger

        init(messenger: NSObjectProtocol & FlutterBinaryMessenger) {
            self.messenger = messenger
            super.init()
        }
        
        public func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> FlutterPlatformView {
            return VideoView(frame,  binaryMessenger: self.messenger,id: viewId, params:args)
        }
        
        public func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
            return FlutterStandardMessageCodec.sharedInstance()
        }
}
