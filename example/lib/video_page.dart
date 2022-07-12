import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gpu_image/gpu_image.dart';
import 'package:gpu_image_example/filter_list.dart';

/// @Author: gstory
/// @CreateDate: 2022/1/24 3:27 下午
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class VideoPage extends StatefulWidget {
  final String path;

  const VideoPage({Key? key, required this.path}) : super(key: key);

  @override
  _ImagePageState createState() => _ImagePageState();
}

class _ImagePageState extends State<VideoPage> {
  final GPUVideoController _controller = GPUVideoController();

  @override
  void initState() {
    super.initState();
    _controller.saveListen((path){
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => VideoPage(path: path)));
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
      body: Column(
        children: [
          GPUVideoWidget(
            controller: _controller,
            width: 400,
            height: 400,
            path: widget.path,
          ),
          FilterList(
            callBack: (filter) {
              _controller.setFilter(filter);
            },
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  _controller.play();
                },
                child: const Text("Play"),
              ),
              TextButton(
                onPressed: () {
                  _controller.stop();
                },
                child: const Text("Stop"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
