import 'dart:async';
import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class OtpProvider extends ChangeNotifier {
  final List<int> _otp = [];
  FirebaseAuth auth = FirebaseAuth.instance;

  UnmodifiableListView<int> get otp => UnmodifiableListView(_otp);

  void pushToOtp(int number) {
    if (_otp.length < 6) {
      _otp.add(number);
      notifyListeners();
    }
  }

  void popFromOtp() {
    if (_otp.isNotEmpty) {
      _otp.removeLast();
      notifyListeners();
    }
  }

  Future<String> checkOtp(String verificationId, String name) async {
    bool correct = false;
    if (_otp.length == 6) {
      var userCode =
          int.parse("${otp[0]}${otp[1]}${otp[2]}${otp[3]}${otp[4]}${otp[5]}");
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: userCode.toString());
      await auth
          .signInWithCredential(credential)
          .then((UserCredential userCredential) async {
        correct = true;
        if (userCredential.user != null) {
          var userId = userCredential.user!.uid;
          await registerUser(userId, name);
        }
      }).catchError((error) {
        print(error);
      });

      if (correct) {
        return "correct";
      } else {
        return "incorrect";
      }
    }
    return "enterotp";
  }

  Future<void> registerUser(String userId, String name) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .set({'name': name});
    } on Exception catch (e) {
      print(e);
    }
  }
}

class OtpTimer extends ChangeNotifier {
  static const maxSecond = 30;
  int _seconds = maxSecond;
  Timer? timer;

  OtpTimer() {
    startTimer();
  }

  int get seconds => _seconds;

  startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_seconds > 0) {
        _seconds--;
        notifyListeners();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }
}
