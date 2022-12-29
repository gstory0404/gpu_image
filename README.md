# GPUImage for Flutter

<p>
<a href="https://pub.flutter-io.cn/packages/gpu_image"><img src=https://img.shields.io/pub/v/gpu_image?color=orange></a>
<a href="https://pub.flutter-io.cn/packages/gpu_image"><img src=https://img.shields.io/pub/likes/gpu_image></a>
<a href="https://pub.flutter-io.cn/packages/gpu_image"><img src=https://img.shields.io/pub/points/gpu_image></a>
<a href="https://github.com/gstory0404/gpu_image/commits"><img src=https://img.shields.io/github/last-commit/gstory0404/gpu_image></a>
<a href="https://github.com/gstory0404/gpu_image"><img src=https://img.shields.io/github/stars/gstory0404/gpu_image></a>
</p>

Flutter中相机、照片、视频添加各种滤镜效果。[体验demo](https://www.pgyer.com/29vy)

## 感谢
- [android-gpuimage](https://github.com/cats-oss/android-gpuimage)
- [GPUImage2](https://github.com/BradLarson/GPUImage2)



## 本地环境
```dart
[✓] Flutter (Channel stable, 3.0.0, on macOS 12.3.1 21E258 darwin-x64, locale zh-Hans-CN)
[✓] Android toolchain - develop for Android devices (Android SDK version 33.0.0-rc1)
[✓] Xcode - develop for iOS and macOS (Xcode 13.3.1)
[✓] Chrome - develop for the web
[✓] Android Studio (version 2021.1)
[✓] VS Code (version 1.66.2)
[✓] Connected device (4 available)
[✓] HTTP Host Availability
```

## 集成步骤

### 1、pubspec.yaml
```dart
gpu_image: ^1.0.0
```

### 2、引入
```dart
import 'package:gpu_image/gpu_image.dart';
```

## 相机
```dart
final GlobalKey<GPUCameraWidgetState> cameraKey = GlobalKey();
//相机widget
GPUCameraWidget(
            key: cameraKey,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            cameraCallBack: GPUCameraCallBack(
              recordPhoto: (path){
                print("拍照保存地址 $path");
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ImagePage(path: path)));
              }
            ),
          ),

//拍照
cameraKey.currentState?.recordPhoto();
//切换摄像头
cameraKey.currentState?.switchCamera();
//设置滤镜
cameraKey.currentState?.setFilter(filter);
```

## 图片
```dart
final GlobalKey<GPUImageWidgetState> imageKey = GlobalKey();
GPUImageWidget(
    key: imageKey,
    width: 400,
    height: 600,
    path: widget.path,
    callBack: GPUImageCallBack(
        saveImage: (path){
          print("保存图片地址 $path")
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ImagePage(path: path)));
        }
    ),
),
//设置滤镜
imageKey.currentState?.setFilter(filter);
//保存图片
imageKey.currentState?.saveImage();
```

## 滤镜

- [x] GPUNormalFilter
  无滤镜

- [x] GPUBrightnessFilter 
  亮度
  brightness 取值范围为0-1，默认0.5

- [x] GPUColorInvertFilter
  反色

- [x] GPUContrastFilter
  对比度
  contrast 取值范围为0.0到4.0，正常值为1.0

- [x] GPUExposureFilter
  曝光度
  exposure 取值范围为-10.0到 - 10.0，正常值为0.0

- [x] GPUFalseColorFilter
  颜色混合
  fRed 取值0.0-1.0
  fGreen 取值0.0-1.0
  fBlue 取值0.0-1.0
  sRed 取值0.0-1.0
  sGreen 取值0.0-1.0
  sBlue 取值0.0-1.0

- [x] GPUGammaFilter
  伽马值
  gamma 取值范围0.0 - 3.0，默认1.0

- [x] GPUGrayscaleFilter
  灰度

- [x] GPUHighlightsShadowsFilter
  阴影高光
  shadows 取值范围0.0 - 1.0，默认1.0
  highlights 取值范围0.0 - 1.0，默认0.0

- [x] GPUHueFilter
  色度
  hue 默认90.0

- [x] GPULevelsFilter
  类似Photoshop的级别调整
  redMin 默认 [0.0, 1.0, 1.0,0.0,1.0];
  greenMin 默认 [0.0, 1.0, 1.0,0.0,1.0];
  blueMin 默认 [0.0, 1.0, 1.0,0.0,1.0];

- [x] GPUMonochromeFilter
  根据每个像素的亮度将图像转换为单色版本
  intensity 特定颜色替换正常图像颜色的程度（0.0-1.0，默认为1.0）
  red、green、blue、alpha用作效果基础的颜色，默认为（0.6,0.45,0.3,1.0）。

- [x] GPUPixelationFilter
  像素化
  pixel 默认为1.0

- [x] GPURGBFilter
  调整图像的各个RGB
  red （取值范围0.0 - 1.0，默认1.0
  green （取值范围0.0 - 1.0，默认1.0
  blue （取值范围0.0 - 1.0，默认1.0

- [x] GPUSaturationFilter
  饱和度
  saturation（取值范围0.0 - 2.0，默认1.0）

- [x] GPUSepiaFilter
  褐色（怀旧）
  sepia (取值范围0.0 - 2.0，默认1.0)

- [x] GPUSharpenFilter
  锐化
  sharpen (取值范围-4.0 - 4.0，默认0.0)

- [x] GPUWhiteBalanceFilter
  色温
  temperature （取值范围4000 - 7000，默认5000）
  tint （取值范围-200 - 200，默认0）

## 说明
  业余时间做的插件只实现了一部分滤镜，后续有时间会继续加入其余的滤镜。也可以参考插件中Filter的写法加入其余滤镜，欢迎pr

## 插件链接

|插件|地址|
|:----|:----|
|字节-穿山甲广告插件|[flutter_unionad](https://github.com/gstory0404/flutter_unionad)|
|腾讯-优量汇广告插件|[flutter_tencentad](https://github.com/gstory0404/flutter_tencentad)|
|百度-百青藤广告插件|[baiduad](https://github.com/gstory0404/baiduad)|
|字节-Gromore聚合广告|[gromore](https://github.com/gstory0404/gromore)|
|Sigmob广告|[sigmobad](https://github.com/gstory0404/sigmobad)|
|聚合广告插件(迁移至GTAds)|[flutter_universalad](https://github.com/gstory0404/flutter_universalad)|
|GTAds聚合广告|[GTAds](https://github.com/gstory0404/GTAds)|
|字节穿山甲内容合作插件|[flutter_pangrowth](https://github.com/gstory0404/flutter_pangrowth)|
|文档预览插件|[file_preview](https://github.com/gstory0404/file_preview)|
|滤镜|[gpu_image](https://github.com/gstory0404/gpu_image)|

## 联系方式
* Email: gstory0404@gmail.com
* Blog：https://www.gstory.cn/

* QQ群: <a target="_blank" href="https://qm.qq.com/cgi-bin/qm/qr?k=4j2_yF1-pMl58y16zvLCFFT2HEmLf6vQ&jump_from=webapi"><img border="0" src="//pub.idqqimg.com/wpa/images/group.png" alt="649574038" title="flutter交流"></a>
