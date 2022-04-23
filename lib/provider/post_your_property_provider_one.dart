import 'dart:collection';
import 'package:flutter/material.dart';

class PostYourPropertyProviderOne extends ChangeNotifier {
  // for propertyCategoryDropDown
  final List<String> _propertyCategoryDropDown = ['abc', 'def'];
  String? _propertyCategoryChosenValue;

  String? get propertyCategoryChosenValue => _propertyCategoryChosenValue;

  UnmodifiableListView<String> get propertyCategoryDropDown =>
      UnmodifiableListView(_propertyCategoryDropDown);

  void onChangedPropertyCategory(value) {
    _propertyCategoryChosenValue = value;
    notifyListeners();
  }

  // for propertyTypeDropDown

  final List<String> _propertyTypeDropDown = ['ghi', 'jkl'];
  String? _propertyTypeChosenValue;

  String? get propertyTypeChosenValue => _propertyTypeChosenValue;

  UnmodifiableListView<String> get propertyTypeDropDown =>
      UnmodifiableListView(_propertyTypeDropDown);

  void onChangedPropertyType(value) {
    _propertyTypeChosenValue = value;
    notifyListeners();
  }

  // for possessionStatusDropDown

  final List<String> _possessionStatusDropDown = ['mno', 'pqr'];
  String? _possessionStatusChosenValue;

  String? get possessionStatusChosenValue => _possessionStatusChosenValue;

  UnmodifiableListView<String> get possessionStatusDropDown =>
      UnmodifiableListView(_possessionStatusDropDown);

  void onChangedPossessionStatus(value) {
    _possessionStatusChosenValue = value;
    notifyListeners();
  }

  // for locationDropDown

  final List<String> _locationDropDown = ['loc1', 'loc2'];
  String? _locationChosenValue;

  String? get locationChosenValue => _locationChosenValue;

  UnmodifiableListView<String> get locationDropDown =>
      UnmodifiableListView(_locationDropDown);

  void onChangedlocation(value) {
    _locationChosenValue = value;
    notifyListeners();
  }

  // for ageDropDown
  final List<int> _ageDropDown = [10, 15];
  int? _ageChosenValue;

  int? get ageChosenValue => _ageChosenValue;

  UnmodifiableListView<int> get ageDropDown =>
      UnmodifiableListView(_ageDropDown);

  void onChangedAge(value) {
    _ageChosenValue = value;
    notifyListeners();
  }

  // for priceTextField

  final TextEditingController _controller = TextEditingController();

  TextEditingController get controller => _controller;

  String _price = '';
  onPriceSubmitted(String price) {
    _price = price;
  }

  String? validatePrice(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Price can't be empty";
    } else {
      return null;
    }
  }

  // retreive all data
  Map<String, dynamic> getMap() {
    return {
      'propertyCategory': _propertyCategoryChosenValue,
      'propertyType': _propertyTypeChosenValue,
      'possessionStatus': _possessionStatusChosenValue,
      'location': _locationChosenValue,
      'age': _ageChosenValue,
      'price': _price
    };
  }

  void resetAllData() {
    _propertyCategoryChosenValue = null;
    _propertyTypeChosenValue = null;
    _possessionStatusChosenValue = null;
    _locationChosenValue = null;
    _ageChosenValue = null;
    _controller.text = '';
    notifyListeners();
  }
}
