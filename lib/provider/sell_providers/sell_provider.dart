import 'dart:collection';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SellScreenProvider extends ChangeNotifier {
  String _orderBy = 'price';
  bool _desc = false;
  final List<String> _sortByDropDown = [
    'Price Low - High',
    'Price High - Low ',
    'Date - Recent First',
    'Date - Recent Last'
  ];

  UnmodifiableListView<String> get sortByDropDown =>
      UnmodifiableListView(_sortByDropDown);

  String? _sortByChosenValue = 'Price Low - High';
  String? get sortByChosenValue => _sortByChosenValue;

  final bool _isSearchOn = false;
  bool get isSearchOn => _isSearchOn;

  void onChangeSortBy(value) {
    if (value == _sortByDropDown[0]) {
      _orderBy = 'price';
      _desc = false;
    } else if (value == _sortByDropDown[1]) {
      _orderBy = 'price';
      _desc = true;
    } else if (value == _sortByDropDown[2]) {
      _orderBy = 'timestamp';
      _desc = true;
    } else if (value == _sortByDropDown[3]) {
      _orderBy = 'timestamp';
      _desc = false;
    }
    _sortByChosenValue = value;
    getAllPaidProperty();
  }

  List<Map<String, dynamic>> _data = [];

  UnmodifiableListView<Map<String, dynamic>> get data =>
      UnmodifiableListView(_data);

  Future<List<Map<String, dynamic>>> getAllPaidProperty() async {
    log('1');
    final userId = FirebaseAuth.instance.currentUser?.uid;
    final querySnap = await FirebaseFirestore.instance
        .collection('sell_plots')
        .doc(userId)
        .collection('standlone')
        .where('isPaid', isEqualTo: true)
        .orderBy(_orderBy, descending: _desc)
        .get();
    log("2");
    _data = querySnap.docs.map((e) => e.data()..addAll({'id': e.id})).toList();
    notifyListeners();
    return _data;
  }
}
