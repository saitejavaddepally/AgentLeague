import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../Services/auth_methods.dart';
import '../helper/string_manager.dart';
import '../helper/utility_methods.dart';

class PropertyUploadProvider {
  static final _projects = FirebaseFirestore.instance.collection('projects');

  static Future<void> addProject(
      {required Map<String, dynamic> data,
      required List<File> images,
      required List<int> imageIndex,
      required List<File> docs,
      required List<int> docsIndex,
      required List<File> videos,
      required List<int> videosIndex}) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    data.addAll({
      StringManager.userId: uid,
    });

    try {
      var docRef = await _projects.add(data);

      final latestProjectId = docRef.id;

      final path = "projects/$latestProjectId/";

      final imageUrls = await Utils.uploadFiles(
          images,
          '$path${StringManager.imagesKey}/',
          StringManager.imagesKey,
          imageIndex);

      final videoUrls = await Utils.uploadFiles(
          videos,
          '$path${StringManager.videosKey}/',
          StringManager.videosKey,
          videosIndex);

      final docsUrl = await Utils.uploadFiles(docs,
          '$path${StringManager.docsKey}/', StringManager.docsKey, docsIndex);

      await _projects.doc(latestProjectId).update({
        StringManager.imagesKey: imageUrls,
        StringManager.videosKey: videoUrls,
        StringManager.docsKey: docsUrl
      });
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<void> updateProject(String docId) async {
    await _projects.doc(docId).update({'isExport': true});
  }

  static Future<List<Map<String, dynamic>>> getExportedProjects() async {
    final querySnap = await _projects.where('isExport', isEqualTo: true).get();

    return querySnap.docs
        .map((e) => e.data()..addAll({'docId': e.id}))
        .toList();
  }

  static Future isSubscribedUser(String docId) async {
    String? userId = await AuthMethods().getUserId();
    final docSnap = await _projects.doc(docId).get();
    if (docSnap.data()?['subscribedUsers'] == null) {
      return false;
    } else if (docSnap.data()?['subscribedUsers'][userId] == null) {
      return false;
    } else {
      return true;
    }
  }

  static Future<void> subscribeUser(String docId) async {
    String? userId = await AuthMethods().getUserId();
    await _projects
        .doc(docId)
        .update({'subscribedUsers.$userId': FieldValue.serverTimestamp()});
  }
}
