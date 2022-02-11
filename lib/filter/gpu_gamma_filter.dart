part of '../gpu_image.dart';

/// @Author: gstory
/// @CreateDate: 2022/2/11 4:31 下午
/// @Email gstory0404@gmail.com
/// @Description: 修改伽马值

class GPUGammaFilter extends GPUFilter {
  double? gamma = 1.0;

  ///gamma: The gamma adjustment to apply (0.0 - 3.0, with 1.0 as the default)
  ///
  ///伽马值 0.0 - 3.0，默认1.0
  GPUGammaFilter({this.gamma}) {
    type = "gamma";
  }

  void setExposure(double gamma) {
    this.gamma = gamma;
  }

  @override
  Map<String, dynamic> toJson() =>
      <String, dynamic>{"type": type, "gamma": gamma};
}

