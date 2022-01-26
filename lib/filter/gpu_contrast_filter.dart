part of '../gpu_image.dart';

/// @Author: gstory
/// @CreateDate: 2022/1/26 2:59 下午
/// @Email gstory0404@gmail.com
/// @Description: Contrast  对比度

class GPUContrastFilter extends GPUFilter {
  double? contrast = 1.0;

  ///contrast value ranges from 0.0 to 4.0, with 1.0 as the normal level
  ///
  ///对比度值范围为0.0到4.0，正常值为1.0
  GPUContrastFilter({this.contrast}) {
    type = "contrast";
  }

  void setContrast(double contrast) {
    this.contrast = contrast;
  }

  @override
  Map<String, dynamic> toJson() =>
      <String, dynamic>{"type": type, "contrast": contrast};
}

