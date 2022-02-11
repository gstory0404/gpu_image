package com.gstory.gpu_image.util

import android.util.Log
import io.flutter.plugin.common.MethodCall
import jp.co.cyberagent.android.gpuimage.filter.*

/**
 * @Author: gstory
 * @CreateDate: 2022/1/20 5:29 下午 * @Description: 描述
 */

object FilterTools {
    fun getFilter(arguments: Map<*, *>): GPUImageFilter? {
        return when (arguments["type"]) {
            //对比度
            "contrast" -> GPUImageContrastFilter((arguments["contrast"] as Double).toFloat())
            //反色
            "colorInvert" -> GPUImageColorInvertFilter()
            //像素化
            "pixelation" -> {
                val fliter = GPUImagePixelationFilter()
                fliter.setPixel((arguments["pixel"] as Double).toFloat())
                return fliter
            }
            //色度
            "hue" -> GPUImageHueFilter((arguments["hue"] as Double).toFloat())
            //亮度
            "brightness" -> GPUImageBrightnessFilter((arguments["brightness"] as Double).toFloat())
            //灰度
            "grayscale" -> GPUImageGrayscaleFilter()
            //褐色（怀旧）
            "sepia" -> GPUImageSepiaToneFilter((arguments["sepia"] as Double).toFloat())
            //锐化
            "sharpen" -> GPUImageSharpenFilter((arguments["sharpen"] as Double).toFloat())
            //饱和度
            "saturation" -> GPUImageSaturationFilter((arguments["saturation"] as Double).toFloat())
            //类似Photoshop的级别调整
            "levels" -> {
                val fliter = GPUImageLevelsFilter()
                var redMin = arguments["redMin"] as ArrayList<Double>
                var greenMin = arguments["greenMin"] as ArrayList<Double>
                var blueMin = arguments["blueMin"] as ArrayList<Double>
                fliter.setRedMin(
                    redMin[0].toFloat(),
                    redMin[1].toFloat(),
                    redMin[2].toFloat(),
                    redMin[3].toFloat(),
                    redMin[4].toFloat()
                )
                fliter.setGreenMin(
                    greenMin[0].toFloat(),
                    greenMin[1].toFloat(),
                    greenMin[2].toFloat(),
                    greenMin[3].toFloat(),
                    greenMin[4].toFloat()
                )
                fliter.setBlueMin(
                    blueMin[0].toFloat(),
                    blueMin[1].toFloat(),
                    blueMin[2].toFloat(),
                    blueMin[3].toFloat(),
                    blueMin[4].toFloat()
                )
                return fliter
            }
            //曝光度
            "exposure" -> GPUImageExposureFilter((arguments["exposure"] as Double).toFloat())
            //RGB修改
            "rgb" -> {
                val fliter = GPUImageRGBFilter()
                fliter.setRed((arguments["red"] as Double).toFloat())
                fliter.setGreen((arguments["green"] as Double).toFloat())
                fliter.setBlue((arguments["blue"] as Double).toFloat())
                return fliter
            }
            //白平衡
            "whiteBalance" -> GPUImageWhiteBalanceFilter(
                (arguments["temperature"] as Double).toFloat(),
                (arguments["tint"] as Double).toFloat()
            )
            //单色
            "secondond" -> GPUImageMonochromeFilter(
                (arguments["intensity"] as Double).toFloat(),
                floatArrayOf(
                    (arguments["red"] as Double).toFloat(),
                    (arguments["green"] as Double).toFloat(),
                    (arguments["blue"] as Double).toFloat(),
                    (arguments["alpha"] as Double).toFloat()
                )
            )
            //指定混色
            "falseColor" -> GPUImageFalseColorFilter(
                (arguments["fRed"] as Double).toFloat(),
                (arguments["fGreen"] as Double).toFloat(),
                (arguments["fBlue"] as Double).toFloat(),
                (arguments["sRed"] as Double).toFloat(),
                (arguments["sGreen"] as Double).toFloat(),
                (arguments["sBlue"] as Double).toFloat()
            )
            //二维三维变换
            "transformOperation" -> GPUImageTransformFilter()
            //伽马值
            "gamma" -> GPUImageGammaFilter((arguments["gamma"] as Double).toFloat())
            //阴影高光
            "highlightsShadows" -> GPUImageHighlightShadowFilter(
                (arguments["shadows"] as Double).toFloat(),
                (arguments["highlights"] as Double).toFloat()
            )
            else -> GPUImageFilter()
        }
    }
}