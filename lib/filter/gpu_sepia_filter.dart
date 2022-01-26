part of '../gpu_image.dart';

/// @Author: gstory
/// @CreateDate: 2022/1/26 3:31 下午
/// @Email gstory0404@gmail.com
/// @Description: sepia 褐色（怀旧）

class GPUSepiaFilter extends GPUFilter {
  double? sepia = 1.0;


  ///sepia value ranges from 0.0 to 1.0, with 1.0 as the normal level
  ///
  ///褐色范围为0.0到1.0，正常值为1.0
  GPUSepiaFilter({this.sepia}) {
    type = "sepia";
  }

  void setPixelation(double sepia) {
    this.sepia = sepia;
  }

  @override
  Map<String, dynamic> toJson() =>
      <String, dynamic>{"type": type, "sepia": sepia};

}

