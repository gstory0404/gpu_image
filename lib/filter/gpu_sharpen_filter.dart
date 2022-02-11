part of '../gpu_image.dart';

/// @Author: gstory
/// @CreateDate: 2022/1/26 3:39 下午
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述 

class GPUSharpenFilter extends GPUFilter {
  double? sharpen = 0.0;


  ///sepia value ranges from -4.0 to 4.0, with 0.0 as the normal level
  ///
  ///褐色 (取值范围-4.0 - 4.0，默认0.0)
  GPUSharpenFilter({this.sharpen}) {
    type = "sharpen";
  }

  void setSharpen(double sharpen) {
    this.sharpen = sharpen;
  }

  @override
  Map<String, dynamic> toJson() =>
      <String, dynamic>{"type": type, "sharpen": sharpen};

}



