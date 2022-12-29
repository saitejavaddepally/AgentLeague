// ignore_for_file: await_only_futures

import 'package:agent_league/helper/string_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static Future<bool?> isOnboardingSeen() async {
    bool? isSeen = false;
    final preferences = await SharedPreferences.getInstance();

    isSeen = await preferences.getBool(StringManager.isOnboardingSeen);
    return isSeen;
  }

  static Future<void> setOnboardingSeen(bool isSeen) async {
    final preferences = await SharedPreferences.getInstance();
    preferences.setBool(StringManager.isOnboardingSeen, isSeen);
  }
}
