import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gpu_image/gpu_image.dart';

/// @Author: gstory
/// @CreateDate: 2022/1/20 6:36 下午
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述 

class FilterList extends StatelessWidget {
  final callBack;

  const FilterList({Key? key,required this.callBack}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: ListView(
        shrinkWrap: false,
        scrollDirection: Axis.horizontal,
        children: [
          TextButton(
              onPressed: () {
                callBack(GPUNormalFilter());
              },
              child: const Text("正常")),
          TextButton(
              onPressed: () {
                callBack(GPUContrastFilter(contrast: 4.0));
              },
              child: const Text("对比度")),
          TextButton(
              onPressed: () {
                callBack(GPUColorInvertFilter());
              },
              child: const Text("反色")),
          TextButton(
              onPressed: () {
                callBack(GPUPixelationFilter(pixel: 10.0));
              },
              child: const Text("像素化")),
          TextButton(
              onPressed: () {
                callBack(GPUHueFilter(hue: 100.0));
              },
              child: const Text("色度")),
          TextButton(
              onPressed: () {
                callBack(GPUBrightnessFilter(brightness: 0.6));
              },
              child: const Text("亮度")),
          TextButton(
              onPressed: () {
                callBack(GPUGrayscaleFilter());
              },
              child: const Text("灰度")),
          TextButton(
              onPressed: () {
                callBack(GPUSepiaFilter(sepia: 0.5));
              },
              child: const Text("褐色")),
          TextButton(
              onPressed: () {
                callBack(GPUSharpenFilter(sharpen: 1.0));
              },
              child: const Text("锐化")),
          TextButton(
              onPressed: () {
                callBack(GPUSaturationFilter(saturation: 1.0));
              },
              child: const Text("饱和度")),
          TextButton(
              onPressed: () {
                var filter = GPULevelsFilter();
                filter.setRedMin(0.0, 1.0, 1.0, 0.0, 1.0);
                filter.setGreenMin(0.0, 1.0, 1.0, 0.0, 1.0);
                filter.setBlueMin(0.0, 1.0, 1.0, 1.0, 1.0);
                callBack(filter);
              },
              child: const Text("色彩级别")),
          TextButton(
              onPressed: () {
                callBack(GPUExposureFilter(exposure: 1.0));
              },
              child: const Text("曝光")),
          TextButton(
              onPressed: () {
                callBack(GPURGBFilter(red: 1.0,green: 0.5,blue: 1.0));
              },
              child: const Text("RGB")),
          TextButton(
              onPressed: () {
                callBack(GPUWhiteBalanceFilter(temperature: 6000,tint: 100));
              },
              child: const Text("白平衡")),
          TextButton(
              onPressed: () {
                callBack(GPUMonochromeFilter(intensity: 0.8,red: 0.5,green: 0.6,blue: 0.8,alpha: 0.8));
              },
              child: const Text("单色")),
          TextButton(
              onPressed: () {
                var filter = GPUFalseColorFilter();
                filter.setFirstColor(0.5, 0.6, 1.0);
                filter.setSecondColor(1.0, 0.1, 0.2);
                callBack(filter);
              },
              child: const Text("指定混色")),
          TextButton(
              onPressed: () {
                callBack(GPUGammaFilter(gamma: 1.5));
              },
              child: const Text("伽马值")),
          TextButton(
              onPressed: () {
                callBack(GPUHighlightsShadowsFilter(highlights: 1.5,shadows: 0.5));
              },
              child: const Text("阴影高光")),
        ],
      ),
    );
  }
}


