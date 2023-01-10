// ignore_for_file: depend_on_referenced_packages

import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:collection/collection.dart';

class Utils {
  static String formatTimestamp(Timestamp? timestamp) {
    if (timestamp != null) {
      var format = DateFormat('d-MM-y h:mm:a'); // <- use skeleton here
      return format.format(timestamp.toDate());
    }
    return "";
  }

  static Future<File?> pickImage() async {
    final image = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (image == null) return null;
    return File(image.path);
  }

  static Future<List<String>> uploadFiles(
      List<File> files, String path, String type, List<int> indexes) async {
    var fileUrls = await Future.wait(files.mapIndexed(
        (index, file) => uploadFile(file, '$path$type ${indexes[index] + 1}')));

    return fileUrls;
  }

  static Future<String> uploadFile(File file, String path) async {
    final storageReference = FirebaseStorage.instance.ref().child(path);
    final uploadTask = storageReference.putFile(file);
    await uploadTask.whenComplete(() => log(''));

    return await storageReference.getDownloadURL();
  }
}
