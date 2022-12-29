import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../../helper/utility_methods.dart';

class UploadingProgressProvider extends ChangeNotifier {
  int processIndex = 0;
  final _sellPlots = FirebaseFirestore.instance.collection('sell_plots');
  final _currentUser = FirebaseAuth.instance.currentUser;

  Future<String> addProject(
      Map<String, dynamic> data,
      List<File> images,
      List<File> videos,
      List<File> docs,
      bool isFreeListing,
      List<int> imageIndex,
      List<int> docsIndex,
      List<int> videosIndex) async {
    String? id;

    try {
      final _docRef = await _sellPlots
          .doc(_currentUser?.uid)
          .collection('standlone')
          .add(data
            ..addAll({
              'isPaid': isFreeListing,
              'timestamp': FieldValue.serverTimestamp()
            }));

      id = _docRef.id;
      String path = 'sell_plot/${_currentUser?.uid}/standlone/$id/';
      final imageUrls = await Utils.uploadFiles(
          images, path + 'images/', 'image', imageIndex);
      processIndex = 1;
      notifyListeners();

      final docUrls =
          await Utils.uploadFiles(docs, path + 'docs/', 'doc', docsIndex);
      processIndex = 2;
      notifyListeners();
      final videoUrls = await Utils.uploadFiles(
          videos, path + 'videos/', 'video', videosIndex);
      processIndex = 3;
      notifyListeners();

      await _sellPlots
          .doc(_currentUser?.uid)
          .collection('standlone')
          .doc(id)
          .update({
        'profile_image': imageUrls[0],
        'images': imageUrls,
        'docs': docUrls,
        'videos': videoUrls
      });
      processIndex = 4;
      notifyListeners();

      return id;
    } catch (e) {
      if (id != null) {
        await _sellPlots
            .doc(_currentUser?.uid)
            .collection('standlone')
            .doc(id)
            .delete();
      }
      return Future.error(e.toString());
    }
  }

  Future<void> editProject(
      Map<String, dynamic> data,
      List<File> images,
      List<File> videos,
      List<File> docs,
      List<int> imageIndex,
      List<int> docsIndex,
      List<int> videosIndex,
      String id) async {
    try {
      final path = 'sell_plot/${_currentUser?.uid}/standlone/$id/';

      processIndex = 1;
      notifyListeners();
      //upload images, videos, docs and get url
      final imageUrls = await Utils.uploadFiles(
          images, path + 'images/', 'image', imageIndex);

      final docUrls =
          await Utils.uploadFiles(docs, path + 'docs/', 'doc', docsIndex);

      processIndex = 2;
      notifyListeners();
      final videoUrls = await Utils.uploadFiles(
          videos, path + 'videos/', 'video', videosIndex);

      //get url of all images in specified path
      final imageListResult =
          await FirebaseStorage.instance.ref(path + 'images/').listAll();

      final allImgUrl = await Future.wait(
          imageListResult.items.map((e) => e.getDownloadURL()));

      //get url of all docs in specified path
      final docListResult =
          await FirebaseStorage.instance.ref(path + 'docs/').listAll();

      final allDocsUrl =
          await Future.wait(docListResult.items.map((e) => e.getDownloadURL()));

      //get url of all videos in specified path
      final videoListResult =
          await FirebaseStorage.instance.ref(path + 'videos/').listAll();

      final allVideoUrl = await Future.wait(
          videoListResult.items.map((e) => e.getDownloadURL()));
      processIndex = 3;
      notifyListeners();

      if (imageIndex.contains(0)) {
        await _sellPlots
            .doc(_currentUser?.uid)
            .collection('standlone')
            .doc(id)
            .update(data
              ..addAll({
                'images': allImgUrl,
                'videos': allVideoUrl,
                'docs': allDocsUrl,
                'profile_image': imageUrls[0]
              }));
      } else {
        await _sellPlots
            .doc(_currentUser?.uid)
            .collection('standlone')
            .doc(id)
            .update(data
              ..addAll({
                'images': allImgUrl,
                'videos': allVideoUrl,
                'docs': allDocsUrl,
              }));
      }
      processIndex = 4;
      notifyListeners();
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
