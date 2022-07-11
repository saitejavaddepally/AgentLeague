import 'package:agent_league/components/custom_label.dart';
import 'package:agent_league/components/custom_selector.dart';
import 'package:agent_league/components/custom_sell_card.dart';
import 'package:agent_league/components/custom_text_field.dart';
import 'package:agent_league/provider/search_by_provider.dart';
import 'package:agent_league/ui/post_your_property.dart';
import 'package:agent_league/ui/property_digitalization.dart';
import 'package:agent_league/ui/realtor_card.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../components/custom_button.dart';
import '../components/custom_container_text.dart';
import '../components/custom_title.dart';
import '../helper/shared_preferences.dart';
import '../location_service.dart';
import '../theme/colors.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SeachBy extends StatefulWidget {
  List plotPagesInformation;

  SeachBy({Key? key, required this.plotPagesInformation}) : super(key: key);

  @override
  State<SeachBy> createState() => _SeachByState();
}

List plotPageInformation = [];

class _SeachByState extends State<SeachBy> {
  @override
  void initState() {
    plotPageInformation = widget.plotPagesInformation;

    super.initState();
  }

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
            Expanded(
                child: TabBarView(children: [
              Price(),
              SearchLocation(plotPageInformation: plotPageInformation)
            ]))
          ]),
        ),
      ),
    );
  }
}

class SearchLocation extends StatefulWidget {
  final List plotPageInformation;

  const SearchLocation({required this.plotPageInformation, Key? key})
      : super(key: key);

  @override
  State<SearchLocation> createState() => _SearchLocationState();
}

