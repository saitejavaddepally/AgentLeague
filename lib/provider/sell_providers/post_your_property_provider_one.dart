import 'dart:collection';
import 'package:flutter/material.dart';

class PostYourPropertyProviderOne extends ChangeNotifier {
  String _price = '';
  double latitude = 0;
  double longitude = 0;

  PostYourPropertyProviderOne(data) {
    if (data != null) {
      final propertyCategory = data['propertyCategory'];
      if (propertyCategory == 'Residential') {
        _propertyTypeDropDown = _residential;
      }
      if (propertyCategory == 'Commercial') {
        _propertyTypeDropDown = _commercial;
      }
      if (propertyCategory == 'Farm') {
        _propertyTypeDropDown = _farm;
      }
      _propertyCategoryChosenValue = data['propertyCategory'];
      final propertyType = data['propertyType'];
      _propertyTypeChosenValue = propertyType;
      if (_skipList.contains(propertyType)) {
        isSkipPageTwo = false;
      } else {
        isSkipPageTwo = true;
      }
      final possessionStatus = data['possessionStatus'];

      _possessionStatusChosenValue = possessionStatus;

      if (possessionStatus == 'Under Construction') {
        _isVisible = true;
      } else {
        _isVisible = false;
      }

      if (possessionStatus == 'Ready to Move' ||
          possessionStatus == 'Under Construction') {
        _ageChosenValue = 'New';
        _disableAge = true;
      } else {
        _disableAge = false;
      }

      _controller.text = data['price'].toString();
      _locationController.text = data['location'];
      _ageChosenValue = data['age'];
      _facingChosenValue = data['facing'];
      handOverYearController.text = data['handOverYear'];
      handOverMonthController.text = data['handOverMonth'];
      _sizeController.text = data['size'].toString().split(' ')[0];
      _sizeChosenValue = data['size'].toString().split(' ')[1];
    }
  }

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
  bool isSkipPageTwo = true;
  final List<String> _skipList = [
    'Flat',
    'Villa',
    'Rental',
    'House',
    'Farm House'
  ];
  UnmodifiableListView<String> get propertyTypeDropDown =>
      UnmodifiableListView(_propertyTypeDropDown);

  void onChangedPropertyType(value) {
    if (_skipList.contains(value)) {
      isSkipPageTwo = false;
    } else {
      isSkipPageTwo = true;
    }
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

  bool _isVisible = false;
  bool get isVisible => _isVisible;

  bool _disableAge = false;
  bool get disableAge => _disableAge;

  String? get possessionStatusChosenValue => _possessionStatusChosenValue;

  UnmodifiableListView<String> get possessionStatusDropDown =>
      UnmodifiableListView(_possessionStatusDropDown);

  void onChangedPossessionStatus(value) {
    if (value == 'Under Construction') {
      _isVisible = true;
    } else {
      _isVisible = false;
    }

    if (value == 'Ready to Move' || value == 'Under Construction') {
      _ageChosenValue = 'New';
      _disableAge = true;
    } else {
      _disableAge = false;
    }

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

  // for handOverYearTextField
  final TextEditingController handOverYearController = TextEditingController();
  String _handOverYear = '';

  onSubmittedHandOverYear(value) {
    _handOverYear = value;
  }

  String? validateHandOverYear(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'HandOver Year Required';
    } else {
      return null;
    }
  }

  // for handOverYearTextField
  final TextEditingController handOverMonthController = TextEditingController();
  String _handOverMonth = '';

  onSubmittedHandOverMonth(value) {
    _handOverMonth = value;
  }

  String? validateHandOverMonth(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'HandOver Month Required';
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
      'price': int.parse(_controller.text),
      'facing': _facingChosenValue,
      'handOverYear': handOverYearController.text,
      'handOverMonth': handOverMonthController.text,
      'size': _sizeController.text + ' ' + _sizeChosenValue!,
      'latitude': latitude,
      'longitude': longitude,
      'box_enabled': 0,
    };
  }

  void resetAllData() {
    _propertyCategoryChosenValue = null;
    _propertyTypeChosenValue = null;
    _possessionStatusChosenValue = null;
    handOverMonthController.clear();
    handOverYearController.clear();
    _locationController.clear();
    _ageChosenValue = null;
    _controller.clear();
    _facingChosenValue = null;
    _sizeController.clear();
    _sizeChosenValue = null;
    latitude = 0;
    longitude = 0;
    notifyListeners();
  }
}
