import 'dart:collection';

import 'package:flutter/material.dart';

class LeadStatusProvider extends ChangeNotifier {
  final List<bool> _isCheckedList = [false, false, false, false];

  LeadStatusProvider(String status) {
    if (status == 'new customer') {
      _isCheckedList[0] = true;
    } else if (status == 'deal in progress') {
      _isCheckedList[1] = true;
    } else if (status == 'deal successful') {
      _isCheckedList[2] = true;
    } else {
      _isCheckedList[3] = true;
    }
  }

  UnmodifiableListView get isChecked => UnmodifiableListView(_isCheckedList);

  void onPressButton(int index) {
    for (int i = 0; i < _isCheckedList.length; i++) {
      if (index == i) {
        _isCheckedList[index] = true;
      } else {
        _isCheckedList[i] = false;
      }
    }
    notifyListeners();
  }
}
