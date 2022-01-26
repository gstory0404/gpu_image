part of '../gpu_image.dart';

/// @Author: gstory
/// @CreateDate: 2022/1/20 10:13 上午
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class GPUVideoWidget extends StatefulWidget {
  final double? width;
  final double? height;
  final String? path;
  final GPUVideoCallBack? callBack;

  const GPUVideoWidget({
    Key? key,
    this.width,
    this.height,
    this.path,
    this.callBack,
  }) : super(key: key);

  @override
  GPUVideoWidgetState createState() => GPUVideoWidgetState();
}

class GPUVideoWidgetState extends State<GPUVideoWidget> {
  final String _viewType = "com.gstory.gpu_image/video";

  MethodChannel? _channel;

  @override
  void initState() {
    super.initState();
  }

  //设置滤镜
  void setFilter(GPUFilter filter) {
    _channel?.invokeMethod('setFilter', filter.toJson());
  }

  //保存图片
  void saveImage() {
    _channel?.invokeMethod('saveImage', "");
  }


  //播放
  void play() {
    _channel?.invokeMethod('play', "");
  }

  //停止
  void stop() {
    _channel?.invokeMethod('stop', "");
  }

  //注册cannel
  void _registerChannel(int id) {
    _channel = MethodChannel("${_viewType}_$id");
    _channel?.setMethodCallHandler(_platformCallHandler);
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
            "path": widget.path,
          },
          onPlatformViewCreated: _registerChannel,
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
            "path": widget.path,
          },
          onPlatformViewCreated: _registerChannel,
          creationParamsCodec: const StandardMessageCodec(),
        ),
      );
    } else {
      return Container();
    }
  }

  //监听原生view传值
  Future<dynamic> _platformCallHandler(MethodCall call) async {
    switch(call.method){
      case "saveVideo":
        Map map = call.arguments;
        widget.callBack?.saveVideo!(map["path"]);
        break;
    }
  }
}
