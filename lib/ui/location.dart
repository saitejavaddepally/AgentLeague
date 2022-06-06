import 'dart:async';

import 'package:agent_league/helper/shared_preferences.dart';
import 'package:agent_league/location_service.dart';
import 'package:agent_league/provider/firestore_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';

import '../components/neu_circular_button.dart';
import '../theme/colors.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  List<Marker> _markers = [];
  final GooglePlace _searchPlaces =
      GooglePlace("AIzaSyCBMs8s8SbqSXLzoygoqc20EvzqBY5wBX0");

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  void initState() {
    super.initState();
  }

  Future<Map<String, dynamic>> getPlotLocation() async {
    var number = await SharedPreferencesHelper().getCurrentPage();
    print("number is $number");
    List data = await FirestoreDataProvider()
        .getPlotPagesInformation(int.parse(number!) + 1);
    Map locationData = data[0];
    double _lat = locationData['latitude'];
    double _long = locationData['longitude'];
    print("Am I here $_lat and $_long");

    return {"latitude": _lat, "longitude": _long};
  }

  Future<void> getNearbyLocations(
      double lat, double long, String type, double color) async {
    _markers = [_markers.first];
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Finding Nearby $type"),
        duration: const Duration(seconds: 1)));
    NearBySearchResponse? result = await _searchPlaces.search.getNearBySearch(
      Location(
        lat: lat,
        lng: long,
      ),
      1200,
      type: type,
    );
    List<Marker> searchList = [];
    print(result?.status);
    if (result != null) {
      String status = result.status!;
      if (status == "OK") {
        for (int i = 0; i < result.results!.length; i++) {
          searchList.add(
            Marker(
              markerId: MarkerId(
                result.results![i].placeId.toString(),
              ),
              position: LatLng(
                result.results![i].geometry!.location!.lat!,
                result.results![i].geometry!.location!.lng!,
              ),
              infoWindow: InfoWindow(title: result.results![i].name!),
              icon: BitmapDescriptor.defaultMarkerWithHue(color),
            ),
          );
        }

        _markers.addAll(searchList);
      } else if (status == "ZERO_RESULTS") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("No $type found"),
            duration: const Duration(seconds: 1)));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Somethig Went Wrong Please Try Later")));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Somethig Went Wrong Please Try Later")));
    }
    setState(() {});
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
      body: FutureBuilder(
          future: getPlotLocation(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print("data is ${snapshot.data}");
              Map? locationCoordinates = snapshot.data as Map?;
              final double _lat = locationCoordinates!['latitude'];
              final double _long = locationCoordinates['longitude'];
              final LatLng _latlng = LatLng(_lat, _long);
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  children: [
                    Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 8),
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.white,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: GoogleMap(
                              onMapCreated: _onMapCreated,
                              markers: Set.from(_markers
                                ..add(Marker(
                                    markerId: const MarkerId("User Location"),
                                    position: _latlng,
                                    infoWindow:
                                    const InfoWindow(title: "Your Location")))),
                              initialCameraPosition: CameraPosition(
                                target: _latlng,
                                zoom: 15.0,
                              ),
                            ),
                          ),
                        )),
                    const SizedBox(height: 30),
                    SizedBox(
                      height: 70,
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
                                  await getNearbyLocations(_lat, _long,
                                      "hospital", BitmapDescriptor.hueAzure);
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
                                  await getNearbyLocations(
                                      _lat, _long, "school",
                                      BitmapDescriptor.hueCyan);
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
                                  await getNearbyLocations(_lat, _long,
                                      "supermarket",
                                      BitmapDescriptor.hueMagenta);
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
                                  await getNearbyLocations(
                                      _lat,
                                      _long,
                                      "subway_station",
                                      BitmapDescriptor.hueViolet);
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
                                  await getNearbyLocations(_lat, _long, "store",
                                      BitmapDescriptor.hueGreen);
                                }).use(),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            }
           else  if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          })
    );
  }
}

// import 'dart:async';
// import 'dart:convert';

// import 'package:agent_league/components/neu_circular_button.dart';
// import 'package:agent_league/location_service.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_neumorphic/flutter_neumorphic.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// import 'package:http/http.dart' as http;

// import '../theme/colors.dart';

// class LocationScreen extends StatefulWidget {
//   const LocationScreen({Key? key}) : super(key: key);

//   @override
//   _LocationScreenState createState() => _LocationScreenState();
// }

// class _LocationScreenState extends State<LocationScreen> {
//   final Completer<GoogleMapController> _controller = Completer();
//   Set<Marker> _markers = {};
//   late LatLng _userLocation;
//   var address = '';

//   void _onMapCreated(GoogleMapController controller) {
//     _controller.complete(controller);
//   }

//   Future<void> _retrieveNearby(
//       String address, String type, double color) async {
//     var url = Uri.parse(
//         'https://maps.googleapis.com/maps/api/place/textsearch/json?query=$type+near+$address&key=AIzaSyCBMs8s8SbqSXLzoygoqc20EvzqBY5wBX0');
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text('Please wait finding nearby $type'),
//         duration: const Duration(seconds: 1)));
//     var _response = await http.get(url);
//     var data = _response.body;
//     Map<String, dynamic> data2 = jsonDecode(data);

//     List<dynamic> list = data2['results'];
//     print("Status");
//     print(data2['status']);

//     Set<Marker> _restaurantMarkers = {};

