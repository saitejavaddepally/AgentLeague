

import 'dart:convert';

import 'package:agent_league/Services/auth_methods.dart';
import 'package:agent_league/components/neu_circular_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:http/http.dart' as http;

import '../theme/colors.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  String googleApikey = "AIzaSyAA0QCGGA4oiunUGkKTZHgQRIStRhKMfZc";
  late Future<Position> _currentLocation;
  late GoogleMapController mapController;
  Set<Marker> _markers = {};
  late LatLng _userLocation;
  var address = '';
  void initState() {
    super.initState();
    _currentLocation = Geolocator.getCurrentPosition();
  }

  final LatLng _center = const LatLng(17.3744, 78.4999);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<void> _retrieveNearby(String address, String type) async {
    var url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/textsearch/json?query=$type+near+$address&key=AIzaSyCBMs8s8SbqSXLzoygoqc20EvzqBY5wBX0');
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please wait finding nearby $type'),
        duration: const Duration(seconds: 1)));
    var _response = await http.get(url);
    var data = _response.body;
    Map<String, dynamic> data2 = jsonDecode(data);
    List<dynamic> list = data2['results'];
    Set<Marker> _restaurantMarkers = {};
    for (int i = 0; i < list.length; i++) {
      _restaurantMarkers.add(Marker(
          markerId: MarkerId(list[i]['name']),
          icon:
          BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
          infoWindow: InfoWindow(
            title: list[i]['name'],
          ),
          position: LatLng(list[i]['geometry']['location']['lat'],
              list[i]['geometry']['location']['lng'])));
    }
    print(_restaurantMarkers);
    setState(() {
      _markers.addAll(_restaurantMarkers);
    });
    print("_markers are");
    print(_markers);
    if (_markers.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('No $type found'),
          duration: const Duration(seconds: 1)));
    }
  }

  Future<void> getAddressFromCoordinates(LatLng userLocation) async{
    var url = Uri.parse('https://maps.googleapis.com/maps/api/geocode/json?latlng=${userLocation.latitude},${userLocation.longitude}&sensor=true&key=AIzaSyCBMs8s8SbqSXLzoygoqc20EvzqBY5wBX0');
    var _response = await http.get(url);
    var data = _response.body;
    Map<String, dynamic> data2 = jsonDecode(data);
    List<dynamic> list = data2['results'];

    var result = list[0]['formatted_address'].toString().replaceAll(', ', '+').replaceAll(' ', '+');

    print("Am I here?");
    print(result);
    setState(() {
      address = result;
    });
    print(address);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: CustomColors.dark,
        leading: IconButton(
          padding: const EdgeInsets.only(left: 16),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0,
        actions: [
          Container(
              margin: const EdgeInsets.only(right: 24),
              child: IconButton(
                  onPressed: () {},
                  icon: Image.asset('assets/location_info.png')))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.68,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 8),
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: FutureBuilder(
                    future: _currentLocation,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData) {
                          Position snapshotData = snapshot.data as Position;
                          _userLocation = LatLng(
                            // snapshotData.latitude, snapshotData.longitude);
                              17.3508690, 78.5657120);
                          if (_markers.isEmpty) {
                            getAddressFromCoordinates(_userLocation) ;
                          }
                          return GoogleMap(
                            initialCameraPosition: CameraPosition(
                              target: _userLocation,
                              zoom: 13,
                            ),
                            markers: _markers
                              ..add(Marker(
                                  markerId: const MarkerId("User Location"),
                                  infoWindow:
                                  const InfoWindow(title: "User Location"),
                                  position: _userLocation)),
                          );
                        } else {
                          return const Center(
                              child: Text("Failed to get user location."));
                        }
                      }
                      return const Center(child: CircularProgressIndicator());
                    },
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 40),
                height: 100,
                child: Row(
                  children: [
                    Expanded(
                      child: CircularNeumorphicButton(
                          color: HexColor('#213c53'),
                          isNeu: true,
                          imageName: 'loc_1',
                          width: 24,
                          padding: 8,
                          onTap: () async {
                            _retrieveNearby(address, "schools" );
                            _markers = {};
                          }).use(),
                    ),
                    Expanded(
                      child: CircularNeumorphicButton(
                          color: HexColor('#213c53'),
                          isNeu: true,
                          imageName: 'loc_2',
                          width: 24,
                          padding: 8,
                          onTap: () async {
                            _retrieveNearby(address, 'library');
                            _markers = {};
                          }).use(),
                    ),
                    Expanded(
                      child: CircularNeumorphicButton(
                          color: HexColor('#213c53'),
                          isNeu: true,
                          imageName: 'loc_3',
                          width: 24,
                          padding: 8,
                          onTap: () async {
                            _retrieveNearby(address, 'supermarket');
                            _markers = {};
                          }).use(),
                    ),
                    Expanded(
                      child: CircularNeumorphicButton(
                          color: HexColor('#213c53'),
                          isNeu: true,
                          imageName: 'loc_4',
                          width: 24,
                          padding: 8,
                          onTap: () async {
                            _retrieveNearby(address, 'taxi_stand');
                            _markers = {};
                          }).use(),
                    ),
                    Expanded(
                      child: CircularNeumorphicButton(
                          color: HexColor('#213c53'),
                          isNeu: true,
                          imageName: 'loc_5',
                          width: 24,
                          padding: 8,
                          onTap: () async {
                            _retrieveNearby(address, 'store');
                            _markers = {};
                          }).use(),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
