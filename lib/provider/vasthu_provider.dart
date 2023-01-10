import 'dart:collection';

import 'package:flutter/material.dart';

class VasthuProvider extends ChangeNotifier {
  // for nameTextField
  final TextEditingController nameController = TextEditingController();

  String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Enter Your Name";
    } else {
      return null;
    }
  }

  // for mobileTextField

  final TextEditingController mobileController = TextEditingController();

  String? validateMobile(String? value) {
    if (value == null || value.isEmpty || value.length != 10) {
      return "Enter Correct Mobile Number";
    }
    return null;
  }

  // for addressTypeDropDown
  final List<String> _addressDropDown = ['abc', 'def'];

  String? _addressChosenValue;

  String? get addressChosenValue => _addressChosenValue;

  UnmodifiableListView<String> get addressDropDown =>
      UnmodifiableListView(_addressDropDown);

  void onChangedAddress(value) {
    _addressChosenValue = value;
    notifyListeners();
  }

  // for propertyTypeDropDown
  final List<String> _propertyTypeDropDown = ['abc', 'def'];

  String? _propertyTypeChosenValue;

  String? get propertyTypeChosenValue => _propertyTypeChosenValue;

  UnmodifiableListView<String> get propertyTypeDropDown =>
      UnmodifiableListView(_propertyTypeDropDown);

  void onChangedPropertyType(value) {
    _propertyTypeChosenValue = value;
    notifyListeners();
  }

  // for dateTextField
  final TextEditingController dateController = TextEditingController();

  String? validateDate(String? size) {
    if (size == null || size.trim().isEmpty) {
      return 'Date Required';
    } else {
      return null;
    }
  }

  DateTime selectedDate = DateTime.now();

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(DateTime.now().year - 70),
        lastDate: DateTime(DateTime.now().year + 70));
    if (picked != null) {
      selectedDate = picked;
      dateController.text = "${picked.day}/${picked.month}/${picked.year}";
    }
  }

  void resetData() {
    nameController.clear();
    mobileController.clear();
    _addressChosenValue = null;
    dateController.clear();
    _propertyTypeChosenValue = null;
    notifyListeners();
  }
}