//     for (int i = 0; i < list.length; i++) {
//       print('');
//       double lat = list[i]['geometry']['location']['lat'];
//       double long = list[i]['geometry']['location']['lng'];
//       LatLng latLng = LatLng(lat, long);

//       _restaurantMarkers.add(Marker(
//           markerId: MarkerId(list[i]['name']),
//           icon: BitmapDescriptor.defaultMarkerWithHue(color),
//           infoWindow: InfoWindow(
//             title: list[i]['name'],
//           ),
//           position: latLng));
//     }
//     print(_restaurantMarkers);
//     setState(() {
//       _markers.addAll(_restaurantMarkers);
//     });

//     print("_markers are");
//     print(_markers);
//     if (_markers.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text('No $type found'),
//           duration: const Duration(seconds: 1)));
//     }
//   }

//   Future<void> getAddressFromCoordinates(LatLng userLocation) async {
//     var url = Uri.parse(
//         'https://maps.googleapis.com/maps/api/geocode/json?latlng=${userLocation.latitude},${userLocation.longitude}&sensor=true&key=AIzaSyCBMs8s8SbqSXLzoygoqc20EvzqBY5wBX0');
//     var _response = await http.get(url);
//     var data = _response.body;
//     Map<String, dynamic> data2 = jsonDecode(data);
//     List<dynamic> list = data2['results'];

//     var result = list[0]['formatted_address']
//         .toString()
//         .replaceAll(', ', '+')
//         .replaceAll(' ', '+');

//     print("Am I here?");
//     print(result);
//     setState(() {
//       address = result;
//     });
//     print(address);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         backgroundColor: CustomColors.dark,
//         leading: IconButton(
//           padding: const EdgeInsets.only(left: 16),
//           icon: const Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//         elevation: 0,
//         actions: [
//           Container(
//               margin: const EdgeInsets.only(right: 24),
//               child: IconButton(
//                   onPressed: () {},
//                   icon: Image.asset('assets/location_info.png')))
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.only(top: 24.0, right: 24, left: 24),
//         child: Column(
//           children: [
//             Expanded(
//               child: Container(
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.white, width: 8),
//                   borderRadius: BorderRadius.circular(16),
//                   color: Colors.white,
//                 ),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(16),
//                   child: FutureBuilder<Position>(
//                     future: GetUserLocation().determinePosition(),
//                     builder: (context, snapshot) {
//                       if (snapshot.hasData) {
//                         Position snapshotData = snapshot.data as Position;
//                         _userLocation = LatLng(
//                             // snapshotData.latitude, snapshotData.longitude);
//                             snapshotData.latitude,
//                             snapshotData.longitude);
//                         if (_markers.isEmpty) {
//                           getAddressFromCoordinates(_userLocation);
//                         }
//                         return GoogleMap(
//                           onMapCreated: _onMapCreated,
//                           initialCameraPosition: CameraPosition(
//                             target: _userLocation,
//                             zoom: 13,
//                           ),
//                           markers: _markers
//                             ..add(Marker(
//                                 markerId: const MarkerId("User Location"),
//                                 infoWindow:
//                                     const InfoWindow(title: "User Location"),
//                                 position: _userLocation)),
//                         );
//                       } else if (snapshot.hasError) {
//                         return Center(
//                             child: Text(snapshot.error.toString(),
//                                 style: const TextStyle(color: Colors.black)));
//                       } else {
//                         return const Center(child: CircularProgressIndicator());
//                       }
//                     },
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 30),
//             SizedBox(
//               height: 70,
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: CircularNeumorphicButton(
//                         color: HexColor('#213c53'),
//                         isNeu: true,
//                         imageName: 'loc_1',
//                         width: 24,
//                         padding: 8,
//                         onTap: () async {
//                           _retrieveNearby(
//                               address, "hospital", BitmapDescriptor.hueAzure);
//                           _markers = {};
//                         }).use(),
//                   ),
//                   Expanded(
//                     child: CircularNeumorphicButton(
//                         color: HexColor('#213c53'),
//                         isNeu: true,
//                         imageName: 'loc_2',
//                         width: 24,
//                         padding: 8,
//                         onTap: () async {
//                           _retrieveNearby(
//                               address, 'school', BitmapDescriptor.hueCyan);
//                           _markers = {};
//                         }).use(),
//                   ),
//                   Expanded(
//                     child: CircularNeumorphicButton(
//                         color: HexColor('#213c53'),
//                         isNeu: true,
//                         imageName: 'loc_3',
//                         width: 24,
//                         padding: 8,
//                         onTap: () async {
//                           _retrieveNearby(address, 'supermarket',
//                               BitmapDescriptor.hueMagenta);
//                           _markers = {};
//                         }).use(),
//                   ),
//                   Expanded(
//                     child: CircularNeumorphicButton(
//                         color: HexColor('#213c53'),
//                         isNeu: true,
//                         imageName: 'loc_4',
//                         width: 24,
//                         padding: 8,
//                         onTap: () async {
//                           _retrieveNearby(
//                               address, 'taxi_stand', BitmapDescriptor.hueRose);
//                           _markers = {};
//                         }).use(),
//                   ),
//                   Expanded(
//                     child: CircularNeumorphicButton(
//                         color: HexColor('#213c53'),
//                         isNeu: true,
//                         imageName: 'loc_5',
//                         width: 24,
//                         padding: 8,
//                         onTap: () async {
//                           _retrieveNearby(
//                               address, 'store', BitmapDescriptor.hueGreen);
//                           _markers = {};
//                         }).use(),
//                   ),
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
