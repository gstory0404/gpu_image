part of '../gpu_image.dart';

/// @Author: gstory
/// @CreateDate: 2022/1/26 2:59 下午
/// @Email gstory0404@gmail.com
/// @Description:  Uses the luminance of the image to mix between two user-specified colors
/// 使用图像的亮度在两种用户指定的颜色之间混合

class GPUFalseColorFilter extends GPUFilter {
  double? fRed = 0.0;
  double? fGreen = 0.0;
  double? fBlue = 0.5;
  double? sRed = 1.0;
  double? sGreen = 0.0;
  double? sBlue = 0.0;

  GPUFalseColorFilter() {
    type = "falseColor";
  }

  ///Set start color
  ///设置开始颜色
  void setFirstColor(double red, double green, double blue) {
    fRed = red;
    fGreen = green;
    fBlue = blue;
  }

  ///Set end color
  ///设置结束颜色
  void setSecondColor(double red, double green, double blue) {
    sRed = red;
    sGreen = green;
    sBlue = blue;
  }

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        "type": type,
        "fRed": fRed,
        "fGreen": fGreen,
        "fBlue": fBlue,
        "sRed": sRed,
        "sGreen": sGreen,
        "sBlue": sBlue
      };
}
