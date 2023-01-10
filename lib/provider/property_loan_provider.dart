import 'dart:collection';

import 'package:flutter/material.dart';

class PropertyLoanProvider extends ChangeNotifier {
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

  // for loanTypeDropDown
  final List<String> _loanTypeDropDown = ['abc', 'def'];

  String? _loanTypeChosenValue;

  String? get loanTypeChosenValue => _loanTypeChosenValue;

  UnmodifiableListView<String> get loanTypeDropDown =>
      UnmodifiableListView(_loanTypeDropDown);

  void onChangedLoanType(value) {
    _loanTypeChosenValue = value;
    notifyListeners();
  }

  // for crTextField
  final TextEditingController crController = TextEditingController();

  String? validateCr(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Field Required";
    } else {
      return null;
    }
  }

  // for lksTextField
  final TextEditingController lksController = TextEditingController();

  String? validateLks(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Field Required";
    } else {
      return null;
    }
  }

  void resetData() {
    nameController.clear();
    mobileController.clear();
    _loanTypeChosenValue = null;
    crController.clear();
    lksController.clear();
    notifyListeners();
  }
}
