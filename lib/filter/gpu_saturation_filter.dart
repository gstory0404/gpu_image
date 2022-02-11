part of '../gpu_image.dart';

/// @Author: gstory
/// @CreateDate: 2022/1/26 3:48 下午
/// @Email gstory0404@gmail.com
/// @Description: saturation 饱和度

class GPUSaturationFilter extends GPUFilter {
  double? saturation = 1.0;

  ///saturation: The degree of saturation or desaturation to apply to the image (0.0 - 2.0, with 1.0 as the default)
  ///
  ///饱和度（取值范围0.0 - 2.0，默认1.0）
  GPUSaturationFilter({this.saturation}) {
    type = "saturation";
  }

  void setaturation(double saturation) {
    this.saturation = saturation;
  }

  @override
  Map<String, dynamic> toJson() =>
      <String, dynamic>{"type": type, "saturation": saturation};
}


