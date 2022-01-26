//
//  CameraViewFactory.swift
//  gpu_image
//
//  Created by gstory0404@gmail on 2022/1/22.
//

import Foundation

class CameraViewFactory: NSObject,FlutterPlatformViewFactory {
    private var messenger: FlutterBinaryMessenger

        init(messenger: NSObjectProtocol & FlutterBinaryMessenger) {
            self.messenger = messenger
            super.init()
        }
        
        public func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> FlutterPlatformView {
            return CameraView(frame,  binaryMessenger: self.messenger,id: viewId, params:args)
        }
        
        public func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
            return FlutterStandardMessageCodec.sharedInstance()
        }
}
