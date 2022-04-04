import 'dart:async';
import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class OtpProvider extends ChangeNotifier {
  static const maxSecond = 30;
  int _seconds = maxSecond;
  Timer? timer;

  final List<int> _otp = [];

  UnmodifiableListView<int> get otp => UnmodifiableListView(_otp);

  int get seconds => _seconds;

  OtpProvider() {
    startTimer();
  }

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

  void pushToOtp(int number) {
    if (_otp.length < 4) {
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

  String checkOtp(int sendCode) {
    if (_otp.length == 4) {
      var userCode = int.parse("${otp[0]}${otp[1]}${otp[2]}${otp[3]}");

      if (sendCode == userCode) {
        return "correct";
      } else {
        return "incorrect";
      }
    } else {
      return "enterotp";
    }
  }
}
