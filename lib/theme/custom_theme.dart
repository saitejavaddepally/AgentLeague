// ignore_for_file: depend_on_referenced_packages

import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'colors.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class CustomTheme with ChangeNotifier {
  static bool _isDarkTheme = true;

  static bool get isDarkTheme => _isDarkTheme;

  ThemeMode get currentTheme => _isDarkTheme ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }

  static ThemeData lightTheme(context) {
    return ThemeData(
      canvasColor: Colors.white,
      scaffoldBackgroundColor: Colors.white,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 12,
          letterSpacing: -0.15,
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 12,
          letterSpacing: -0.15,
        ),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black.withOpacity(0.3),
      ),
      tabBarTheme: TabBarTheme(
        unselectedLabelColor: HexColor("#b48484"),
        labelColor: Colors.black,
        indicatorSize: TabBarIndicatorSize.label,
        labelStyle: const TextStyle(fontSize: 27),
        indicator: MaterialIndicator(
          height: 4,
          bottomLeftRadius: 5,
          bottomRightRadius: 5,
          horizontalPadding: 5,
          color: HexColor('FE7F0E'),
        ),
      ),
      textTheme: Theme.of(context)
          .textTheme
          .apply(bodyColor: Colors.black, displayColor: Colors.black),
      iconTheme: const IconThemeData(color: Colors.black),
    );
  }

  static ThemeData darkTheme(context) {
    return ThemeData(
      canvasColor: CustomColors.dark,
      scaffoldBackgroundColor: CustomColors.dark,
      appBarTheme: AppBarTheme(backgroundColor: CustomColors.dark),
      dialogBackgroundColor: CustomColors.dark,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 12,
          letterSpacing: -0.15,
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 12,
          letterSpacing: -0.15,
        ),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        backgroundColor: CustomColors.dark,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(0.3),
      ),
      tabBarTheme: TabBarTheme(
        unselectedLabelColor: HexColor("#b48484"),
        indicatorSize: TabBarIndicatorSize.label,
        labelStyle: const TextStyle(fontSize: 27),
        indicator: MaterialIndicator(
          height: 4,
          bottomLeftRadius: 5,
          bottomRightRadius: 5,
          horizontalPadding: 5,
          color: HexColor('FE7F0E'),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: Colors.white.withOpacity(0.3)),
        fillColor: Colors.white.withOpacity(0.1),
        filled: true,
      ),
      colorScheme:
          Theme.of(context).colorScheme.copyWith(primary: Colors.white),
      textTheme: Theme.of(context)
          .textTheme
          .apply(bodyColor: Colors.white, displayColor: Colors.white),
      primaryTextTheme: TextTheme(
        headline6: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontSize: 16,
            fontWeight: FontWeight.normal),
        //for dropDown chosen value
        headline5: const TextStyle(
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.normal),
      ),
      iconTheme: const IconThemeData(color: Colors.white),
    );
  }

  // static NeumorphicThemeData get lightTheme {
  //   return NeumorphicThemeData(
  //       baseColor: Colors.grey,
  //       defaultTextColor: Colors.black,
  //       lightSource: LightSource.topLeft,
  //       shadowLightColor: Colors.black.withOpacity(0.7));
  // }

  // static NeumorphicThemeData get darkTheme {
  //   return NeumorphicThemeData(
  //       baseColor: CustomColors.dark,
  //       defaultTextColor: Colors.white,
  //       iconTheme: const IconThemeData(color: Colors.white),
  //       lightSource: LightSource.topLeft,
  //       shadowLightColor: Colors.blue.withOpacity(0.7));
  // }
}
