part of '../gpu_image.dart';

/// @Author: gstory
/// @CreateDate: 2022/1/26 2:59 下午
/// @Email gstory0404@gmail.com
/// @Description: Contrast  对比度

class GPUExposureFilter extends GPUFilter {
  double? exposure = 0.0;

  ///exposure: The adjusted exposure (-10.0 - 10.0, with 0.0 as the default)
  ///
  ///曝光度 -10.0 - 10.0，默认0.0
  GPUExposureFilter({this.exposure}) {
    type = "exposure";
  }

  void setExposure(double exposure) {
    this.exposure = exposure;
  }

  @override
  Map<String, dynamic> toJson() =>
      <String, dynamic>{"type": type, "exposure": exposure};
}
