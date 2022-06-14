import 'dart:collection';

import 'package:flutter/material.dart';

class LocationSearchProvider extends ChangeNotifier {
  TextEditingController locationController = TextEditingController();

  String? validateLocation(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Please Choose Location";
    } else {
      return null;
    }
  }

  final List _kmDropDownItems = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

  UnmodifiableListView get kmDropDownItems =>
      UnmodifiableListView(_kmDropDownItems);

  String? _chosenKm;

  String? get chosenKm => _chosenKm;

  onChangedKm(value) {
    _chosenKm = value;
    notifyListeners();
  }

  resetData() {
    _chosenKm = null;
    locationController.clear();
    notifyListeners();
  }
}
