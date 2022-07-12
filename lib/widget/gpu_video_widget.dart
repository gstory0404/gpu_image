part of '../gpu_image.dart';

/// @Author: gstory
/// @CreateDate: 2022/1/20 10:13 上午
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class GPUVideoWidget extends StatefulWidget {
  final double? width;
  final double? height;
  final String? path;
  final GPUVideoController? controller;

  const GPUVideoWidget({
    Key? key,
    this.width,
    this.height,
    this.path,
    this.controller,
  }) : super(key: key);

  @override
  GPUVideoWidgetState createState() => GPUVideoWidgetState();
}

class GPUVideoWidgetState extends State<GPUVideoWidget> {
  final String _viewType = "com.gstory.gpu_image/video";

  @override
  void initState() {
    super.initState();
  }

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
            "path": widget.path,
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
            "path": widget.path,
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

class GPUVideoController{
  late MethodChannel _methodChannel;

  SaveVideo? _saveCallBack;

  init(int id,String viewType){
    _methodChannel = MethodChannel("${viewType}_$id");
    _methodChannel.setMethodCallHandler(_platformCallHandler);
  }

  ///设置滤镜
  void setFilter(GPUFilter filter) {
    _methodChannel.invokeMethod('setFilter', filter.toJson());
  }

  ///保存图片
  void saveImage() {
    _methodChannel.invokeMethod('saveImage', "");
  }


  ///播放
  void play() {
    _methodChannel.invokeMethod('play', "");
  }

  ///停止
  void stop() {
    _methodChannel.invokeMethod('stop', "");
  }


  ///保存结果监听
  void saveListen(dynamic saveImage){
    _saveCallBack = saveImage;
  }

  ///监听原生view传值
  Future<dynamic> _platformCallHandler(MethodCall call) async {
    switch(call.method){
      case "saveVideo":
        Map map = call.arguments;
        if(_saveCallBack != null){
          _saveCallBack!(map["path"]);
        }
        break;
    }
  }
}
