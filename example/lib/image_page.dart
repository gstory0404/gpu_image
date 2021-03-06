import 'package:flutter/material.dart';
import 'package:gpu_image/gpu_image.dart';
import 'package:gpu_image_example/filter_list.dart';

/// @Author: gstory
/// @CreateDate: 2022/1/24 3:27 下午
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class ImagePage extends StatefulWidget {
  final String path;

  const ImagePage({Key? key, required this.path}) : super(key: key);

  @override
  _ImagePageState createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  final GlobalKey<GPUImageWidgetState> imageKey = GlobalKey();
  final GPUImageController _controller = GPUImageController();

  @override
  void initState() {
    super.initState();
    _controller.saveListen((path){
      print("保存图片地址 $path");
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ImagePage(path: path)));
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Iamge"),
        centerTitle: true,
        actions: [
          InkWell(
            child: Text("save"),
            onTap: () {
              _controller.saveImage();
            },
          )
        ],
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          GPUImageWidget(
            key: imageKey,
            width: 400,
            height: 600,
            path: widget.path,
            controller: _controller,
          ),
          Positioned(
              bottom: 160,
              child: FilterList(
                callBack: (filter) {
                  _controller.setFilter(filter);
                },
              )),
        ],
      ),
    );
  }
}
