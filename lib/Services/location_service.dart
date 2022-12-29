import 'dart:convert';

import 'package:agent_league/Services/keys.dart';
import 'package:agent_league/helper/string_manager.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart' as loc;

class GetUserLocation {
  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  static Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      final isAllow = await loc.Location().requestService();
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      if (!isAllow) {
        return Future.error(StringManager.disabledLocationError);
      }
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error(StringManager.locationPermissionDeniedError);
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(StringManager.locationPermissionDeniedForeverError);
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  static Future<List?> getCurrentLocation() async {
    try {
      final Position position = await determinePosition();

      final address = await _getAddressFromCoordinates(
          LatLng(position.latitude, position.longitude));
      return [address, position.latitude, position.longitude];
    } catch (e) {
      if (e.toString() == StringManager.disabledLocationError) {
        Fluttertoast.showToast(msg: StringManager.openLocationMsg);
      } else if (e.toString() == StringManager.locationPermissionDeniedError) {
        Fluttertoast.showToast(msg: StringManager.allowLocationPermissionMsg);
      } else if (e.toString() ==
          StringManager.locationPermissionDeniedForeverError) {
        Fluttertoast.showToast(msg: StringManager.locationPermanentlyDeniedMsg);
      }
      return null;
    }
  }

  static Future<List?> getMapLocation(BuildContext context) async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      final isAllow = await loc.Location().requestService();
      if (!isAllow) {
        return null;
      }
    }
    final List result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FutureBuilder<Position>(
            future: determinePosition(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return PlacePicker(
                  apiKey: mapKey,
                  onPlacePicked: (result) {
                    Navigator.pop(context, [
                      result.formattedAddress,
                      result.geometry?.location.lat,
                      result.geometry?.location.lng
                    ]);
                  },
                  hintText: "Search",
                  enableMapTypeButton: false,
                  initialPosition:
                      LatLng(snapshot.data!.latitude, snapshot.data!.longitude),
                  useCurrentLocation: true,
                );
              } else if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );

    return result;
  }

  static Future<String> _getAddressFromCoordinates(LatLng userLocation) async {
    var url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${userLocation.latitude},${userLocation.longitude}&sensor=true&key=$mapKey');
    var _response = await http.get(url);
    var data = _response.body;
    Map<String, dynamic> data2 = jsonDecode(data);
    List<dynamic> list = data2['results'];

    var result = list[0]['formatted_address'].toString();
    return result;
  }
}
