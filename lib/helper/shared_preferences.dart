import 'package:shared_preferences/shared_preferences.dart';

const String currentPlot = "CURRENT_PLOT";
const String currentCardPage = "CURRENT_CARD_PAGE";
const String currentUserId = "CURRENT_USER_ID";
const String numberOfProperties = "NUMBER_OF_PROPERTIES";
const String images = "PLOT_IMAGES";
const String pageOneInformation = "PAGE_ONE_INFORMATION";
const String pageTwoInformation = "PAGE_TWO_INFORMATION";

class SharedPreferencesHelper {
  Future<void> saveCurrentPlot(String plot) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(currentPlot, plot);
  }

  Future<String?> getCurrentPlot() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(currentPlot);
  }

  Future<void> saveCurrentPage(String page) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(currentCardPage, page);
  }

  Future<String?> getCurrentPage() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(currentCardPage);
  }


  Future<void> saveUserId(String userId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(currentUserId, userId);
  }

  Future<String?> getUserId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(currentUserId);
  }

  Future<void> saveNumProperties(String properties) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(numberOfProperties, properties);
  }

  Future<String?> getNumProperties() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(numberOfProperties);
  }

  Future<void> saveListOfCards(var properties) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(images, properties.toString());
  }

  Future<String?> getListOfCards() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(images);
  }

  removeListOfCards() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove(images);
  }


  Future<void> savePageOneInformation(Map<String, dynamic> pageInfo) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(pageOneInformation, pageInfo.toString());
  }

  Future<String?> getPageOneInformation() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(pageOneInformation);
  }

  Future<void> savePageTwoInformation(Map<String, dynamic> pageInfo) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(pageTwoInformation, pageInfo.toString());
  }

  Future<String?> getPageTwoInformation() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(pageTwoInformation);
  }


}
