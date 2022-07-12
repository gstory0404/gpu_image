part of 'gpu_image.dart';

/// @Author: gstory
/// @CreateDate: 2022/1/24 2:50 下午
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述 


///拍照返回
typedef RecordPhoto = void Function(String path);

///录制返回
typedef RecordVideo = void Function(String recordStatus, String path);

///保存图片返回
typedef SaveImage = void Function(String path);

///保存图片返回
typedef SaveVideo = void Function(String path);