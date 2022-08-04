


import 'dart:io';

import 'package:video_compress/video_compress.dart';

class FileCompressor{

  Future<File?> compressVideo(File videoFile) async {
    MediaInfo? info = await VideoCompress.compressVideo(
      videoFile.path,
      quality: VideoQuality.LowQuality,
      deleteOrigin: false, // It's false by default
    );
    return info?.file;
  }
}