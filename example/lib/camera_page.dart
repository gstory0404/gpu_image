import 'package:flutter/material.dart';
import 'package:gpu_image/gpu_image.dart';
import 'package:gpu_image_example/filter_list.dart';
import 'package:gpu_image_example/image_page.dart';
import 'package:gpu_image_example/video_page.dart';

/// @Author: gstory
/// @CreateDate: 2022/1/20 10:22 上午
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  final GPUCameraController _controller = GPUCameraController();

  @override
  void initState() {
    super.initState();
    _controller.photoListen((path) {
      print("拍照保存地址 $path");
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ImagePage(path: path)));
    });
    _controller.videoListen((recordStatus, path) {
      if(recordStatus == GPUType.startRecord){
        print("开始录制");
      }else{
        print("录制结束 保存地址 $path");
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => VideoPage(path: path)));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          GPUCameraWidget(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            controller: _controller,
          ),
          Positioned(
            bottom: 50,
            left: 30,
            right: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  width: 50,
                  height: 50,
                ),
                GestureDetector(
                  onTap: (){
                    _controller.recordPhoto();
                  },
                  // onLongPressStart: (d){
                  //   _controller.recordVideo();
                  // },
                  // onLongPressEnd: (d){
                  //   _controller.recordVideo();
                  // },
                  child: Image.asset(
                    "assets/images/take_photo.png",
                    width: 70,
                    height: 70,
                    fit: BoxFit.cover,
                    color: ThemeData().primaryColor,
                  ),
                ),
                InkWell(
                  onTap: () {
                    _controller.switchCamera();
                  },
                  child: Image.asset(
                    "assets/images/check_camera.png",
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                    color: ThemeData().primaryColor,
                  ),
                )
              ],
            ),
          ),

          Positioned(
              bottom: 160,
              child: Column(
                children: [
                  FilterList(
                    callBack: (filter){
                      _controller.setFilter(filter);
                    },
                  ),
                  // SeekToWidget(
                  //   value: 0,
                  //   onChange: (value) {
                  //     // _controller
                  //     //     ?.setProgress( (1).toInt());
                  //   },
                  // )
                ],
              )),
        ],
      ),
    );
  }
}