class _SearchLocationState extends State<SearchLocation> {
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  Future<List?> getCurrentLocation() async {
    try {
      final location = GetUserLocation();
      final Position position = await location.determinePosition();

      final address = await location.getAddressFromCoordinates(
          LatLng(position.latitude, position.longitude));
      return [address, position.latitude, position.longitude];
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

  Future<List?> getMapLocation() async {
    final List? result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FutureBuilder<Position>(
            future: GetUserLocation().determinePosition(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return PlacePicker(
                  apiKey: 'AIzaSyCBMs8s8SbqSXLzoygoqc20EvzqBY5wBX0',
                  onPlacePicked: (result) {
                    Navigator.of(context).pop([
                      result.formattedAddress,
                      result.geometry!.location.lat,
                      result.geometry!.location.lng
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

  @override
  Widget build(BuildContext context) {
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
                      onClick: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() => isLoading = true);
                          await _pr.getAllPlots(plotPageInformation,
                              _pr.latitude!, _pr.longitude!, _pr.chosenKm!);
                          setState(() => isLoading = false);
                        }
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
                                  final List? res = await getCurrentLocation();
                                  setState(() => isLoading = false);
                                  if (res != null && res.isNotEmpty) {
                                    print(res);
                                    _pr.locationController.text = res[0];
                                    _pr.latitude = res[1];
                                    _pr.longitude = res[2];
                                  }
                                }
                                if (result == 2) {
                                  final List? res = await getMapLocation();
                                  if (res != null && res.isNotEmpty) {
                                    print(res);
                                    _pr.locationController.text = res[0];
                                    _pr.latitude = res[1];
                                    _pr.longitude = res[2];
                                  }
                                }
                              },
                              isDense: true,
                              borderRadius: 4,
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
                      ),
                      const SizedBox(height: 20),
                      Consumer<LocationSearchProvider>(
                        builder: (context, value, child) => Expanded(
                            child: ListView.builder(
                          itemCount: value.matchedRecords.length,
                          itemBuilder: (context, index) {
                            final item = value.matchedRecords[index][0];
                            final picture =
                                value.matchedRecords[index][2]['picture'];
                            print(picture);
                            return Container(
                              margin: const EdgeInsets.only(bottom: 15),
                              padding: const EdgeInsets.only(
                                  left: 15, top: 15, right: 5, bottom: 15),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.white),
                              child: Row(children: [
                                Container(
                                    height: 135,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    width: MediaQuery.of(context).size.width *
                                        0.30,
                                    child: Image.network(picture,
                                        fit: BoxFit.fill)),
                                Expanded(
                                    child: Container(
                                  margin: const EdgeInsets.only(left: 10),
                                  child: Column(children: [
                                    CustomContainerText1(
                                        text1: 'Category',
                                        text2: '${item['propertyCategory']}'),
                                    const SizedBox(height: 3),
                                    CustomContainerText1(
                                        text1: 'Type',
                                        text2: '${item['propertyType']}'),
                                    const SizedBox(height: 3),
                                    CustomContainerText1(
                                        text1: 'Area',
                                        text2: '${item['size']}'),
                                    const SizedBox(height: 3),
                                    CustomContainerText1(
                                        text1: 'Location',
                                        text2: '${item['location']}'),
                                    const SizedBox(height: 3),
                                    CustomContainerText1(
                                        text1: 'Price',
                                        text2: '${item['price']} INR'),
                                    const SizedBox(height: 3),
                                    CustomContainerText1(
                                        text1: 'Possession',
                                        text2: '${item['possessionStatus']}'),
                                    const SizedBox(height: 3),
                                  ]),
                                ))
                              ]),
                            );
                          },
                        )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}

class Price extends StatefulWidget {
  const Price({Key? key}) : super(key: key);

  @override
  State<Price> createState() => _PriceState();
}

class _PriceState extends State<Price> {
  String? minimumValue;
  String? maximumValue;
  bool isSearched = false;
  late List info = [];
  late List searchResults = [];

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      info = plotPageInformation;
    });
    super.initState();
  }

  filterCards() {
    print(minimumValue);
    print(maximumValue);
    info = plotPageInformation
        .where((element) =>
            int.parse(element[0]['price']) > int.parse(minimumValue!) &&
            int.parse(element[0]['price']) < int.parse(maximumValue!))
        .toList();

    setState(() {
      info;
    });
    // searchResults.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 10.0, right: 25),
        child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          CustomButton(
            text: 'Reset',
            onClick: () {
              print(plotPageInformation);
              setState(() {});
            },
            color: HexColor('082640'),
            width: 89,
            height: 41,
          ).use(),
          const SizedBox(width: 20),
          CustomButton(
            text: 'Submit',
            onClick: () {
              filterCards();
              setState(() {
                isSearched = true;
              });
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
            const CustomLabel(text: 'Minimum Price'),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Flexible(
                        child: CustomSelector(
                                dropDownItems: [
                              '1',
                              '100',
                              '200',
                              '300',
                              '5000000'
                            ],
                                onChanged: (value) {
                                  setState(() {
                                    minimumValue = value;
                                  });
                                },
                                isDense: true,
                                borderRadius: 4,
                                chosenValue: minimumValue)
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
                                dropDownItems: ['100', '200'],
                                onChanged: (value) {},
                                isDense: true,
                                borderRadius: 4,
                                chosenValue: '100')
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
                                dropDownItems: [
                              '100',
                              '200',
                              '300',
                              '5000',
                              '6000000'
                            ],
                                onChanged: (value) {
                                  setState(() {
                                    maximumValue = value.toString();
                                  });
                                },
                                isDense: true,
                                borderRadius: 4,
                                chosenValue: maximumValue)
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
                ),
              ],
            ),
            SizedBox(height: 20),
            (isSearched)
                ? Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 2,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: SingleChildScrollView(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        // height: 200,
                        child: Column(
                          children: [
                            for (var i = 0; i < (info.length); i++)
                              CustomSellCard(
                                imageUrl: info[i][2]['picture'],
                                category: info[i][0]['propertyCategory'],
                                propertyType: info[i][0]['propertyType'],
                                size: info[i][0]['size'],
                                location: info[i][0]['location'],
                                price: info[i][0]['price'],
                                possession: info[i][0]['possessionStatus'],
                                onClick: () {
                                  SharedPreferencesHelper()
                                      .saveCurrentPage(i.toString());
                                  SharedPreferencesHelper().saveNumProperties(
                                      info.length.toString());
                                  SharedPreferencesHelper()
                                      .saveListOfCards(info);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => RealtorCard(
                                              plotPagesInformation: info)));
                                },
                              ),
                          ],
                        ),
                      ),
                    ),
                  )
                : Text("Please enter values"),
          ],
        ),
      ),
    );
  }
}
