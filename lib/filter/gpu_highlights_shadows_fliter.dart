part of '../gpu_image.dart';

/// @Author: gstory
/// @CreateDate: 2022/2/11 4:45 下午
/// @Email gstory0404@gmail.com
/// @Description: 调整图片的阴影 高光

class GPUHighlightsShadowsFilter extends GPUFilter {
  double? highlights = 0.0;
  double? shadows = 1.0;

  ///shadows: Increase to lighten shadows, from 0.0 to 1.0, with 0.0 as the default.
  /// highlights: Decrease to darken highlights, from 1.0 to 0.0, with 1.0 as the default.
  GPUHighlightsShadowsFilter({this.highlights, this.shadows}) {
    type = "highlightsShadows";
  }

  void setHighlights(double highlights) {
    this.highlights = highlights;
  }

  void setShadows(double shadows) {
    this.shadows = shadows;
  }

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        "type": type,
        "highlights": highlights,
        "shadows": shadows
      };
}
