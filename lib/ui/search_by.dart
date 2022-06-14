import 'package:agent_league/components/custom_label.dart';
import 'package:agent_league/components/custom_selector.dart';
import 'package:agent_league/components/custom_text_field.dart';
import 'package:agent_league/helper/shared_preferences.dart';
import 'package:agent_league/provider/firestore_data_provider.dart';
import 'package:agent_league/provider/search_by_provider.dart';
import 'package:agent_league/ui/post_your_property.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../components/custom_button.dart';
import '../components/custom_title.dart';
import '../location_service.dart';
import '../theme/colors.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SeachBy extends StatefulWidget {
  const SeachBy({Key? key}) : super(key: key);

  @override
  State<SeachBy> createState() => _SeachByState();
}

class _SeachByState extends State<SeachBy> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: SafeArea(
          child: Column(children: [
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(left: 25, right: 25),
              child: Row(
                children: [
                  GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.keyboard_backspace_rounded)),
                  const SizedBox(width: 20),
                  const Flexible(child: CustomTitle(text: 'Search By'))
                ],
              ),
            ),
            const SizedBox(height: 15),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4)),
              height: 56,
              child: TabBar(
                unselectedLabelColor: Colors.white.withOpacity(0.54),
                indicatorSize: TabBarIndicatorSize.label,
                labelStyle:
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
                indicator: MaterialIndicator(
                  height: 4,
                  bottomLeftRadius: 5,
                  bottomRightRadius: 5,
                  horizontalPadding: 5,
                  color: HexColor('FE7F0E'),
                ),
                tabs: const [
                  Tab(
                    child: Text(
                      "Price",
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Location",
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                ],
              ),
            ),
            const Expanded(
                child: TabBarView(children: [Price(), SearchLocation()]))
          ]),
        ),
      ),
    );
  }
}

class SearchLocation extends StatefulWidget {
  const SearchLocation({Key? key}) : super(key: key);

  @override
  State<SearchLocation> createState() => _SearchLocationState();
}

