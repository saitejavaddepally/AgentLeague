import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PropertyDigitalizationProvider extends ChangeNotifier {
  int _totalWalletBalance = 500;
  int _balanceAfterTransaction = 500;

  int _amountUsed = 0;
  int _digitalizationCharges = 99;
  int _gstAmount = 18;
  int _promocodeAmount = 0;
  var grandTotal = 0;

  PropertyDigitalizationProvider() {
    grandTotal = (_digitalizationCharges + _gstAmount) -
        (_amountUsed + _promocodeAmount);
  }

  int get digitalizationCharges => _digitalizationCharges;
  int get gstAmount => _gstAmount;
  int get promocodeAmount => _promocodeAmount;
  int get amountUsed => _amountUsed;
  int get totalWalletBalance => _totalWalletBalance;
  int get balanceAfterTransaction => _balanceAfterTransaction;

  //amount used textfield
  TextEditingController amountUsedController = TextEditingController();

  amountUsedOnWallet() {
    _amountUsed = int.parse(amountUsedController.text);
    if (_amountUsed > _totalWalletBalance) {
      Fluttertoast.showToast(msg: "Not Enough Balance");
      return;
    }
    if (_amountUsed > 99) {
      Fluttertoast.showToast(msg: "Amount should be less than 100");
      return;
    }
    _balanceAfterTransaction = _totalWalletBalance - _amountUsed;
    grandTotal = (_digitalizationCharges + _gstAmount) -
        (_amountUsed + _promocodeAmount);
    notifyListeners();
  }
}
