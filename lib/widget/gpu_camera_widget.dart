part of '../gpu_image.dart';

/// @Author: gstory
/// @CreateDate: 2022/1/20 10:13 上午
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class GPUCameraWidget extends StatefulWidget {
  final double? width;
  final double? height;
  final GPUCameraController? controller;

  const GPUCameraWidget({Key? key, this.width, this.height, this.controller})
      : super(key: key);

  @override
  GPUCameraWidgetState createState() => GPUCameraWidgetState();
}

class GPUCameraWidgetState extends State<GPUCameraWidget> {
  final String _viewType = "com.gstory.gpu_image/camera";

  //注册controller
  void _onPlatformViewCreated(int id) {
    widget.controller?.init(id, _viewType);
  }

  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return SizedBox(
        width: widget.width ?? MediaQuery.of(context).size.width,
        height: widget.height ?? MediaQuery.of(context).size.height,
        child: AndroidView(
          viewType: _viewType,
          creationParams: {
            "width": widget.width ?? MediaQuery.of(context).size.width,
            "height": widget.height ?? MediaQuery.of(context).size.height,
          },
          onPlatformViewCreated: _onPlatformViewCreated,
          creationParamsCodec: const StandardMessageCodec(),
        ),
      );
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      return SizedBox(
        width: widget.width ?? MediaQuery.of(context).size.width,
        height: widget.height ?? MediaQuery.of(context).size.height,
        child: UiKitView(
          viewType: _viewType,
          creationParams: {
            "width": widget.width ?? MediaQuery.of(context).size.width,
            "height": widget.height ?? MediaQuery.of(context).size.height,
          },
          onPlatformViewCreated: _onPlatformViewCreated,
          creationParamsCodec: const StandardMessageCodec(),
        ),
      );
    } else {
      return Container();
    }
  }
}

class GPUCameraController {
  MethodChannel? _methodChannel;

  //是否后置摄像头
  bool? isBackamera = true;

  RecordPhoto? _recordPhoto;
  RecordVideo? _recordVideo;

  init(int id, String viewType) {
    _methodChannel = MethodChannel("${viewType}_$id");
    _methodChannel?.setMethodCallHandler(_platformCallHandler);
  }

  ///设置滤镜
  void setFilter(GPUFilter filter) {
    _methodChannel?.invokeMethod('setFilter', filter.toJson());
  }

  ///切换摄像头
  void switchCamera() {
    _methodChannel?.invokeMethod('switchCamera', '');
  }

  ///录制拍照
  void recordPhoto() {
    _methodChannel?.invokeMethod('recordPhoto', '');
  }

  ///录制视频
  void recordVideo() {
    _methodChannel?.invokeMethod('recordVideo', '');
  }

  ///监听拍照
  void photoListen(RecordPhoto recordPhoto) {
    _recordPhoto = recordPhoto;
  }

  ///监听录制
  void videoListen(RecordVideo recordVideo) {
    _recordVideo = recordVideo;
  }

  //监听原生view传值
  Future<dynamic> _platformCallHandler(MethodCall call) async {
    switch (call.method) {
      case "recordPhoto":
        Map map = call.arguments;
        if (_recordPhoto != null) {
          _recordPhoto!(map["path"]);
        }
        break;
      case "recordVideo":
        Map map = call.arguments;
        if (_recordVideo != null) {
          _recordVideo!(map["recordStatus"], map["path"]);
        }
        break;
    }
  }
}
