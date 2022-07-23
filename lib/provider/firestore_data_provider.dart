import 'package:agent_league/helper/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../Services/auth_methods.dart';

class FirestoreDataProvider {
  final _user = FirebaseFirestore.instance.collection('users');
  final _chat = FirebaseFirestore.instance.collection('chats');
  final _leadsBox = FirebaseFirestore.instance.collection('leads_box');

  List videos = [];
  List documents = [];
  List images = [];
  List plots = [];

  get _videos => videos;

  get _plots => plots;

  get _images => images;

  get _documents => documents;

  Future<num> getAllChatCounter() async {
    num _totalCounter = 0;
    String? uid = await AuthMethods().getUserId();

    final _currentUser = await _user.doc(uid).get();
    final _currentUserData = _currentUser.data();
    final _querySnapUser = await _user.get();
    for (final u in _querySnapUser.docs) {
      final id = u.id;
      final count = _currentUserData?[id];
      if (count == null) {
      } else {
        _totalCounter += count;
      }
    }
    return _totalCounter;
  }

  Future<num> getParticularChatCounter(String uid) async {
    String? currentUser = await AuthMethods().getUserId();
    final docSnap = await _user.doc(currentUser).get();
    final result = docSnap.data()?[uid];
    if (result == null) {
      return 0;
    } else {
      return result;
    }
  }

  Future<String> getLatestMessage(String friendUid) async {
    String msg = "";
    String? currentUid = await AuthMethods().getUserId();
    final querySnapshot = await _chat
        .where('users', isEqualTo: {friendUid: null, currentUid: null})
        .limit(1)
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      final chatDocId = querySnapshot.docs.single.id;
      final querySnap = await _chat
          .doc(chatDocId)
          .collection('messages')
          .orderBy('createdOn', descending: true)
          .limit(1)
          .get();

      if (querySnap.docs.isNotEmpty) {
        final data = querySnap.docs.first.data();
        if (data['type'] == 'image') {
          msg = 'Image';
        } else if (data['type'] == 'pdf') {
          msg = 'Pdf';
        } else if (data['type'] == 'loc') {
          msg = "Location";
        } else {
          msg = data['msg'];
        }
      }
    }
    return msg;
  }

  Future<void> clearParticularChatCounter(String uid) async {
    try {
      String? currentUser = await AuthMethods().getUserId();
      await _user.doc(currentUser).update({uid: 0});
    } catch (e) {
      print(e);
    }
  }

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

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      getAllLeads() async {
    String? uid = await AuthMethods().getUserId();
    final _querySnap = await _leadsBox.doc(uid).collection('standlone').get();

    return _querySnap.docs;
  }

  Future<void> deletePlot(int plotNo) async {
    try {
      String? userId = await SharedPreferencesHelper().getUserId();
      CollectionReference plotCollection = FirebaseFirestore.instance
          .collection('sell_plots')
          .doc(userId)
          .collection('standlone');

      QuerySnapshot plots = await plotCollection.get();
      plots.docs.map((element) {
        if (element.data() == null) {
          print("${element.id} is deleted ");
          plotCollection.doc(element.id).delete();
        }
      });

      CollectionReference collRef =
          plotCollection.doc('plot_$plotNo').collection("pages_info");
      QuerySnapshot plotDocuments = await collRef.get();
      List<dynamic> allData = plotDocuments.docs.map((doc) => doc.id).toList();

      print("document id is ${allData[0]}");
      CollectionReference ref =
          plotCollection.doc('plot_$plotNo').collection('pages_info');
      for (var id in allData) {
        ref.doc(id).delete();
      }
      await plotCollection
          .doc('plot_$plotNo')
          .update({'data': FieldValue.delete()});

      List detailsOfPages =
          await FirestoreDataProvider().getPlotPagesInformation(plotNo);

      if (detailsOfPages.isEmpty) {
        await plotCollection.doc('plot_$plotNo').delete();
      }

      await deleteImages(userId!, plotNo);
      await deleteDocs(userId, plotNo);
      await deleteVideos(userId, plotNo);
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<void> uploadPropertyToPropertyBox(String plotNo, String uid) async {
    try {
      final collRef = FirebaseFirestore.instance
          .collection('sell_plots')
          .doc(uid)
          .collection('standlone')
          .doc('plot_$plotNo')
          .collection('pages_info');

      final querySnap = await collRef.get();
      await collRef.doc(querySnap.docs[0].id).update({'box_enabled': 1});
    } catch (e) {
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
    images.removeWhere((element) => element == null);
    print("images are ... " + images.toString());

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

    videos.removeWhere((element) => element == null);
    previousVideoNames.removeWhere((element) => element == null);

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

    docs.removeWhere((element) => element == null);
    previousDocNames.removeWhere((element) => element == null);

    return [previousDocNames, docs];
  }

  Future<int> getNotificationCounter() async {
    String? uid = await SharedPreferencesHelper().getUserId();
    var docSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    int counter = docSnapshot.data()?['counter'];
    return counter;
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      getAllNotifications() async {
    String? uid = await SharedPreferencesHelper().getUserId();
    final querySnapshot = await FirebaseFirestore.instance
        .collection('notifications')
        .doc(uid)
        .collection('standlone')
        .orderBy('timestamp', descending: true)
        .get();
    return querySnapshot.docs;
  }

  Future<void> readAll() async {
    String? uid = await SharedPreferencesHelper().getUserId();
    QuerySnapshot<Map<String, dynamic>> allDoc = await FirebaseFirestore
        .instance
        .collection('notifications')
        .doc(uid)
        .collection('standlone')
        .where('isRead', isEqualTo: false)
        .get();
    print("readall");
    for (int i = 0; i < allDoc.docs.length; i++) {
      String docId = allDoc.docs[i].id;

      await FirebaseFirestore.instance
          .collection('notifications')
          .doc(uid)
          .collection('standlone')
          .doc(docId)
          .update({'isRead': true});
    }
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .update({'counter': 0});
  }
}
