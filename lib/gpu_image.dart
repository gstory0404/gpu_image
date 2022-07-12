
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

part 'filter/gpu_brightness_filter.dart';
part 'filter/gpu_colorinvert_filter.dart';
part 'filter/gpu_contrast_filter.dart';
part 'filter/gpu_exposure_filter.dart';
part 'filter/gpu_falsecolor_filter.dart';
//滤镜
part 'filter/gpu_filter.dart';
part 'filter/gpu_gamma_filter.dart';
part 'filter/gpu_grayscale_filter.dart';
part 'filter/gpu_highlights_shadows_fliter.dart';
part 'filter/gpu_hue_filter.dart';
part 'filter/gpu_levels_filter.dart';
part 'filter/gpu_monochrome_filter.dart';
part 'filter/gpu_normal_filter.dart';
part 'filter/gpu_pixelation_filter.dart';
part 'filter/gpu_rgb_filter.dart';
part 'filter/gpu_saturation_filter.dart';
part 'filter/gpu_sepia_filter.dart';
part 'filter/gpu_sharpen_filter.dart';
part 'filter/gpu_whitebalance_filter.dart';
part 'gpu_callback.dart';
part 'gpu_code.dart';
part 'widget/gpu_camera_widget.dart';
part 'widget/gpu_image_widget.dart';
part 'widget/gpu_video_widget.dart';




class GpuImage {
  static const MethodChannel _channel = MethodChannel('gpu_image');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
