part of '../gpu_image.dart';

/// @Author: gstory
/// @CreateDate: 2022/1/26 3:04 下午
/// @Email gstory0404@gmail.com
/// @Description: pixelation 色度

class GPUHueFilter extends GPUFilter {
  double? hue = 90.0;

  ///The default is 90.0
  ///
  ///默认为90.0
  GPUHueFilter({this.hue}) {
    type = "hue";
  }

  void setHue(double hue) {
    this.hue = hue;
  }

  @override
  Map<String, dynamic> toJson() =>
      <String, dynamic>{"type": type, "hue": hue};
}

