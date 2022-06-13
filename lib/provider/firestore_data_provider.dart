import 'package:agent_league/helper/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_document_picker/flutter_document_picker.dart';

import '../Services/auth_methods.dart';

class FirestoreDataProvider {
  List videos = [];
  List documents = [];
  List images = [];
  List plots = [];

  get _videos => videos;

  get _plots => plots;

  get _images => images;

  get _documents => documents;

  Future getPlots() async {
    String? userId = await SharedPreferencesHelper().getUserId();

    List docs = [];
    CollectionReference ref = FirebaseFirestore.instance
        .collection("sell_plots")
        .doc(userId)
        .collection("standlone");

    await ref.get().then((event) {
      for (var element in event.docs) {
        docs.add(element.id);
      }
    });
    return docs;
  }

  Future getPlotPagesInformation(int plotNo) async {
    String? userId = await SharedPreferencesHelper().getUserId();
    CollectionReference ref;
    List detailsOfPages = [];
    ref = FirebaseFirestore.instance
        .collection("sell_plots")
        .doc(userId)
        .collection("standlone")
        .doc('plot_$plotNo')
        .collection('pages_info');
    Map res = {};
    await ref.get().then((val) async {
      if (val.docs.isNotEmpty) {
        res = val.docs[0].data() as Map;
        detailsOfPages.add(res);
      }
    });

      return detailsOfPages;
  }

  Future getProfileImage(String path) async {
    print("path is $path");
    Reference storageRef = FirebaseStorage.instance.ref().child(path);
    final listResult = await storageRef.listAll();

    List images = [];
    for (var item in listResult.items) {
      await item.getDownloadURL().then((value) async {
        images.add(value);
      });
    }
    return images[0];
  }

  Future getFirestoreFiles(String type) async {
    String? currentPlot = await SharedPreferencesHelper().getCurrentPage();
    String currPlot = (int.parse(currentPlot!)).toString();
    String? userId = await AuthMethods().getUserId();
    print("path is sell_plots/$userId/standlone/plot_$currPlot/images/");
    late final Reference storageRef;
    if (type == "IMAGES") {
      storageRef = FirebaseStorage.instance
          .ref()
          .child("sell_images/$userId/standlone/plot_$currPlot/images/");
    } else if (type == "VIDEOS") {
      storageRef = FirebaseStorage.instance
          .ref()
          .child("sell_images/$userId/standlone/plot_$currPlot/videos/");
    } else {
      storageRef = FirebaseStorage.instance
          .ref()
          .child("sell_images/$userId/standlone/plot_$currPlot/docs/");
    }
    final listResult = await storageRef.listAll();
    for (var item in listResult.items) {
      await item.getDownloadURL().then((value) async {
        print(value);
        if (type == "IMAGES") {
          images.add(value);
        } else if (type == "VIDEOS") {
          videos.add(value);
        } else {
          documents.add({"name": item.name, "value": value});
        }
      });
    }
    print('Images are $images');
    return (type == "IMAGES")
        ? images
        : (type == "VIDEOS")
            ? videos
            : documents;
  }
}
