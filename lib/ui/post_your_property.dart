import 'package:agent_league/Services/auth_methods.dart';
import 'package:agent_league/Services/upload_properties_to_firestore.dart';
import 'package:agent_league/components/custom_button.dart';
import 'package:agent_league/components/custom_line_under_text.dart';
import 'package:agent_league/components/custom_selector.dart';
import 'package:agent_league/helper/shared_preferences.dart';
import 'package:agent_league/location_service.dart';
import 'package:agent_league/provider/post_your_property_provider_one.dart';
import 'package:agent_league/route_generator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:geolocator/geolocator.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../components/custom_text_field.dart';
import '../places_services.dart';
import '../theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:io' show Platform;

class PostYourPropertyPageOne extends StatefulWidget {
  const PostYourPropertyPageOne({Key? key}) : super(key: key);

  @override
  _PostYourPropertyPageOneState createState() =>
      _PostYourPropertyPageOneState();
}

class _PostYourPropertyPageOneState extends State<PostYourPropertyPageOne> {
  final _menuKey = GlobalKey();
  late double _latitude;
  late double _longitude;
  final _formKey = GlobalKey<FormState>();
  late var currentPlot = '';
  bool isLoading = false;

  Future<String?> getCurrentLocation() async {
    try {
      final location = GetUserLocation();
      final Position position = await location.determinePosition();
      setState(() {
        _latitude = position.latitude;
        _longitude = position.longitude;
      });
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
                setState(() {
                  _latitude = snapshot.data!.latitude;
                  _longitude = snapshot.data!.longitude;
                });
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

  @override
  void initState() {
    getPlotStatus();
    super.initState();
  }

  Future getPlotStatus() async {
    await EasyLoading.show(
      maskType: EasyLoadingMaskType.black,
      status: "Please wait !!"
    );
    await UploadPropertiesToFirestore().getPlotStatus();
    await EasyLoading.dismiss();

  }

  Future postProperty(Map<String, dynamic> data) async {
    AuthMethods().getUserId().then((value) async {
      CollectionReference ref = FirebaseFirestore.instance
          .collection("sell_plots")
          .doc(value)
          .collection("standlone");

      ref.get().then((event) {
        if (event.docs.isEmpty) {
          setState(() {
            currentPlot = 'plot_1';
          });
        } else {
          int length = event.docs.length;
          print(length);
          final List<DocumentSnapshot> documents = event.docs;
          var id = documents[length - 1].id.substring(5);

          int autoId = int.parse(id) + 1;
          setState(() {
            currentPlot = 'plot_$autoId';
          });
        }
        return currentPlot;
      }).then((value) async {
        print("Value is : " + value);
        SharedPreferencesHelper().saveCurrentPlot(value);
        AuthMethods().getUserId().then((value) async {
          CollectionReference ref = FirebaseFirestore.instance
              .collection("sell_plots")
              .doc(value)
              .collection("standlone");
          ref.doc(currentPlot).set({"data": 1});
          await ref.doc(currentPlot).collection("page_1").add(data);
          print("I am Done here");
        }).then((value) {
          print("I am here now!!");
          SharedPreferencesHelper()
              .getCurrentPlot()
              .then((value) => print("value is $value"));
        }).then((value) {
          if (_formKey.currentState!.validate()) {
            Navigator.pushNamed(context, RouteName.postYourPropertyPageTwo,
                arguments: data);
          }
        });
      });
    });
  }

  Future<String> fetchPlot() async {
    AuthMethods().getUserId().then((value) async {
      CollectionReference ref = FirebaseFirestore.instance
          .collection("sell_plots")
          .doc(value)
          .collection("standlone");

      ref.snapshots().listen((event) {
        if (event.docs.isEmpty) {
          setState(() {
            currentPlot = 'plot_1';
          });
        } else {
          int length = event.docs.length;
          print(length);
          final List<DocumentSnapshot> documents = event.docs;
          var id = documents[length - 1].id.substring(5);

          int autoId = int.parse(id) + 1;
          setState(() {
            currentPlot = 'plot_$autoId';
          });
        }
      });
    });
    return currentPlot;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Post Your Property",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          automaticallyImplyLeading: false,
          backgroundColor: CustomColors.dark,
          leading: IconButton(
            padding: const EdgeInsets.only(left: 16),
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          elevation: 0,
        ),
        body: ChangeNotifierProvider<PostYourPropertyProviderOne>(
            create: (context) => PostYourPropertyProviderOne(),
            builder: (context, child) {
              final propertyOne = Provider.of<PostYourPropertyProviderOne>(
                  context,
                  listen: false);
              return ModalProgressHUD(
                inAsyncCall: isLoading,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          CustomLineUnderText(
                                  text: 'Basic Info', height: 3, width: 60)
                              .use(),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
                            child: Column(
                              children: [
                                Consumer<PostYourPropertyProviderOne>(
                                  builder: (context, value, child) => Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CommonWidget(
                                                text: "Property category*",
                                                dropDownItems: value
                                                    .propertyCategoryDropDown,
                                                onChanged: value
                                                    .onChangedPropertyCategory,
                                                selectedValue: value
                                                    .propertyCategoryChosenValue,
                                                hint: const Text('Select'))
                                            .use(),
                                        CommonWidget(
                                                text: "Property type*",
                                                hint: const Text('Select'),
                                                dropDownItems:
                                                    value.propertyTypeDropDown,
                                                selectedValue: value
                                                    .propertyTypeChosenValue,
                                                onChanged:
                                                    value.onChangedPropertyType)
                                            .use(),
                                        CommonWidget(
                                                text: "Possession Status*",
                                                hint: const Text('Select'),
                                                dropDownItems: value
                                                    .possessionStatusDropDown,
                                                selectedValue: value
                                                    .possessionStatusChosenValue,
                                                onChanged: value
                                                    .onChangedPossessionStatus)
                                            .use(),
                                        const SizedBox(height: 10),
                                        const Text('  Price*'),
                                        const SizedBox(height: 15),
                                        TextFormField(
                                          controller: value.controller,
                                          cursorColor:
                                              Colors.white.withOpacity(0.1),
                                          keyboardType: TextInputType.number,
                                          onChanged: value.onPriceSubmitted,
                                          validator: value.validatePrice,
                                          decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.all(10),
                                            hintText: "    Enter price",
                                            hintStyle: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,
                                                color: Colors.white
                                                    .withOpacity(0.7)),
                                            fillColor:
                                                Colors.white.withOpacity(0.1),
                                            filled: true,
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide.none,
                                                borderRadius:
                                                    BorderRadius.circular(31)),
                                          ),
                                        ),
                                        const SizedBox(height: 25),
                                        const Text('Location*'),
                                        const SizedBox(height: 15),
                                        CustomTextField(
                                          controller: value.locationController,
                                          readOnly: true,
                                          borderradius: 31,
                                          validator: value.validateLocation,
                                          onTap: () async {
                                            final result = await showDialog(
                                                barrierDismissible: false,
                                                context: context,
                                                builder: (context) =>
                                                    const CustomDialog());

                                            if (result == 1) {
                                              setState(() => isLoading = true);
                                              final res =
                                                  await getCurrentLocation();
                                              setState(() => isLoading = false);
                                              if (res != null &&
                                                  res.isNotEmpty) {
                                                value.locationController.text =
                                                    res;
                                              }
                                            }
                                            if (result == 2) {
                                              final res =
                                                  await getMapLocation();
                                              if (res != null &&
                                                  res.isNotEmpty) {
                                                value.locationController.text =
                                                    res;
                                              }
                                            }
                                          },
                                        ),
                                        const SizedBox(height: 15),
                                        CommonWidget(
                                                text: "Age*",
                                                hint: const Text('Select'),
                                                dropDownItems:
                                                    value.ageDropDown,
                                                selectedValue:
                                                    value.ageChosenValue,
                                                onChanged: value.onChangedAge)
                                            .use(),
                                        const SizedBox(height: 10),
                                      ]),
                                ),
                                const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text('*Note: All are Required')),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                        child: Padding(
                                            padding: const EdgeInsets.all(9),
                                            child: CustomButton(
                                                text: 'reset',
                                                color: CustomColors.dark,
                                                onClick: () {
                                                  propertyOne.resetAllData();
                                                }).use())),
                                    Expanded(
                                        child: Padding(
                                            padding: const EdgeInsets.all(9),
                                            child: CustomButton(
                                                text: 'next',
                                                color: HexColor('FD7E0E'),
                                                onClick: () async {
                                                  // setState(
                                                  //     () => isLoading = true);
                                                  // await postProperty(
                                                  //     propertyOne.getMap());

                                                  if (_formKey.currentState!
                                                      .validate()) {
                                                    await SharedPreferencesHelper()
                                                        .savePageOneInformation(
                                                            propertyOne
                                                                .getMap());
                                                    Map<String, dynamic> data =
                                                        propertyOne.getMap();
                                                    data.addAll({
                                                      "latitude": _latitude,
                                                      "longitude": _longitude
                                                    });
                                                    Navigator.pushNamed(
                                                        context,
                                                        RouteName
                                                            .postYourPropertyPageTwo,
                                                        arguments: data);
                                                  }
                                                }).use())),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }));
  }
}

class CustomDialog extends StatelessWidget {
  const CustomDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: CustomColors.dark,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: SizedBox(
        height: 140,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              ListTile(
                  title: const Text("Enter Current Location"),
                  onTap: () => Navigator.pop(context, 1)),
              ListTile(
                  title: const Text("Choose Current Location From Map"),
                  onTap: () => Navigator.pop(context, 2))
            ],
          ),
        ),
      ),
    );
  }
}

class CommonWidget {
  final void Function(dynamic)? onChanged;
  final String text;
  final List dropDownItems;
  final dynamic selectedValue;
  late Widget? hint;

  CommonWidget({
    required this.onChanged,
    required this.dropDownItems,
    required this.selectedValue,
    required this.text,
    this.hint,
  });

  use() {
    return SizedBox(
      height: 120,
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(text),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: CustomSelector(
                        textColor: Colors.white.withOpacity(0.7),
                        dropDownItems: dropDownItems,
                        chosenValue: selectedValue,
                        hint: hint,
                        onChanged: onChanged)
                    .use(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
