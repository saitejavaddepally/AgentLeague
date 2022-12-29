import 'dart:developer';

import 'package:agent_league/helper/string_manager.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'package:collection/collection.dart';

class LocationSearchProvider extends ChangeNotifier {
  double? latitude;
  double? longitude;
  final List _matchedRecords = [];

  UnmodifiableListView get matchedRecords =>
      UnmodifiableListView(_matchedRecords);

  TextEditingController locationController = TextEditingController();

  String? validateLocation(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Please Choose Location";
    } else {
      return null;
    }
  }

  final List _kmDropDownItems = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

  UnmodifiableListView get kmDropDownItems =>
      UnmodifiableListView(_kmDropDownItems);

  int? _chosenKm;

  int? get chosenKm => _chosenKm;

  onChangedKm(value) {
    _chosenKm = value;
    notifyListeners();
  }

  getAllPlots(
      List plotPageInformation, double lat1, double long1, int km) async {
    try {
      _matchedRecords.clear();
      for (int i = 0; i < plotPageInformation.length; i++) {
        final lat2 = plotPageInformation[i]['latitude'];
        final long2 = plotPageInformation[i]['longitude'];

        final distanceInMeter =
            Geolocator.distanceBetween(lat1, long1, lat2, long2);
        final distanceInKm = distanceInMeter / 1000;

        if (distanceInKm <= km) {
          _matchedRecords.add(plotPageInformation[i]);
        }
      }

      notifyListeners();
    } catch (e) {
      log(e.toString());
    }
  }

  resetData() {
    _chosenKm = null;
    locationController.clear();
    notifyListeners();
  }
}

class PriceSearchProvider extends ChangeNotifier {
  final List<int> _minimumPriceCrItems = [1, 100, 200, 300, 5000000];

  UnmodifiableListView<int> get minimumPriceCrItems =>
      UnmodifiableListView(_minimumPriceCrItems);

  int _minimumPriceCrChosenValue = 1;

  int get minimumPriceCrChosenValue => _minimumPriceCrChosenValue;

  void onChangedMinimumPriceCr(value) {
    _minimumPriceCrChosenValue = value;
  }

  final List<int> _minimumPriceLakhItems = [100, 200];

  UnmodifiableListView<int> get minimumPriceLakhItems =>
      UnmodifiableListView(_minimumPriceLakhItems);

  int _minimumPriceLakhChosenValue = 100;

  int get minimumPriceLakhChosenValue => _minimumPriceLakhChosenValue;

  void onChangedMinimumPriceLakh(value) {
    _minimumPriceLakhChosenValue = value;
  }

  final List<int> _maximumPriceCrItems = [100, 200, 300, 5000, 6000000];

  UnmodifiableListView<int> get maximumPriceCrItems =>
      UnmodifiableListView(_maximumPriceCrItems);

  int _maximumPriceCrChosenValue = 100;

  int get maximumPriceCrChosenValue => _maximumPriceCrChosenValue;

  void onChangedMaximumPriceCr(value) {
    _maximumPriceCrChosenValue = value;
  }

  final List<int> _maximumPriceLakhItems = [100, 200, 300, 5000, 6000000];

  UnmodifiableListView<int> get maximumPriceLakhItems =>
      UnmodifiableListView(_maximumPriceLakhItems);

  int _maximumPriceLakhChosenValue = 100;

  int get maximumPriceLakhChosenValue => _maximumPriceLakhChosenValue;

  void onChangedMaximumPriceLakh(value) {
    _maximumPriceLakhChosenValue = value;
  }

  List<Map<String, dynamic>> _searchResult = [];

  UnmodifiableListView<Map<String, dynamic>> get searchResult =>
      UnmodifiableListView(_searchResult);

  void search(List<Map<String, dynamic>> data) {
    final minimumPrice = (minimumPriceCrChosenValue * 10000000) +
        (minimumPriceLakhChosenValue * 100000);

    final maximumPrice = (maximumPriceCrChosenValue * 10000000) +
        (maximumPriceLakhChosenValue * 100000);
    _searchResult = data
        .where((element) =>
            (element[StringManager.price] >= minimumPrice) &&
            (element[StringManager.price] <= maximumPrice))
        .toList();

    notifyListeners();
  }

  reset() {
    _minimumPriceCrChosenValue = 1;
    _minimumPriceLakhChosenValue = 100;
    _maximumPriceCrChosenValue = 100;
    _maximumPriceLakhChosenValue = 100;
    notifyListeners();
  }
}
