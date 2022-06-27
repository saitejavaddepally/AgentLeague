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

  Future<List> getPlots() async {
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

    print(detailsOfPages);

    return detailsOfPages;
  }

  Future<void> deletePlot(int plotNo) async {
    try {
      String? userId = await SharedPreferencesHelper().getUserId();
      CollectionReference plotCollection = FirebaseFirestore.instance
          .collection('sell_plots')
          .doc(userId)
          .collection('standlone');

      await plotCollection.doc('plot_$plotNo').delete();
      await deleteImages(userId!, plotNo);
      await deleteDocs(userId, plotNo);
      await deleteVideos(userId, plotNo);
    } on Exception catch (e) {
      print(e);
    }
  }

  Future deleteImages(String userId, int plotNo) async {
    final storageRef = FirebaseStorage.instance
        .ref()
        .child("sell_images/$userId/standlone/plot_$plotNo/images");
    final listResult = await storageRef.listAll();
    for (var element in listResult.items) {
      await element.delete();
    }
  }

  Future deleteDocs(String userId, int plotNo) async {
    final storageRef = FirebaseStorage.instance
        .ref()
        .child("sell_images/$userId/standlone/plot_$plotNo/docs");
    final listResult = await storageRef.listAll();
    for (var element in listResult.items) {
      await element.delete();
    }
  }

  Future deleteVideos(String userId, int plotNo) async {
    final storageRef = FirebaseStorage.instance
        .ref()
        .child("sell_images/$userId/standlone/plot_$plotNo/videos");
    final listResult = await storageRef.listAll();
    for (var element in listResult.items) {
      await element.delete();
    }
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
    if (images.isEmpty) {
      return "https://avatarfiles.alphacoders.com/125/thumb-125098.png";
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
          videos.add({"name": item.name, "value": value});
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

  Future<List<dynamic>> getAllImage(userId, int plotNo) async {
    final storageRef = FirebaseStorage.instance
        .ref()
        .child("sell_images/$userId/standlone/plot_$plotNo/images/");
    final List<dynamic> images = List.generate(8, (index) => null);
    final listResult = await storageRef.listAll();

    for (int i = 0; i < listResult.items.length; i++) {
      await listResult.items[i].getDownloadURL().then((value) async {
        images[i] = value;
      });
    }

    return images;
  }

  Future<List<dynamic>> getAllVideos(userId, int plotNo) async {
    final storageRef = FirebaseStorage.instance
        .ref()
        .child("sell_images/$userId/standlone/plot_$plotNo/videos/");
    final List<dynamic> videos = List.generate(4, (index) => null);
    final List<dynamic> previousVideoNames = List.generate(4, (index) => null);

    final listResult = await storageRef.listAll();

    for (int i = 0; i < listResult.items.length; i++) {
      previousVideoNames[i] = listResult.items[i].name;
      await listResult.items[i].getDownloadURL().then((value) async {
        videos[i] = value;
      });
    }

    return [previousVideoNames, videos];
  }

  Future<List<dynamic>> getAllDocs(userId, int plotNo) async {
    final storageRef = FirebaseStorage.instance
        .ref()
        .child("sell_images/$userId/standlone/plot_$plotNo/docs/");
    final List<dynamic> docs = List.generate(4, (index) => null);
    final List<dynamic> previousDocNames = List.generate(4, (index) => null);
    final listResult = await storageRef.listAll();

    for (int i = 0; i < listResult.items.length; i++) {
      previousDocNames[i] = listResult.items[i].name;
      await listResult.items[i].getDownloadURL().then((value) async {
        docs[i] = value;
      });
    }

    return [previousDocNames, docs];
  }
}
