part of '../gpu_image.dart';

/// @Author: gstory
/// @CreateDate: 2022/1/26 3:48 下午
/// @Email gstory0404@gmail.com
/// @Description:  Photoshop-like levels adjustmen 类似Photoshop的级别调整

class GPULevelsFilter extends GPUFilter {
  List<double> redMin = [0.0, 1.0, 1.0,0.0,1.0];
  List<double> greenMin = [0.0, 1.0, 1.0,0.0,1.0];
  List<double> blueMin = [0.0, 1.0, 1.0,0.0,1.0];

  /// Photoshop-like levels adjustment.
  /// The minimum, middle, maximum, minOutput and maxOutput parameters are floats in the range [0, 1].
  /// If you have parameters from Photoshop in the range [0, 255] you must first convert them to be [0, 1].
  /// The gamma/mid parameter is a float >= 0. This matches the value from Photoshop.
  /// If you want to apply levels to RGB as well as individual channels you need to use this filter twice - first for the individual channels and then for all channels.
  GPULevelsFilter() {
    type = "levels";
  }

  void setRedMin(
      double min, double mid, double max, double minOut, double maxOut) {
    redMin.clear();
    redMin.add(min);
    redMin.add(mid);
    redMin.add(max);
    redMin.add(minOut);
    redMin.add(maxOut);
  }

  void setGreenMin(
      double min, double mid, double max, double minOut, double maxOut) {
    greenMin.clear();
    greenMin.add(min);
    greenMin.add(mid);
    greenMin.add(max);
    greenMin.add(minOut);
    greenMin.add(maxOut);
  }

  void setBlueMin(
      double min, double mid, double max, double minOut, double maxOut) {
    blueMin.clear();
    blueMin.add(min);
    blueMin.add(mid);
    blueMin.add(max);
    blueMin.add(minOut);
    blueMin.add(maxOut);
  }

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        "type": type,
        "redMin": redMin,
        "greenMin": greenMin,
        "blueMin": blueMin
      };
}
