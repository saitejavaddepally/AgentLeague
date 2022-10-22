import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'colors.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class CustomTheme with ChangeNotifier {
  static bool _isDarkTheme = false;

  static bool get isDarkTheme => _isDarkTheme;

  ThemeMode get currentTheme => _isDarkTheme ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }

  static ThemeData lightTheme(context) {
    return ThemeData(
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
      scaffoldBackgroundColor: CustomColors.dark,
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
      textTheme: Theme.of(context)
          .textTheme
          .apply(bodyColor: Colors.white, displayColor: Colors.white),
      iconTheme: const IconThemeData(color: Colors.black),
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
