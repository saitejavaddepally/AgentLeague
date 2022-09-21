import 'dart:io';
import 'dart:math';
import 'package:agent_league/helper/file_compressor.dart';
import 'package:agent_league/provider/firestore_data_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import '../helper/shared_preferences.dart';
import 'auth_methods.dart';
import 'firestore_crud_operations.dart';

class UploadPropertiesToFirestore extends ChangeNotifier {
  static const String _IMAGE = 'images';
  static const String _VIDEO = 'videos';
  static const String _DOCS = 'docs';
  String? currentPlot = '';
  String? currentUser = '';
  int processIndex = 0;

  Future getPlotStatus() async {
    String? userId = await SharedPreferencesHelper().getUserId();
    await AuthMethods().getUserId().then((value) async {
      CollectionReference ref = FirebaseFirestore.instance
          .collection("sell_plots")
          .doc(value)
          .collection("standlone");

      await ref.get().then((event) {
        if (event.docs.isEmpty) {
          SharedPreferencesHelper().saveCurrentPlot('plot_1');
        } else {
          int length = event.docs.length;
          print("length is $length");
          final List<DocumentSnapshot> documents = event.docs;
          int maxId = -1;
          for (var i = 0; i < documents.length; i++) {
            var id = documents[i].id.substring(5);
            int convId = int.parse(id);
            maxId = max(convId, maxId);
          }
          int autoId = maxId + 1;
          SharedPreferencesHelper().saveCurrentPlot('plot_$autoId');
        }
      });
    });

    await SharedPreferencesHelper()
        .getCurrentPlot()
        .then((value) => print("value is $value"));
  }

  Future plotCreditChecker() async {
    String? userId = await SharedPreferencesHelper().getUserId();
    DocumentReference ref =
        FirebaseFirestore.instance.collection('users').doc(userId);
    Map res = {};
    await ref.get().then((event) {
      res = event.data() as Map;
    });

    print(res);

    return res['freeCredit'];
  }

  Future getProfileInformation() async {
    DocumentReference ref = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid);
    Map res = {};
    await ref.get().then((event) {
      res = event.data() as Map;
      print(res);
    });

