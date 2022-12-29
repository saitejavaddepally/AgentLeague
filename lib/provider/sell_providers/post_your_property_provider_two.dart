import 'dart:collection';

import 'package:agent_league/helper/string_manager.dart';
import 'package:flutter/material.dart';

import '../../ui/sell_screens/post_your_property_page_two.dart';

class PostYourPropertyProviderTwo extends ChangeNotifier {
  PostYourPropertyProviderTwo(data) {
    if (data != null) {
      _furnishedChosenValue = data[StringManager.furnished];
      _floorsChosenValue = data[StringManager.floors];
      _bedRoomChosenValue = data[StringManager.bedRoom];
      _bathRoomChosenValue = data[StringManager.bathRoom];
      _extraRoomChosenValue = data[StringManager.extraRoom];
      _carParkChosenValue = data[StringManager.carPark];
      _totalPortion = data[StringManager.totalPortion] ?? '';
      _totalIncome = data[StringManager.totalIncome] ?? '';
      _rentalIncome = data[StringManager.rentalIncome] ?? false;
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
      StringManager.furnished: _furnishedChosenValue,
      StringManager.floors: _floorsChosenValue,
      StringManager.bedRoom: _bedRoomChosenValue,
      StringManager.bathRoom: _bathRoomChosenValue,
      StringManager.carPark: _carParkChosenValue,
      StringManager.extraRoom: _extraRoomChosenValue,
      StringManager.totalPortion: _totalPortion,
      StringManager.totalIncome: _totalIncome,
      StringManager.rentalIncome: _rentalIncome,
    };
  }
}
