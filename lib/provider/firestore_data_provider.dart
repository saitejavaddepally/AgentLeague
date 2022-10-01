import 'dart:io';

import 'package:agent_league/helper/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../Services/auth_methods.dart';

class FirestoreDataProvider {
  static final _user = FirebaseFirestore.instance.collection('users');
  static final _chat = FirebaseFirestore.instance.collection('chats');
  static final _wallet = FirebaseFirestore.instance.collection('wallet');
  static final User? _currentUser = FirebaseAuth.instance.currentUser;

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

  Future<String> getUserProfilePicture(String? uid) async {
    final docSnap = await _user.doc(uid).get();
    return docSnap.data()?['profile_pic'] as String;
  }

  Future<List> getLatestMessage(String friendUid) async {
    List msg = [null, ''];
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
        msg[0] = data['createdOn'];

        if (data['type'] == 'image') {
          msg[1] = 'Image';
        } else if (data['type'] == 'pdf') {
          msg[1] = 'Pdf';
        } else if (data['type'] == 'loc') {
          msg[1] = 'location';
        } else {
          msg[1] = data['msg'];
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

  static Future<bool> checkReferralCode(
      String referralCode, String name) async {
    final _querySnap =
        await _user.where('ref_code', isEqualTo: referralCode).get();
    if (_querySnap.docs.isNotEmpty) {
      final uid = _querySnap.docs.first.id;
      await _user.doc(uid).update({'wallet_amount': FieldValue.increment(100)});
      await _wallet.doc(uid).collection('standlone').add({
        'timestamp': FieldValue.serverTimestamp(),
        'description': 'You earned a referral bonus by referring $name',
        'type': 'credit',
        'amount': 100,
      });
      return true;
    } else {
      return false;
    }
  }

  static Future<num> getWalletBalance() async {
    final _docSnap = await _user.doc(_currentUser?.uid).get();
    return _docSnap.data()?['wallet_amount'] ?? 0;
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getWalletHistory() {
    return _wallet.doc(_currentUser?.uid).collection('standlone').snapshots();
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

  Future getProfileInformation() async {
    DocumentReference ref = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid);
    Map res = {};
    await ref.get().then((event) {
      res = event.data() as Map;
    });

    return res;
  }

  Future<String?> getProfilePicture() async {
    String url = '';
    await AuthMethods().getUserId().then((value) async {
      final ref = FirebaseStorage.instance
          .ref()
          .child('sell_images/$value/profile_pic');
      url = await ref.getDownloadURL().catchError((error) {
        return '';
      });
    });

    return url;
  }

  Future uploadProfilePicture(File? image) async {
    dynamic snapshot;
    final _firebaseStorage = FirebaseStorage.instance;

    await AuthMethods().getUserId().then((value) async {
      snapshot = await _firebaseStorage
          .ref()
          .child('sell_images/$value/profile_pic')
          .putFile(image!);
      String? url = await getProfilePicture();

      await FirebaseFirestore.instance
          .collection('users')
          .doc(value)
          .set({"profilePicture": url});
    });
  }
}
