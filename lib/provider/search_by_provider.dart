import 'dart:collection';

import 'package:agent_league/helper/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'firestore_data_provider.dart';

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
        final lat2 = plotPageInformation[i][0]['latitude'];
        final long2 = plotPageInformation[i][0]['longitude'];

        final distanceInMeter =
            Geolocator.distanceBetween(lat1, long1, lat2, long2);
        final distanceInKm = distanceInMeter / 1000;

        if (distanceInKm <= km) {
          _matchedRecords.add(plotPageInformation[i]);
        }
      }
      print(_matchedRecords);
      notifyListeners();
    } on Exception catch (e) {
      print(e);
    }
  }

  resetData() {
    _chosenKm = null;
    locationController.clear();
    notifyListeners();
  }
}
