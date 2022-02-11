import 'package:flutter/material.dart';

import 'camera_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: IndexPage(),
    );
  }
}

class IndexPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("GpuImage"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("手动到设置中开启相机、相册权限，并重启。\n插件不支持主动开启权限，可以使用使用其他权限插件开启权限"),
            MaterialButton(
              color: Colors.blue,
              textColor: Colors.white,
              child: const Text('相机'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CameraPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