class _SearchLocationState extends State<SearchLocation> {
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  Future<String?> getCurrentLocation() async {
    try {
      final location = GetUserLocation();
      final Position position = await location.determinePosition();

      final address = await location.getAddressFromCoordinates(
          LatLng(position.latitude, position.longitude));
      return address;
    } on Exception catch (e) {
      if (e.toString() == 'Location services are disabled.') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Please Turn On Location Service First")));
      } else if (e.toString() == 'Location permissions are denied') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
                "Please Allow Location Permission otherwise you didn't use this feature.")));
      } else if (e.toString() ==
          'Location permissions are permanently denied, we cannot request permissions.') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
                "Sorry You are not allowed to use this feature because you didn't allow permission.")));
      }
      return null;
    }
  }

  Future<String?> getMapLocation() async {
    final String? result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FutureBuilder<Position>(
            future: GetUserLocation().determinePosition(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return PlacePicker(
                  apiKey: 'AIzaSyCBMs8s8SbqSXLzoygoqc20EvzqBY5wBX0',
                  onPlacePicked: (result) {
                    Navigator.of(context).pop(result.formattedAddress);
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

  getAllPlots() {
    FirestoreDataProvider().getPlots().then((value) {
      print(value);
    }).catchError((error) {
      print(error);
    });
  }

  @override
  Widget build(BuildContext context) {
    getAllPlots();
    return ChangeNotifierProvider(
        create: (context) => LocationSearchProvider(),
        builder: (context, child) {
          final _pr =
              Provider.of<LocationSearchProvider>(context, listen: false);
          return ModalProgressHUD(
            inAsyncCall: isLoading,
            child: Form(
              key: _formKey,
              child: Scaffold(
                bottomNavigationBar: Padding(
                  padding: const EdgeInsets.only(bottom: 10.0, right: 25),
                  child:
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    CustomButton(
                      text: 'Reset',
                      onClick: () {
                        _pr.resetData();
                      },
                      color: HexColor('082640'),
                      width: 89,
                      height: 41,
                    ).use(),
                    const SizedBox(width: 20),
                    CustomButton(
                      text: 'Submit',
                      onClick: () {
                        if (_formKey.currentState!.validate()) {}
                      },
                      color: HexColor('FD7E0E'),
                      width: 102,
                      height: 41,
                    ).use(),
                  ]),
                ),
                body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 15),
                      const CustomLabel(text: 'Enter Location'),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: CustomTextField(
                              controller: _pr.locationController,
                              validator: _pr.validateLocation,
                              readOnly: true,
                              onTap: () async {
                                final result = await showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (context) =>
                                        const CustomMapDialog());

                                if (result == 1) {
                                  setState(() => isLoading = true);
                                  final res = await getCurrentLocation();
                                  setState(() => isLoading = false);
                                  if (res != null && res.isNotEmpty) {
                                    print(res);
                                    _pr.locationController.text = res;
                                  }
                                }
                                if (result == 2) {
                                  final res = await getMapLocation();
                                  if (res != null && res.isNotEmpty) {
                                    print(res);
                                    _pr.locationController.text = res;
                                  }
                                }
                              },
                              isDense: true,
                              borderradius: 4,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            flex: 2,
                            child: Row(
                              children: [
                                Consumer<LocationSearchProvider>(
                                  builder: (context, value, child) => Flexible(
                                    child: CustomSelector(
                                            dropDownItems:
                                                value.kmDropDownItems,
                                            onChanged: value.onChangedKm,
                                            isDense: true,
                                            borderRadius: 4,
                                            chosenValue: value.chosenKm)
                                        .use(),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 10, left: 7, right: 7),
                                  decoration: BoxDecoration(
                                      color: HexColor('FE7F0E'),
                                      borderRadius: BorderRadius.circular(4)),
                                  child: const Text('Km'),
                                )
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}

class Price extends StatelessWidget {
  const Price({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 10.0, right: 25),
        child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          CustomButton(
            text: 'Reset',
            onClick: () {},
            color: HexColor('082640'),
            width: 89,
            height: 41,
          ).use(),
          const SizedBox(width: 20),
          CustomButton(
            text: 'Submit',
            onClick: () {},
            color: HexColor('FD7E0E'),
            width: 102,
            height: 41,
          ).use(),
        ]),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15),
            const CustomLabel(text: 'Minimum Price'),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Flexible(
                        child: CustomSelector(
                                dropDownItems: [],
                                onChanged: (value) {},
                                isDense: true,
                                borderRadius: 4,
                                chosenValue: '')
                            .use(),
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 10, left: 7, right: 7),
                        decoration: BoxDecoration(
                            color: HexColor('FE7F0E'),
                            borderRadius: BorderRadius.circular(4)),
                        child: const Text('Cr'),
                      )
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Row(
                    children: [
                      Flexible(
                        child: CustomSelector(
                                dropDownItems: [],
                                onChanged: (value) {},
                                isDense: true,
                                borderRadius: 4,
                                chosenValue: '')
                            .use(),
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 10, left: 7, right: 7),
                        decoration: BoxDecoration(
                            color: HexColor('FE7F0E'),
                            borderRadius: BorderRadius.circular(4)),
                        child: const Text('Lakhs'),
                      )
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 15),
            const CustomLabel(text: 'Maximum Price'),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Flexible(
                        child: CustomSelector(
                                dropDownItems: [],
                                onChanged: (value) {},
                                isDense: true,
                                borderRadius: 4,
                                chosenValue: '')
                            .use(),
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 10, left: 7, right: 7),
                        decoration: BoxDecoration(
                            color: HexColor('FE7F0E'),
                            borderRadius: BorderRadius.circular(4)),
                        child: const Text('Cr'),
                      )
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Row(
                    children: [
                      Flexible(
                        child: CustomSelector(
                                dropDownItems: [],
                                onChanged: (value) {},
                                isDense: true,
                                borderRadius: 4,
                                chosenValue: '')
                            .use(),
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 10, left: 7, right: 7),
                        decoration: BoxDecoration(
                            color: HexColor('FE7F0E'),
                            borderRadius: BorderRadius.circular(4)),
                        child: const Text('Lakhs'),
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
