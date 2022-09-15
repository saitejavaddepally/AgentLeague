import 'dart:collection';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:file_picker/file_picker.dart';

class ImageUploadProvider extends ChangeNotifier {
  final List<File?> _images = List.generate(8, (index) => null);

  UnmodifiableListView<File?> get images => UnmodifiableListView(_images);

  void pickImage(int index) async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final bytes = (await image.readAsBytes()).lengthInBytes;
    final kb = bytes / 1024;
    final mb = kb / 1024;
    if (mb > 1) {
      Fluttertoast.showToast(
          msg: 'Image Should be less than 1mb', toastLength: Toast.LENGTH_LONG);
      return;
    } else {
      final imageTemporary = File(image.path);
      _images[index] = imageTemporary;
      notifyListeners();
    }
  }
}

class VideoUploadProvider extends ChangeNotifier {
  final List<File?> _videos = List.generate(4, (index) => null);

  UnmodifiableListView<File?> get videos => UnmodifiableListView(_videos);

  void pickVideo(int index) async {
    final video = await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (video == null) return;

    final bytes = (await video.readAsBytes()).lengthInBytes;
    final kb = bytes / 1024;
    final mb = kb / 1024;

    if (mb > 3) {
      Fluttertoast.showToast(
          msg: 'Video Should be less than 3mb', toastLength: Toast.LENGTH_LONG);
      return;
    } else {
      final videoTemporary = File(video.path);
      _videos[index] = videoTemporary;
      notifyListeners();
    }
  }
}

class PdfUploadProvider extends ChangeNotifier {
  final List<File?> _docs = List.generate(4, (index) => null);

  UnmodifiableListView<File?> get docs => UnmodifiableListView(_docs);
  FilePickerResult? result;
  void pickPdf(int index) async {
    if (index == 0) {
      result = await FilePicker.platform
          .pickFiles(allowedExtensions: ['png', 'jpg'], type: FileType.custom);
    } else {
      result = await FilePicker.platform
          .pickFiles(allowedExtensions: ['pdf'], type: FileType.custom);
    }

    if (result == null) return;
    final file = result!.files.first;
    final kb = file.size / 1024;
    final mb = kb / 1024;
    if (mb > 3) {
      Fluttertoast.showToast(
          msg: 'File Should be less than 3mb', toastLength: Toast.LENGTH_LONG);
      return;
    } else {
      _docs[index] = File(file.path!);
      notifyListeners();
    }
  }
}
