import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'colors.dart';

class CustomTheme with ChangeNotifier {
  static bool _isDarkTheme = true;

  ThemeMode get currentTheme => _isDarkTheme ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }

  static NeumorphicThemeData get lightTheme {
    return NeumorphicThemeData(
        baseColor: Colors.grey,
        defaultTextColor: Colors.black,
        lightSource: LightSource.topLeft,
        shadowLightColor: Colors.black.withOpacity(0.7));
  }

  static NeumorphicThemeData get darkTheme {
    return NeumorphicThemeData(
        baseColor: CustomColors.dark,
        defaultTextColor: Colors.white,
        lightSource: LightSource.topLeft,
        shadowLightColor: Colors.blue.withOpacity(0.7));
  }
}
