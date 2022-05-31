import 'dart:collection';
import 'package:flutter/material.dart';

class PostYourPropertyProviderOne extends ChangeNotifier {
  // for propertyCategoryDropDown
  final List<String> _propertyCategoryDropDown = [
    'Residential',
    'Commercial',
    'Farm'
  ];
  List<String> _propertyTypeDropDown = [];
  final List<String> _residential = [
    'Plot',
    'Flat',
    'Villa',
    'Rental',
    'House'
  ];
  final List<String> _commercial = ['Shop', 'Office', 'Godown'];
  final List<String> _farm = ['Plot', 'Farm House', 'Land'];

  String? _propertyCategoryChosenValue;
  String? _propertyTypeChosenValue;

  String? get propertyCategoryChosenValue => _propertyCategoryChosenValue;

  UnmodifiableListView<String> get propertyCategoryDropDown =>
      UnmodifiableListView(_propertyCategoryDropDown);

  void onChangedPropertyCategory(value) {
    if (value == 'Residential') {
      _propertyTypeDropDown = _residential;
    }
    if (value == 'Commercial') {
      _propertyTypeDropDown = _commercial;
    }
    if (value == 'Farm') {
      _propertyTypeDropDown = _farm;
    }
    _propertyTypeChosenValue = null;
    _propertyCategoryChosenValue = value;
    notifyListeners();
  }

  // for propertyTypeDropDown

  String? get propertyTypeChosenValue => _propertyTypeChosenValue;

  UnmodifiableListView<String> get propertyTypeDropDown =>
      UnmodifiableListView(_propertyTypeDropDown);

  void onChangedPropertyType(value) {
    _propertyTypeChosenValue = value;
    notifyListeners();
  }

  // for possessionStatusDropDown

  final List<String> _possessionStatusDropDown = [
    'Ready to Move',
    'Under Construction',
    'Resale'
  ];
  String? _possessionStatusChosenValue;

  String? get possessionStatusChosenValue => _possessionStatusChosenValue;

  UnmodifiableListView<String> get possessionStatusDropDown =>
      UnmodifiableListView(_possessionStatusDropDown);

  void onChangedPossessionStatus(value) {
    _possessionStatusChosenValue = value;
    notifyListeners();
  }

  // for ageDropDown
  final List<String> _ageDropDown = ['New', '0 - 3', '3 - 5', '5 - 10', '10+'];
  String? _ageChosenValue;

  String? get ageChosenValue => _ageChosenValue;

  UnmodifiableListView<String> get ageDropDown =>
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

  // for locationTextField

  final TextEditingController _locationController = TextEditingController();

  TextEditingController get locationController => _locationController;

  String? validateLocation(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Location can't be empty";
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
      'location': _locationController.text,
      'age': _ageChosenValue,
      'price': _price
    };
  }

  void resetAllData() {
    _propertyCategoryChosenValue = null;
    _propertyTypeChosenValue = null;
    _possessionStatusChosenValue = null;
    _locationController.clear();
    _ageChosenValue = null;
    _controller.text = '';
    notifyListeners();
  }
}
