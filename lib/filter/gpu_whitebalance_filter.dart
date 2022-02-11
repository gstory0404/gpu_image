part of '../gpu_image.dart';

/// @Author: gstory
/// @CreateDate: 2022/1/26 3:39 下午
/// @Email gstory0404@gmail.com
/// @Description: 色温

class GPUWhiteBalanceFilter extends GPUFilter {
  double? temperature = 5000;
  double? tint = 0;

  ///temperature: The temperature to adjust the image by, in ºK.
  ///A value of 4000 is very cool and 7000 very warm.
  ///The default value is 5000.
  /// Note that the scale between 4000 and 5000 is nearly as visually significant as that between 5000 and 7000.
  // tint: The tint to adjust the image by. A value of -200 is very green and 200 is very pink. The default value is 0.
  GPUWhiteBalanceFilter({this.temperature,this.tint}) {
    type = "whiteBalance";
  }

  void setTemperature(double temperature) {
    this.temperature = temperature;
  }

  void setTint(double tint) {
    this.tint = tint;
  }

  @override
  Map<String, dynamic> toJson() =>
      <String, dynamic>{"type": type, "temperature": temperature, "tint": tint};

}



