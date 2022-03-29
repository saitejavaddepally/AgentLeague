import 'package:agent_league/components/neu_circular_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


import '../theme/colors.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  String googleApikey = "AIzaSyAA0QCGGA4oiunUGkKTZHgQRIStRhKMfZc";

  final String restaurantSearch = 'Restaurants near me';
  String location = 'Hospitals near me';

  // final String hospitalSearch = 'Hospitals near me';
  // final String hospitalSearch = 'Hospitals near me';
  // final String hospitalSearch = 'Hospitals near me';

  late GoogleMapController mapController;

  final LatLng _center = const LatLng(17.3744, 78.4999);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
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
                  child: GoogleMap(
                    onMapCreated: _onMapCreated,
                    zoomControlsEnabled: false,
                    initialCameraPosition: CameraPosition(
                      target: _center,
                      zoom: 22.0,
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 40),
                height: 100,
                child: Row(
                  children: [
                    for (var i = 1; i <= 5; i++)
                      Expanded(
                        child: CircularNeumorphicButton(
                                color: HexColor('#213c53'),
                                isNeu: true,
                                imageName: 'loc_$i',
                                width: 24,
                                padding: 8,
                                onTap: () {})
                            .use(),
                      )
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
