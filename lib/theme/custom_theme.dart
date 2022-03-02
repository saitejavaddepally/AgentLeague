import 'package:flutter/material.dart';

import 'colors.dart';

class CustomTheme with ChangeNotifier {
  static bool _isDarkTheme = true;
  ThemeMode get currentTheme => _isDarkTheme ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }

  static ThemeData get lightTheme {
    //1
    return ThemeData(
        //2
        primaryColor: CustomColors.light,
        scaffoldBackgroundColor: CustomColors.light,
        fontFamily: 'pop_md', //3
        buttonTheme: ButtonThemeData(
          // 4
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
          buttonColor: CustomColors.light,
        ));
  }

  static ThemeData get darkTheme {
    return ThemeData(
        primaryColor: CustomColors.light,
        scaffoldBackgroundColor: CustomColors.dark,
        fontFamily: 'pop_md',
        textTheme: ThemeData.dark().textTheme,
        iconTheme: const IconThemeData(color: Colors.white),
        buttonTheme: ButtonThemeData(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
          buttonColor: CustomColors.light,
        ));
  }
}
