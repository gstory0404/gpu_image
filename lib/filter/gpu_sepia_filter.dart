part of '../gpu_image.dart';

/// @Author: gstory
/// @CreateDate: 2022/1/26 3:31 下午
/// @Email gstory0404@gmail.com
/// @Description: sepia 褐色（怀旧）

class GPUSepiaFilter extends GPUFilter {
  double? sepia = 1.0;


  ///sepia value ranges from 0.0 to 1.0, with 1.0 as the normal level
  ///
  ///褐色 (取值范围0.0 - 2.0，默认1.0)
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

