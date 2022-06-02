import 'dart:collection';

import 'package:flutter/material.dart';

class PostYourPropertyProviderTwo extends ChangeNotifier {
  // for facingDropDown
  final List<String> _facingDropDown = [
    'East',
    'West',
    'North',
    'South',
    'East - West',
    'East - North',
    'East - South',
    'North - West',
    'North - South',
    'South - West'
  ];
  String? _facingChosenValue;

  String? get facingChosenValue => _facingChosenValue;

  UnmodifiableListView<String> get facingDropDown =>
      UnmodifiableListView(_facingDropDown);

  void onChangedFacing(value) {
    _facingChosenValue = value;
    notifyListeners();
  }

  // for furnishedDropDown
  final List<String> _furnishedDropDown = ['Semi', 'Fully', 'None'];
  String? _furnishedChosenValue;

  String? get furnishedChosenValue => _furnishedChosenValue;

  UnmodifiableListView<String> get furnishedDropDown =>
      UnmodifiableListView(_furnishedDropDown);

  void onChangedFurnished(value) {
    _furnishedChosenValue = value;
    notifyListeners();
  }

  // for floorsDropDown
  final List<String> _floorsDropDown = [
    'Ground',
    '1',
    '2',
    '3',
    '4',
    '5',
    '5+'
  ];
  String? _floorsChosenValue;

  String? get floorsChosenValue => _floorsChosenValue;

  UnmodifiableListView<String> get floorsDropDown =>
      UnmodifiableListView(_floorsDropDown);

  void onChangedFloors(value) {
    _floorsChosenValue = value;
    notifyListeners();
  }

  // for sizeDropDown
  final List<String> _sizeDropDown = ['Sq.feets', 'Sq.yards'];
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
  final List<String> _bedRoomDropDown = ['1', '2', '3', '4', '5', '5+'];
  String? _bedRoomChosenValue;

  String? get bedRoomChosenValue => _bedRoomChosenValue;

  UnmodifiableListView<String> get bedRoomDropDown =>
      UnmodifiableListView(_bedRoomDropDown);

  void onChangedBedRoom(value) {
    _bedRoomChosenValue = value;
    notifyListeners();
  }

  // for bathRoomDropDown
  final List<String> _bathRoomDropDown = ['1', '2', '3', '4', '5', '5+'];
  String? _bathRoomChosenValue;

  String? get bathRoomChosenValue => _bathRoomChosenValue;

  UnmodifiableListView<String> get bathRoomDropDown =>
      UnmodifiableListView(_bathRoomDropDown);

  void onChangedBathRoom(value) {
    _bathRoomChosenValue = value;
    notifyListeners();
  }

// for carparkDropDown

  final List<String> _carParkDropDown = ['1', '2', '3'];
  String? _carParkChosenValue;

  String? get carParkChosenValue => _carParkChosenValue;

  UnmodifiableListView<String> get carParkDropDown =>
      UnmodifiableListView(_carParkDropDown);

  void onChangedCarPark(value) {
    _carParkChosenValue = value;
    notifyListeners();
  }

  // for extraRoomDropDown

  final List<String> _extraRoomDropDown = [
    'Servant',
    'Puja',
    'Stove',
    'Study',
    'Guest'
  ];
  String? _extraRoomChosenValue;

  String? get extraRoomChosenValue => _extraRoomChosenValue;

  UnmodifiableListView<String> get extraRoomDropDown =>
      UnmodifiableListView(_extraRoomDropDown);

  void onChangedExtraRoom(value) {
    _extraRoomChosenValue = value;
    notifyListeners();
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
    _carParkChosenValue = null;
    _extraRoomChosenValue = null;
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
      'car_park': _carParkChosenValue,
      'extra_room': _extraRoomChosenValue,
      'total_portion': _totalPortion,
      'total_income': _totalIncome,
    };
  }
}
