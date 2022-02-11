//
//  FilterUtil.swift
//  gpu_image
//
//  Created by 郭维佳 on 2022/1/22.
//

import Foundation
import GPUImage
import CoreImage

class FilterUtil : NSObject{
    
    public func getFilter(dict:NSDictionary) -> BasicOperation?{
        let type: String? = dict.value(forKey: "type") as! String
        switch(type){
            ////对比度
        case "contrast":
            let filter = ContrastAdjustment()
            let contrast = Float(dict.value(forKey: "contrast") as! Double)
            filter.contrast = contrast
            return filter
            //反色
        case "colorInvert":
            return ColorInversion()
            //像素化
        case "pixelation":
            let filter = Pixellate()
            let pixel = Float(dict.value(forKey: "pixel") as! Double)
            filter.fractionalWidthOfAPixel = pixel
            return filter
            //色度
        case "hue":
            let filter = HueAdjustment()
            let hue = Float(dict.value(forKey: "hue") as! Double)
            filter.hue = hue
            return filter
            //亮度
        case "brightness":
            let filter = BrightnessAdjustment()
            let brightness = Float(dict.value(forKey: "brightness") as! Double)
            filter.brightness = brightness
            return filter
            //灰度
        case "grayscale":
            return Luminance()
            //褐色
        case "sepia":
            return SepiaToneFilter()
            //锐化
        case "sharpen":
            let filter = Sharpen()
            let sharpen = Float(dict.value(forKey: "sharpen") as! Double)
            filter.sharpness = sharpen
            return filter
            //饱和度
        case "saturation":
            let filter = SaturationAdjustment()
            let saturation = Float(dict.value(forKey: "saturation") as! Double)
            filter.saturation = saturation
            return filter
            //类似Photoshop的级别调整
        case "levels":
            let filter = LevelsAdjustment()
            let redMin = dict.value(forKey: "redMin") as! NSArray
            let greenMin = dict.value(forKey: "greenMin") as! NSArray
            let blueMin = dict.value(forKey: "blueMin") as! NSArray
            filter.minimum = Color(red: Float(redMin[0] as! Double), green: Float(greenMin[0] as! Double), blue: Float(blueMin[0] as! Double))
            filter.middle = Color(red: Float(redMin[1] as! Double), green: Float(greenMin[1] as! Double), blue: Float(blueMin[1] as! Double))
            filter.maximum = Color(red: Float(redMin[2] as! Double), green: Float(greenMin[2] as! Double), blue: Float(blueMin[2] as! Double))
            filter.minOutput = Color(red: Float(redMin[3] as! Double), green: Float(greenMin[3] as! Double), blue: Float(blueMin[3] as! Double))
            filter.maxOutput = Color(red: Float(redMin[4] as! Double), green: Float(greenMin[4] as! Double), blue: Float(blueMin[4] as! Double))
            return filter
            //曝光度
        case "exposure":
            let filter = ExposureAdjustment()
            let exposure = Float(dict.value(forKey: "exposure") as! Double)
            filter.exposure = exposure
            return filter
            //RGB
        case "rgb":
            let filter = RGBAdjustment()
            filter.red = Float(dict.value(forKey: "red") as! Double)
            filter.green = Float(dict.value(forKey: "green") as! Double)
            filter.blue = Float(dict.value(forKey: "blue") as! Double)
            return filter
            //白平衡
        case "whiteBalance":
            let filter = WhiteBalance()
            filter.temperature = Float(dict.value(forKey: "temperature") as! Double)
            filter.tint = Float(dict.value(forKey: "tint") as! Double)
            return filter
           //单色
        case "monochrome":
            let filter = MonochromeFilter()
            filter.intensity = Float(dict.value(forKey: "intensity") as! Double)
            filter.color = Color(red: Float(dict.value(forKey: "red") as! Double),
                                 green: Float(dict.value(forKey: "green") as! Double),
                                 blue: Float(dict.value(forKey: "blue") as! Double),
                                 alpha:  Float(dict.value(forKey: "alpha") as! Double))
            return filter
            //指定混色
         case "falseColor":
             let filter = FalseColor()
             filter.firstColor = Color(red: Float(dict.value(forKey: "fRed") as! Double),
                                  green: Float(dict.value(forKey: "fGreen") as! Double),
                                  blue: Float(dict.value(forKey: "fBlue") as! Double))
            filter.secondColor = Color(red: Float(dict.value(forKey: "sRed") as! Double),
                                 green: Float(dict.value(forKey: "sGreen") as! Double),
                                 blue: Float(dict.value(forKey: "sBlue") as! Double))
             return filter
            //指定混色
         case "transformOperation":
             let filter = TransformOperation()
//             filter.transform = Matrix4x4.init(CATransform3D)
             return filter
            //伽马值
         case "gamma":
             let filter = GammaAdjustment()
            filter.gamma = Float(dict.value(forKey: "gamma") as! Double)
             return filter
            //阴影高光
         case "highlightsShadows":
             let filter = HighlightsAndShadows()
            filter.shadows = Float(dict.value(forKey: "shadows") as! Double)
            filter.highlights = Float(dict.value(forKey: "highlights") as! Double)
             return filter
        default:
            return nil
        }
    }
}
