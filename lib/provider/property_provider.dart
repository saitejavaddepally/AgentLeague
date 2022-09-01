import 'dart:collection';

import 'package:flutter/material.dart';

class PropertyProvider extends ChangeNotifier {
  // for companyNameTextField
  final TextEditingController _companyNameController = TextEditingController();
  String _companyName = '';

  TextEditingController get companyNameController => _companyNameController;

  onSubmittedCompanyName(value) {
    _companyName = value;
  }

  String? validateCompanyName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Company Name Required';
    } else {
      return null;
    }
  }

  // for ventureNameTextField
  final TextEditingController _ventureNameController = TextEditingController();
  String _ventureName = '';

  TextEditingController get ventureNameController => _ventureNameController;

  onSubmittedVentureName(value) {
    _ventureName = value;
  }

  String? validateVentureName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Venture Name Required';
    } else {
      return null;
    }
  }

  // for projectCategoryDropDown
  final List<String> _projectCategoryDropDown = ['villas', 'hiRise', 'hmda'];
  String? _projectCategoryChosenValue;

  String? get projectCategoryChosenValue => _projectCategoryChosenValue;

  UnmodifiableListView<String> get projectCategoryDropDown =>
      UnmodifiableListView(_projectCategoryDropDown);

  void onChangedProjectCategory(value) {
    _projectCategoryChosenValue = value;
    notifyListeners();
  }

  // for projectLocationTextField
  final TextEditingController _projectLocationController =
      TextEditingController();
  String _projectLocation = '';
  late double latitude;
  late double longitude;

  TextEditingController get projectLocationController =>
      _projectLocationController;

  onSubmittedProjectLocation(value) {
    _projectLocation = value;
  }

  String? validateProjectLocation(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Project Location Required';
    } else {
      return null;
    }
  }

  // for totalUnitsTextField
  final TextEditingController _totalUnitsController = TextEditingController();
  String _totalUnits = '';

  TextEditingController get totalUnitsController => _totalUnitsController;

  onSubmittedTotalUnits(value) {
    _totalUnits = value;
  }

  String? validateTotalUnits(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Total units/plots Required';
    } else {
      return null;
    }
  }

  // for possessionStateDropDown
  final List<String> _possessionStateDropDown = ['abc', 'def'];
  String? _possessionStateChosenValue;

  String? get possessionStateChosenValue => _possessionStateChosenValue;

  UnmodifiableListView<String> get possessionStateDropDown =>
      UnmodifiableListView(_possessionStateDropDown);

  void onChangedPossessionState(value) {
    _possessionStateChosenValue = value;
    notifyListeners();
  }

  // for totalProjectAreaTextField
  final TextEditingController _totalProjectAreaController =
      TextEditingController();
  String _totalProjectArea = '';

  TextEditingController get totalProjectAreaController =>
      _totalProjectAreaController;

  onSubmittedTotalProjectArea(value) {
    _totalProjectArea = value;
  }

  String? validateTotalProjectArea(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Total project area Required';
    } else {
      return null;
    }
  }

  // for unitSizeOneTextField
  final TextEditingController _unitSizeOneController = TextEditingController();
  String _unitSizeOne = '';

  TextEditingController get unitSizeOneController => _unitSizeOneController;

  onSubmittedUnitSizeOne(value) {
    _unitSizeOne = value;
  }

  String? validateUnitSizeOne(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Field Required';
    } else {
      return null;
    }
  }

  // for unitSizeTwoTextField
  final TextEditingController _unitSizeTwoController = TextEditingController();
  String _unitSizeTwo = '';

  TextEditingController get unitSizeTwoController => _unitSizeTwoController;

  onSubmittedUnitSizeTwo(value) {
    _unitSizeTwo = value;
  }

  String? validateUnitSizeTwo(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Field Required';
    } else {
      return null;
    }
  }

  // for unitSizeDropDown
  final List<String> _unitSizeDropDown = ['abc', 'def'];
  String? _unitSizeChosenValue;

  String? get unitSizeChosenValue => _unitSizeChosenValue;

  UnmodifiableListView<String> get unitSizeDropDown =>
      UnmodifiableListView(_unitSizeDropDown);

  void onChangedUnitSize(value) {
    _unitSizeChosenValue = value;
    notifyListeners();
  }

  // for pricePerUnitTextField
  final TextEditingController _pricePerUnitController = TextEditingController();
  String _pricePerUnit = '';

  TextEditingController get pricePerUnitController => _pricePerUnitController;

  onSubmittedPricePerUnit(value) {
    _pricePerUnit = value;
  }

  String? validatePricePerUnit(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Field Required';
    } else {
      return null;
    }
  }

  // for pricePerUnitDropDown
  final List<String> _pricePerUnitDropDown = ['abc', 'def'];
  String? _pricePerUnitChosenValue;

  String? get pricePerUnitChosenValue => _pricePerUnitChosenValue;

  UnmodifiableListView<String> get pricePerUnitDropDown =>
      UnmodifiableListView(_pricePerUnitDropDown);

  void onChangedPricePerUnit(value) {
    _pricePerUnitChosenValue = value;
    notifyListeners();
  }

  // for approvedByDropDown
  final List<String> _approvedByDropDown = ['abc', 'def'];
  String? _approvedByChosenValue;

  String? get approvedByChosenValue => _approvedByChosenValue;

  UnmodifiableListView<String> get approvedByDropDown =>
      UnmodifiableListView(_approvedByDropDown);

  void onChangedApprovedBy(value) {
    _approvedByChosenValue = value;
    notifyListeners();
  }

  void resetAllData() {
    _companyNameController.clear();
    _ventureNameController.clear();
    _projectCategoryChosenValue = null;
    _projectLocationController.clear();
    _totalProjectAreaController.clear();
    _totalUnitsController.clear();
    _possessionStateChosenValue = null;
    _unitSizeOneController.clear();
    _unitSizeTwoController.clear();
    _unitSizeChosenValue = null;
    _pricePerUnitController.clear();
    _pricePerUnitChosenValue = null;
    _approvedByChosenValue = null;
    notifyListeners();
  }

  Map<String, dynamic> getMap() {
    return {
      'companyName': _companyName,
      'ventureName': _ventureName,
      'projectCategory': _projectCategoryChosenValue,
      'projectLocation': _projectLocation,
      'totalProject': _totalProjectArea,
      'totalUnits': _totalUnits,
      'possessionState': _possessionStateChosenValue,
      'unitSizeOne': _unitSizeOne,
      'unitSizeTwo': _unitSizeTwo,
      'unitSizeDropDown': _unitSizeChosenValue,
      'pricePerUnitText': _pricePerUnit,
      'pricePerUnitDropDow': _pricePerUnitChosenValue,
      'approvedBy': _approvedByChosenValue,
      'isExport': false,
    };
  }
}
