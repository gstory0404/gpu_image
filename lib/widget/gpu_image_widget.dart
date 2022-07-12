part of '../gpu_image.dart';

/// @Author: gstory
/// @CreateDate: 2022/1/20 10:13 上午
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class GPUImageWidget extends StatefulWidget {
  final double? width;
  final double? height;
  final String? path;
  final GPUImageController? controller;

  const GPUImageWidget({
    Key? key,
    this.width,
    this.height,
    this.path,
    this.controller,
  }) : super(key: key);

  @override
  GPUImageWidgetState createState() => GPUImageWidgetState();
}

class GPUImageWidgetState extends State<GPUImageWidget> {
  final String _viewType = "com.gstory.gpu_image/image";

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

class GPUImageController{
   MethodChannel? _methodChannel;

  SaveImage? _saveCallBack;

  init(int id,String viewType){
    _methodChannel = MethodChannel("${viewType}_$id");
    _methodChannel?.setMethodCallHandler(_platformCallHandler);
  }

  ///设置滤镜
  void setFilter(GPUFilter filter) {
    _methodChannel?.invokeMethod('setFilter', filter.toJson());
  }

  ///保存图片
  void saveImage() {
    _methodChannel?.invokeMethod('saveImage', "");
  }

  ///保存结果监听
  void saveListen(dynamic saveImage){
    _saveCallBack = saveImage;
  }


  //监听原生view传值
  Future<dynamic> _platformCallHandler(MethodCall call) async {
    switch(call.method){
      case "saveImage":
        Map map = call.arguments;
        if(_saveCallBack != null){
          _saveCallBack!(map["path"]);
        }
        break;
    }
  }
}
