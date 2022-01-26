part of '../gpu_image.dart';

/// @Author: gstory
/// @CreateDate: 2022/1/26 3:03 下午
/// @Email gstory0404@gmail.com
/// @Description: rgb rgb

class GPURGBFilter extends GPUFilter {
  double? red = 1.0;
  double? green = 1.0;
  double? blue = 1.0;

  ///Adjusts the individual RGB channels of an image red: Normalized values by which each color channel is multiplied. The range is from 0.0 up, with 1.0 as the default.
  ///
  ///调整图像的各个RGB通道红色：每个颜色通道乘以的标准化值。范围为0.0以上，默认值为1.0
  GPURGBFilter({this.red, this.green, this.blue}) {
    type = "rgb";
  }

  void setRGB(double red, double green, double blue) {
    this.red = red;
    this.green = green;
    this.blue = blue;
  }

  @override
  Map<String, dynamic> toJson() =>
      <String, dynamic>{"type": type, "red": red, "green": green, "blue": blue};
}
