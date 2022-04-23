import 'dart:collection';

import 'package:flutter/material.dart';

class PostYourPropertyProviderTwo extends ChangeNotifier {
  // for facingDropDown
  final List<String> _facingDropDown = ['abc', 'def'];
  String? _facingChosenValue;

  String? get facingChosenValue => _facingChosenValue;

  UnmodifiableListView<String> get facingDropDown =>
      UnmodifiableListView(_facingDropDown);

  void onChangedFacing(value) {
    _facingChosenValue = value;
    notifyListeners();
  }

  // for furnishedDropDown
  final List<String> _furnishedDropDown = ['abc', 'def'];
  String? _furnishedChosenValue;

  String? get furnishedChosenValue => _furnishedChosenValue;

  UnmodifiableListView<String> get furnishedDropDown =>
      UnmodifiableListView(_furnishedDropDown);

  void onChangedFurnished(value) {
    _furnishedChosenValue = value;
    notifyListeners();
  }

  // for floorsDropDown
  final List<int> _floorsDropDown = [1, 2];
  int? _floorsChosenValue;

  int? get floorsChosenValue => _floorsChosenValue;

  UnmodifiableListView<int> get floorsDropDown =>
      UnmodifiableListView(_floorsDropDown);

  void onChangedFloors(value) {
    _floorsChosenValue = value;
    notifyListeners();
  }

  // for sizeDropDown
  final List<String> _sizeDropDown = ['Sq.yd', 'abcd'];
  String? _sizeChosenValue;

  String? get sizeChosenValue => _sizeChosenValue;

  UnmodifiableListView<String> get sizeDropDown =>
      UnmodifiableListView(_sizeDropDown);

  void onChangedSize(value) {
    _sizeChosenValue = value;
    notifyListeners();
  }

  // for sizeTextField
  final TextEditingController _sizeController = TextEditingController();
  String _size = '';

  TextEditingController get sizeController => _sizeController;

  onSubmittedSize(value) {
    _size = value;
  }

  String? validateSize(String? size) {
    if (size == null || size.trim().isEmpty) {
      return 'Size Required';
    } else {
      return null;
    }
  }

  // for carpetAreaTextField
  final TextEditingController _carpetAreaController = TextEditingController();
  String _carpetArea = '';

  TextEditingController get carpetAreaController => _carpetAreaController;

  onSubmittedCarpetArea(value) {
    _carpetArea = value;
  }

  String? validateCarpetArea(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Carpet Area Required';
    } else {
      return null;
    }
  }

  // for bedRoomDropDown
  final List<int> _bedRoomDropDown = [1, 2];
  int? _bedRoomChosenValue;

  int? get bedRoomChosenValue => _bedRoomChosenValue;

  UnmodifiableListView<int> get bedRoomDropDown =>
      UnmodifiableListView(_bedRoomDropDown);

  void onChangedBedRoom(value) {
    _bedRoomChosenValue = value;
    notifyListeners();
  }

  // for bathRoomDropDown
  final List<int> _bathRoomDropDown = [1, 2];
  int? _bathRoomChosenValue;

  int? get bathRoomChosenValue => _bathRoomChosenValue;

  UnmodifiableListView<int> get bathRoomDropDown =>
      UnmodifiableListView(_bathRoomDropDown);

  void onChangedBathRoom(value) {
    _bathRoomChosenValue = value;
    notifyListeners();
  }

// for carparkTextField
  final TextEditingController _carparkController = TextEditingController();
  String _carpark = '';

  TextEditingController get carparkController => _carparkController;

  onSubmittedCarpark(value) {
    _carpark = value;
  }

  String? validateCarpark(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Car Park Required';
    } else {
      return null;
    }
  }

  // for extraRoomTextField
  final TextEditingController _extraRoomController = TextEditingController();
  String _extraRoom = '';

  TextEditingController get extraRoomController => _extraRoomController;

  onSubmittedExtraRoom(value) {
    _extraRoom = value;
  }

  String? validateExtraRoom(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Extra Room Required';
    } else {
      return null;
    }
  }

  // for totalPortionTextField
  final TextEditingController _totalPortionController = TextEditingController();
  String _totalPortion = '';

  TextEditingController get totalPortionController => _totalPortionController;

  onSubmittedTotalPortion(value) {
    _totalPortion = value;
  }

  // for totalIncomeTextField
  final TextEditingController _totalIncomeController = TextEditingController();
  String _totalIncome = '';

  TextEditingController get totalIncomeController => _totalIncomeController;

  onSubmittedTotalIncome(value) {
    _totalIncome = value;
  }

  void resetAllData() {
    _facingChosenValue = null;
    _furnishedChosenValue = null;
    _floorsChosenValue = null;
    _sizeChosenValue = null;
    _sizeController.clear();
    _carpetAreaController.clear();
    _bedRoomChosenValue = null;
    _bathRoomChosenValue = null;
    _carparkController.clear();
    _extraRoomController.clear();
    _totalPortionController.clear();
    _totalIncomeController.clear();
    notifyListeners();
  }

  Map<String, dynamic> getMap(Map<String, dynamic> previous) {
    return {
      ...previous,
      'facing': _facingChosenValue,
      'furnished': _furnishedChosenValue,
      'floors': _floorsChosenValue,
      'size_dropDown': _sizeChosenValue,
      'size_text': _size,
      'carpet_area': _carpetArea,
      'bed_room': _bedRoomChosenValue,
      'bath_room': _bathRoomChosenValue,
      'car_park': _carpark,
      'extra_room': _extraRoom,
      'total_portion': _totalPortion,
      'total_income': _totalIncome,
    };
  }
}
