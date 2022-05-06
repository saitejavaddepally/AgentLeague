import 'package:shared_preferences/shared_preferences.dart';
const String currentPlot = "CURRENT_PLOT";

class SharedPreferencesHelper {

  Future<void> saveCurrentPlot(String plot) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(currentPlot, plot);
  }

  Future<String?> getCurrentPlot() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(currentPlot);
  }
}
