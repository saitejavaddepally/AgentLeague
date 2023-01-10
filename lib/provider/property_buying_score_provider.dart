import 'package:flutter/material.dart';

import '../ui/property_buying_score.dart';

class PropertyBuyingScoreProvider extends ChangeNotifier {
  // for dobTextField
  final TextEditingController dobController = TextEditingController();

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
      dobController.text = "${picked.day}/${picked.month}/${picked.year}";
    }
  }

  bool _employee = false;
  bool _freelancer = true;
  bool _business = false;

  bool get employee => _employee;
  bool get freelancer => _freelancer;
  bool get business => _business;

  void onEmployeeClick() {
    if (_employee == false) {
      _employee = true;
      _freelancer = false;
      _business = false;
      notifyListeners();
    }
  }

  void onFreelancerClick() {
    if (_freelancer == false) {
      _employee = false;
      _freelancer = true;
      _business = false;
      notifyListeners();
    }
  }

  void onBusinessClick() {
    if (_business == false) {
      _employee = false;
      _freelancer = false;
      _business = true;
      notifyListeners();
    }
  }

  // for monthlyIncomeTextField
  final TextEditingController monthlyIncomeController = TextEditingController();

  String? validateMonthlyIncome(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Monthly Income Required";
    } else {
      return null;
    }
  }

  // for monthlyEmiTextField
  final TextEditingController monthlyEmiController = TextEditingController();

  String? validateMonthlyEmi(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Monthly Emi Required";
    } else {
      return null;
    }
  }

  // for extraIncomeTextField
  final TextEditingController extraIncomeController = TextEditingController();

  String? validateExtraIncome(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Extra Income Required";
    } else {
      return null;
    }
  }

  // for downPaymentTextField
  final TextEditingController downPaymentController = TextEditingController();

  String? validateDownPayment(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Down Payment Required";
    } else {
      return null;
    }
  }

  // incomeTaxButtom
  bool _incomeTax = true;

  bool get incomeTax => _incomeTax;

  onYesClickIncomeTax() {
    if (_incomeTax == false) {
      _incomeTax = true;
      notifyListeners();
    }
  }

  onNoClickIncomeTax() {
    if (_incomeTax == true) {
      _incomeTax = false;
      notifyListeners();
    }
  }

// loanButtom
  bool _loan = false;

  bool get loan => _loan;

  onYesClickLoan() {
    if (_loan == false) {
      _loan = true;
      notifyListeners();
    }
  }

  onNoClickLoan() {
    if (_loan == true) {
      _loan = false;
      notifyListeners();
    }
  }

// coBorrowerButtom
  bool _coBorrower = false;
  String _coBorrowerIncome = '0';
  String _coBorrowerEMI = '0';
  bool get coBorrower => _coBorrower;

  onYesClickCoBorrower(BuildContext context) async {
    if (_coBorrower == false) {
      final list = await showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => CustomDialog());

      if (list != null) {
        _coBorrowerIncome = list[0];
        _coBorrowerEMI = list[1];
        _coBorrower = true;
        notifyListeners();
      }
    }
  }

  onNoClickCoBorrower() {
    if (_coBorrower == true) {
      _coBorrowerIncome = '0';
      _coBorrowerEMI = '0';
      _coBorrower = false;
      notifyListeners();
    }
  }

  void resetAllData() {
    dobController.clear();
    monthlyIncomeController.clear();
    monthlyEmiController.clear();
    extraIncomeController.clear();
    downPaymentController.clear();
    _coBorrower = false;
    _incomeTax = false;
    _loan = false;
    _coBorrowerIncome = '0';
    _coBorrowerEMI = '0';
    notifyListeners();
  }

  Map<String, dynamic> getData() => {
        'dob': dobController.text,
        'monthlyIncome': int.parse(monthlyIncomeController.text),
        'monthlyEmi': int.parse(monthlyEmiController.text),
        'extraIncome': int.parse(extraIncomeController.text),
        'downPayment': int.parse(downPaymentController.text),
        'coBorrowerIncome': int.parse(_coBorrowerIncome),
        'coBorrowerEmi': int.parse(_coBorrowerEMI)
      };

  List<num> calculateRange() {
    final range = (int.parse(monthlyIncomeController.text) +
                int.parse(extraIncomeController.text) -
                int.parse(monthlyEmiController.text)) *
            50 +
        (int.parse(_coBorrowerIncome) - int.parse(_coBorrowerEMI)) * 50 +
        int.parse(downPaymentController.text);

    final rangePlus = range + (range * 0.20);
    return [range, rangePlus];
  }
}