    return res;
  }

  Future uploadProfilePicture(File? image) async {
    dynamic snapshot;
    final _firebaseStorage = FirebaseStorage.instance;

    await AuthMethods().getUserId().then((value) async {
      print("Uploading profile picture.....");

      snapshot = await _firebaseStorage
          .ref()
          .child('sell_images/$value/profile_pic')
          .putFile(image!);
      String? url = await getProfilePicture();
      print("url is $url");
      await FirebaseFirestore.instance
          .collection('users')
          .doc(value)
          .set({"profilePicture": url});
      print("done!");
    });
  }

  Future<String?> getProfilePicture() async {
    String url = '';
    await AuthMethods().getUserId().then((value) async {
      final ref = FirebaseStorage.instance
          .ref()
          .child('sell_images/$value/profile_pic');
      url = await ref.getDownloadURL().catchError((error) {
        print("no profile found!");
        return '';
      });
      print(url);
    });
    print("url is $url");
    return url;
  }

  Future<void> updateFreeCredit(int freeCredit) async {
    String? userId = await SharedPreferencesHelper().getUserId();
    DocumentReference ref =
        FirebaseFirestore.instance.collection('users').doc(userId);
    await ref.update({"freeCredit": freeCredit.toString()});
  }

  Future postPropertyPageOne(Map<String, dynamic> data, bool isEdited) async {
    String? userId = await SharedPreferencesHelper().getUserId();

    SharedPreferencesHelper().getCurrentPlot().then((value) async {
      print("Current value is $value");
      CollectionReference ref;
      ref = FirebaseFirestore.instance
          .collection("sell_plots")
          .doc(userId)
          .collection("standlone");

      ref.doc(value).set({"data": 1});
      data.addAll({
        "uid": userId,
      });

      if (isEdited) {
        CollectionReference collRef = ref.doc(value).collection("pages_info");
        QuerySnapshot plotDocuments = await collRef.get();
        final allData = plotDocuments.docs.map((doc) => doc.id).toList();

        print("document id is $allData");
        await ref
            .doc(value)
            .collection('pages_info')
            .doc(allData[0])
            .update(data);
      } else {
        CollectionReference collectionReference =
            ref.doc(value).collection("pages_info");

        collectionReference.add(data);
        QuerySnapshot plotDocuments = await collectionReference.get();
        final allData = plotDocuments.docs.map((doc) => doc.id).toList();
        print("ID is ${allData[0]}");
        FirestoreCrudOperations().updatePlotInformation(
            int.parse(value.toString().substring(5)),
            {"documentId": allData[0]});
      }
      print("I am Done here");
    });
  }

  Future uploadData(
      List<dynamic> _images,
      List<dynamic> _videos,
      List<dynamic> _docs,
      List<dynamic> _docNames,
      List<dynamic> _videoNames,
      bool isEdited,
      Map<String, dynamic> data) async {
    Map<String, dynamic> dataToBeUploaded = data;

    if (!isEdited) {
      dataToBeUploaded
          .addAll({"timestamp": DateTime.now().toString(), "isPaid": "false"});
    }
    String? userId = await SharedPreferencesHelper().getUserId();

    // upload the data into storage.
    await UploadPropertiesToFirestore()
        .postPropertyPageOne(dataToBeUploaded, isEdited);

    await uploadToFireStore(_images, _IMAGE, _docNames, _videoNames);

    processIndex = 1;
    notifyListeners();
    await uploadToFireStore(_videos, _VIDEO, _docNames, _videoNames);

    processIndex = 2;
    notifyListeners();
    await uploadToFireStore(_docs, _DOCS, _docNames, _videoNames);

    processIndex = 3;
    notifyListeners();

    // get the data as links.
    await SharedPreferencesHelper().getCurrentPlot().then((value) async {
      int plotNo = int.parse(value.toString().substring(5));
      List<dynamic> images =
          await FirestoreDataProvider().getAllImage(userId, plotNo);
      List<dynamic> videos =
          await FirestoreDataProvider().getAllVideos(userId, plotNo);
      print("videos are ... " + videos.toString());

      List<dynamic> docs =
          await FirestoreDataProvider().getAllDocs(userId, plotNo);
      print("docs are ... " + docs.toString());

      // update the firestore db with the links

      print("plot number is $plotNo");
      print("file links are $images and ${videos[1]} and ${docs[1]}");
      await FirestoreCrudOperations().updatePlotInformation(plotNo, {
        "plotNumber": plotNo,
        "images": FieldValue.arrayUnion([...images]),
        "videos": FieldValue.arrayUnion([...videos[1]]),
        "videoNames": FieldValue.arrayUnion([...videos[0]]),
        "docs": FieldValue.arrayUnion([...docs[1]]),
        "docNames": FieldValue.arrayUnion([...docs[0]]),
        "plotProfilePicture": images[0]
      }).then((val) {
        processIndex = 4;
        notifyListeners();
        EasyLoading.showSuccess('Updated the links in firestore! ');
      }).catchError((err) {
        EasyLoading.dismiss();
      });
    });
  }

  Future<File> urlToFile(String imageUrl) async {
    var rng = Random();
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    File file = File(tempPath + (rng.nextInt(100)).toString() + '.png');
    http.Response response = await http.get(Uri.parse(imageUrl));
    await file.writeAsBytes(response.bodyBytes);
    return file;
  }

  Future uploadToFireStore(List<dynamic> list, String type,
      List<dynamic> _docNames, List<dynamic> _videoNames) async {
    await SharedPreferencesHelper()
        .getCurrentPlot()
        .then((value) => currentPlot = value);

    final _firebaseStorage = FirebaseStorage.instance;
    dynamic snapshot;
    for (var i = 0; i < list.length; i++) {
      if (list[i] != null) {
        await AuthMethods().getUserId().then((value) async {
          currentUser = value;
          var temp = list[i];
          print(list[i].runtimeType.toString());
          if (list[i].runtimeType.toString() == 'String') {
            temp = await urlToFile(list[i]);
          }

          if (type == _VIDEO) {
            File? videoFile = await FileCompressor().compressVideo(list[i]);
            temp = videoFile;
          }

          print(
              "type is $type and video names are $_videoNames and docs are $_docNames");
          snapshot = (await _firebaseStorage
              .ref()
              .child(
                  'sell_images/$value/standlone/$currentPlot/$type/${(type == 'images') ? type + "_$i" : (type == 'docs') ? _docNames[i] : _videoNames[i]}')
              .putFile(temp! as File));

          // task.snapshotEvents.listen((event) {
          //   var progress = ((event.bytesTransferred.toDouble() /
          //               event.totalBytes.toDouble()) *
          //           100)
          //       .roundToDouble();
          // });
        });
      }
    }
    return "Updated $type successfully";
  }
}
