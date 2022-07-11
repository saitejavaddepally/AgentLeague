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
import '../components/custom_label.dart';
import '../components/custom_text_field.dart';
import '../theme/colors.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PostYourPropertyPageOne extends StatefulWidget {
  final Map<String, dynamic>? dataToEdit;

  const PostYourPropertyPageOne({this.dataToEdit, Key? key}) : super(key: key);

  @override
  _PostYourPropertyPageOneState createState() =>
      _PostYourPropertyPageOneState();
}

class _PostYourPropertyPageOneState extends State<PostYourPropertyPageOne> {
  late double _latitude;
  late double _longitude;
  final _formKey = GlobalKey<FormState>();
  late var currentPlot = '';
  bool isLoading = false;

  Future<String?> getCurrentLocation() async {
    try {
      final location = GetUserLocation();
      final Position position = await location.determinePosition();

      _latitude = position.latitude;
      _longitude = position.longitude;

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
                    _latitude = result.geometry!.location.lat;
                    _longitude = result.geometry!.location.lng;
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
    _latitude = widget.dataToEdit?['latitude'] ?? 0;
    _longitude = widget.dataToEdit?['longitude'] ?? 0;
    // print("Plot to be edited is ? ${widget.dataToEdit!['plotNo']}");
    (widget.dataToEdit == null)
        ? getPlotStatus()
        : SharedPreferencesHelper()
            .saveCurrentPlot("plot_${widget.dataToEdit!['plotNo']}");

    super.initState();
  }

  Future getPlotStatus() async {
    await EasyLoading.show(
        maskType: EasyLoadingMaskType.black, status: "Please wait !!");
    await UploadPropertiesToFirestore().getPlotStatus();
    await EasyLoading.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    print("data to edit");
    print(widget.dataToEdit);
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
            create: (context) => PostYourPropertyProviderOne(widget.dataToEdit),
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
                                        Row(
                                          children: [
                                            const Expanded(
                                                child: CustomLabel(
                                                    text:
                                                        'Property Category :')),
                                            Flexible(
                                              child: CustomSelector(
                                                      isDense: true,
                                                      borderRadius: 10,
                                                      dropDownItems: value
                                                          .propertyCategoryDropDown,
                                                      chosenValue: value
                                                          .propertyCategoryChosenValue,
                                                      onChanged: value
                                                          .onChangedPropertyCategory)
                                                  .use(),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          children: [
                                            const Expanded(
                                                child: CustomLabel(
                                                    text: 'Property Type :')),
                                            Flexible(
                                              child: CustomSelector(
                                                      isDense: true,
                                                      borderRadius: 10,
                                                      dropDownItems: value
                                                          .propertyTypeDropDown,
                                                      chosenValue: value
                                                          .propertyTypeChosenValue,
                                                      onChanged: value
                                                          .onChangedPropertyType)
                                                  .use(),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          children: [
                                            const Expanded(
                                                child: CustomLabel(
                                                    text:
                                                        'Possession Status :')),
                                            Flexible(
                                              child: CustomSelector(
                                                      isDense: true,
                                                      borderRadius: 10,
                                                      dropDownItems: value
                                                          .possessionStatusDropDown,
                                                      chosenValue: value
                                                          .possessionStatusChosenValue,
                                                      onChanged: value
                                                          .onChangedPossessionStatus)
                                                  .use(),
                                            ),
                                          ],
                                        ),
                                        Visibility(
                                          visible: value.isVisible,
                                          child: Column(children: [
                                            const SizedBox(height: 10),
                                            Row(children: [
                                              const Expanded(
                                                child: CustomLabel(
                                                    text: 'Hand Over :'),
                                              ),
                                              Expanded(
                                                child: Row(
                                                  children: [
                                                    Flexible(
                                                        child: CustomTextField(
                                                            maxLength: 4,
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            controller: value
                                                                .handOverYearController,
                                                            validator: value
                                                                .validateHandOverYear,
                                                            onChanged: value
                                                                .onSubmittedHandOverYear,
                                                            isDense: true,
                                                            hint: 'year')),
                                                    const SizedBox(width: 5),
                                                    Flexible(
                                                      child: CustomTextField(
                                                          maxLength: 2,
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          controller: value
                                                              .handOverMonthController,
                                                          validator: value
                                                              .validateHandOverMonth,
                                                          onChanged: value
                                                              .onSubmittedHandOverMonth,
                                                          isDense: true,
                                                          hint: 'month'),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ]),
                                          ]),
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          children: [
                                            const Expanded(
                                                child: CustomLabel(
                                                    text: 'Price :')),
                                            Expanded(
                                                child: CustomTextField(
                                              isDense: true,
                                              controller: value.controller,
                                              validator: value.validatePrice,
                                              onChanged: value.onPriceSubmitted,
                                              keyboardType:
                                                  TextInputType.number,
                                            )),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          children: [
                                            const Expanded(
                                                child: CustomLabel(
                                                    text: 'Location :')),
                                            Expanded(
                                              child: CustomTextField(
                                                isDense: true,
                                                controller:
                                                    value.locationController,
                                                readOnly: true,
                                                borderRadius: 10,
                                                validator:
                                                    value.validateLocation,
                                                onTap: () async {
                                                  final result = await showDialog(
                                                      barrierDismissible: false,
                                                      context: context,
                                                      builder: (context) =>
                                                          const CustomMapDialog());

                                                  if (result == 1) {
                                                    setState(
                                                        () => isLoading = true);
                                                    final res =
                                                        await getCurrentLocation();
                                                    setState(() =>
                                                        isLoading = false);
                                                    if (res != null &&
                                                        res.isNotEmpty) {
                                                      value.locationController
                                                          .text = res;
                                                    }
                                                  }
                                                  if (result == 2) {
                                                    final res =
                                                        await getMapLocation();
                                                    if (res != null &&
                                                        res.isNotEmpty) {
                                                      value.locationController
                                                          .text = res;
                                                    }
                                                  }
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          children: [
                                            const Expanded(
                                                child:
                                                    CustomLabel(text: 'Age :')),
                                            Flexible(
                                              child: CustomSelector(
                                                      isDense: true,
                                                      borderRadius: 10,
                                                      dropDownItems:
                                                          value.ageDropDown,
                                                      chosenValue:
                                                          value.ageChosenValue,
                                                      onChanged: (value
                                                              .disableAge)
                                                          ? null
                                                          : value.onChangedAge)
                                                  .use(),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          children: [
                                            const Expanded(
                                                child: CustomLabel(
                                                    text: 'Facing :')),
                                            Flexible(
                                              child: CustomSelector(
                                                      isDense: true,
                                                      borderRadius: 10,
                                                      dropDownItems:
                                                          value.facingDropDown,
                                                      chosenValue: value
                                                          .facingChosenValue,
                                                      onChanged:
                                                          value.onChangedFacing)
                                                  .use(),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          children: [
                                            const Expanded(
                                                child: CustomLabel(
                                                    text: 'Size :')),
                                            Expanded(
                                              child: Row(
                                                children: [
                                                  Flexible(
                                                      child: CustomTextField(
                                                    isDense: true,
                                                    controller:
                                                        value.sizeController,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    validator:
                                                        value.validateSize,
                                                    onChanged:
                                                        value.onSubmittedSize,
                                                  )),
                                                  const SizedBox(width: 5),
                                                  Flexible(
                                                    child: CustomSelector(
                                                            isDense: true,
                                                            borderRadius: 10,
                                                            dropDownItems: value
                                                                .sizeDropDown,
                                                            chosenValue: value
                                                                .sizeChosenValue,
                                                            onChanged: value
                                                                .onChangedSize)
                                                        .use(),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ]),
                                ),
                                const SizedBox(height: 25),
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
                                                    if (propertyOne
                                                        .isSkipPageTwo) {
                                                      Map<String, dynamic>
                                                          data =
                                                          propertyOne.getMap();
                                                      data.addAll({
                                                        "latitude": _latitude,
                                                        "longitude": _longitude
                                                      });

                                                      print("data is $data");
                                                      print(
                                                          "widget data is  ${widget.dataToEdit}");
                                                      Navigator.pushNamed(
                                                          context,
                                                          RouteName.amenities,
                                                          arguments: [
                                                            data,
                                                            widget.dataToEdit
                                                          ]);
                                                    } else {
                                                      await SharedPreferencesHelper()
                                                          .savePageOneInformation(
                                                              propertyOne
                                                                  .getMap());
                                                      Map<String, dynamic>
                                                          data =
                                                          propertyOne.getMap();
                                                      data.addAll({
                                                        "latitude": _latitude,
                                                        "longitude": _longitude
                                                      });
                                                      Navigator
                                                          .pushReplacementNamed(
                                                              context,
                                                              RouteName
                                                                  .postYourPropertyPageTwo,
                                                              arguments: [
                                                            data,
                                                            widget.dataToEdit
                                                          ]);
                                                    }
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

class CustomMapDialog extends StatelessWidget {
  const CustomMapDialog({Key? key}) : super(key: key);

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
