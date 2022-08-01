

import 'dart:io';

import 'package:agent_league/Services/firestore_crud_operations.dart';
import 'package:agent_league/helper/file_compressor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class PropertyUploadProvider{

  static const String _IMAGE = 'images';
  static const String _VIDEO = 'videos';
  static const String _DOCS = 'docs';

  Future<void> uploadProject(Map data, List images, List videos, List docs) async{

    EasyLoading.show(status: "Uploading projectInfo");
    CollectionReference ref = FirebaseFirestore.instance
        .collection("projects");

   var docRef =  await ref.add(data);

   final latestProjectId = docRef.id;

    EasyLoading.show(status: "latest project id is $latestProjectId");

    //  upload Images, videos and docs
    EasyLoading.show(status: "uploading images..");

    await uploadToFireStore(images, _IMAGE, latestProjectId);

    EasyLoading.show(status: "uploading videos..");

    await uploadToFireStore(videos, _VIDEO, latestProjectId);

    EasyLoading.show(status: "uploading docs..");

    await uploadToFireStore(docs, _DOCS, latestProjectId);

  //  generate links



    List<dynamic> imageLinks = await getAllImage(latestProjectId, _IMAGE);
    print("getting images.. $imageLinks...... $latestProjectId");

    List<dynamic> videoLinks = await getAllVideos(latestProjectId, _VIDEO);
    print("getting videos.. $videoLinks");

    List<dynamic> docLinks = await getAllDocs(latestProjectId, _DOCS);
    print("getting docs.. $docLinks");


    //  update to firestore again

    await FirestoreCrudOperations().updateProjectInformation(latestProjectId, {
      "images": FieldValue.arrayUnion([...imageLinks]),
      "videos": FieldValue.arrayUnion([...videoLinks]),
      "docs": FieldValue.arrayUnion([...docLinks]),
    });

    EasyLoading.showSuccess("Done updating !");

  }




  Future uploadToFireStore(List<dynamic> list, String type, String latestProjectId) async {


    final _firebaseStorage = FirebaseStorage.instance;
    dynamic snapshot;
    for (var i = 0; i < list.length; i++) {
      if (list[i] != null) {
          var temp = list[i];

          if (type == _VIDEO) {
            File? videoFile = await FileCompressor().compressVideo(list[i]);
            temp = videoFile;
          }

          snapshot= (await _firebaseStorage
              .ref()
              .child(
              'projects/$latestProjectId/$type/$type+"_$i" ')
              .putFile(temp! as File)) ;


      }
    }
    return "Updated $type successfully";
  }


  Future<List<dynamic>> getAllImage(String latestProjectId, String type) async {
    final storageRef = FirebaseStorage.instance
        .ref()
        .child("projects/$latestProjectId/$type");
    final List<dynamic> images = List.generate(8, (index) => null);
    final listResult = await storageRef.listAll();

    for (int i = 0; i < listResult.items.length; i++) {
      await listResult.items[i].getDownloadURL().then((value) async {
        images[i] = value;
      });
    }
    images.removeWhere((element) => element == null);
    print("images are ... " + images.toString());

    return images;
  }

  Future<List<dynamic>> getAllVideos(String latestProjectId, String type) async {
    final storageRef = FirebaseStorage.instance
        .ref()
        .child("projects/$latestProjectId/$type");
    final List<dynamic> videos = List.generate(4, (index) => null);
    final List<dynamic> previousVideoNames = List.generate(4, (index) => null);

    final listResult = await storageRef.listAll();

    for (int i = 0; i < listResult.items.length; i++) {
      previousVideoNames[i] = listResult.items[i].name;
      await listResult.items[i].getDownloadURL().then((value) async {
        videos[i] = value;
      });
    }

    videos.removeWhere((element) => element == null);
    previousVideoNames.removeWhere((element) => element == null);

    return videos;
  }

  Future<List<dynamic>> getAllDocs(String latestProjectId, String type) async {
    final storageRef = FirebaseStorage.instance
        .ref()
        .child("projects/$latestProjectId/$type");
    final List<dynamic> docs = List.generate(4, (index) => null);
    final List<dynamic> previousDocNames = List.generate(4, (index) => null);
    final listResult = await storageRef.listAll();

    for (int i = 0; i < listResult.items.length; i++) {
      previousDocNames[i] = listResult.items[i].name;
      await listResult.items[i].getDownloadURL().then((value) async {
        docs[i] = value;
      });
    }

    docs.removeWhere((element) => element == null);
    previousDocNames.removeWhere((element) => element == null);

    return docs;
  }


}