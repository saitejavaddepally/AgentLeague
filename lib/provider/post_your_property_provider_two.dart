import 'dart:collection';

import 'package:flutter/material.dart';

import '../ui/sell_screens/post_your_property_page_two.dart';

class PostYourPropertyProviderTwo extends ChangeNotifier {
  PostYourPropertyProviderTwo(data) {
    if (data != null) {
      _furnishedChosenValue = data['furnished'] ?? null;
      _floorsChosenValue = data['floors'] ?? null;
      _bedRoomChosenValue = data['bed_room'] ?? null;
      _bathRoomChosenValue = data['bath_room'] ?? null;
      _extraRoomChosenValue = data['extra_room'] ?? null;
      _carParkChosenValue = data['car_park'] ?? null;
      _totalPortion = data['total_portion'] ?? '';
      _totalIncome = data['total_income'] ?? '';
      _rentalIncome = data['rental_income'] ?? false;
    }
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

  bool _rentalIncome = false;
  String _totalPortion = '';
  String _totalIncome = '';
  bool get rentalIncome => _rentalIncome;

  onYesClickRentalIncome(BuildContext context) async {
    if (_rentalIncome == false) {
      final list = await showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => CustomDialog());

      if (list != null) {
        _totalPortion = list[0];
        _totalIncome = list[1];
        _rentalIncome = true;
        notifyListeners();
      }
    }
  }

  onNoClickRentalIncome() {
    if (_rentalIncome == true) {
      _totalPortion = '';
      _totalIncome = '';
      _rentalIncome = false;
      notifyListeners();
    }
  }

  void resetAllData() {
    _furnishedChosenValue = null;
    _floorsChosenValue = null;
    _rentalIncome = false;
    _totalPortion = '';
    _totalIncome = '';
    _bedRoomChosenValue = null;
    _bathRoomChosenValue = null;
    _carParkChosenValue = null;
    _extraRoomChosenValue = null;
    notifyListeners();
  }

  Map<String, dynamic> getMap(Map data) {
    return {
      ...data,
      'furnished': _furnishedChosenValue,
      'floors': _floorsChosenValue,
      'bed_room': _bedRoomChosenValue,
      'bath_room': _bathRoomChosenValue,
      'car_park': _carParkChosenValue,
      'extra_room': _extraRoomChosenValue,
      'total_portion': _totalPortion,
      'total_income': _totalIncome,
      'rental_income': _rentalIncome,
    };
  }
}
