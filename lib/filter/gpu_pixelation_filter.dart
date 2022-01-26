part of '../gpu_image.dart';

/// @Author: gstory
/// @CreateDate: 2022/1/26 3:03 下午
/// @Email gstory0404@gmail.com
/// @Description: pixelation 像素化

class GPUPixelationFilter extends GPUFilter {
  double? pixel = 1.0;

  ///The default is 1.0f
  ///
  ///默认为1.0
  GPUPixelationFilter({this.pixel}) {
    type = "pixelation";
  }

  void setPixelation(double pixel) {
    this.pixel = pixel;
  }

  @override
  Map<String, dynamic> toJson() =>
      <String, dynamic>{"type": type, "pixel": pixel};
}

