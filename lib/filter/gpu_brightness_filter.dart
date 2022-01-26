part of '../gpu_image.dart';

/// @Author: gstory
/// @CreateDate: 2022/1/26 3:09 下午
/// @Email gstory0404@gmail.com
/// @Description: 亮度  Brightness

class GPUBrightnessFilter extends GPUFilter {
  double? brightness = 0.5;

  ///brightness value ranges from 0.0 to 1.0, with 0.5 as the normal level
  ///
  ///亮度取值范围为0-1，默认0.5
  GPUBrightnessFilter({this.brightness}) {
    type = "brightness";
  }

  @override
  Map<String, dynamic> toJson() =>
      <String, dynamic>{"type": type, "brightness": brightness};
}

