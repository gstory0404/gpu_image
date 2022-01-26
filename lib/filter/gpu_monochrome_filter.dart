part of '../gpu_image.dart';

/// @Author: gstory
/// @CreateDate: 2022/1/26 3:03 下午
/// @Email gstory0404@gmail.com
/// @Description: Converts the image to a single-color version, based on the luminance of each pixel
/// 根据每个像素的亮度将图像转换为单色版本

class GPUMonochromeFilter extends GPUFilter {
  double? intensity = 1.0;
  double? red = 0.6;
  double? green = 0.45;
  double? blue = 0.3;
  double? alpha = 0.1;

  /// intensity: The degree to which the specific color replaces the normal image color (0.0 - 1.0, with 1.0 as the default)
  /// color: The color to use as the basis for the effect, with (0.6, 0.45, 0.3, 1.0) as the default.
  GPUMonochromeFilter(
      {this.intensity, this.red, this.green, this.blue, this.alpha}) {
    type = "monochrome";
  }

  void setIntensity(double intensity) {
    this.intensity = intensity;
  }

  void setColor(double red, double green, double blue, double alpha) {
    this.red = red;
    this.green = green;
    this.blue = blue;
    this.alpha = alpha;
  }

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        "type": type,
        "intensity": intensity,
        "red": red,
        "green": green,
        "blue": blue,
        "alpha": alpha
      };
}
