import 'package:agent_league/components/custom_button.dart';
import 'package:agent_league/components/custom_selector.dart';
import 'package:agent_league/provider/sell_providers/post_your_property_provider_two.dart';
import 'package:agent_league/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../../components/custom_label.dart';
import '../../components/custom_line_under_text.dart';
import '../../components/custom_text_field.dart';
import '../../components/custom_title.dart';
import '../../helper/constants.dart';
import '../../provider/sell_providers/amenities_provider.dart';
import '../../theme/colors.dart';

class PostYourPropertyPageTwo extends StatefulWidget {
  final Map<String, dynamic> previousPageData;
  final Map<String, dynamic>? dataToEdit;
  final bool isFreeListing;

  const PostYourPropertyPageTwo(
      {required this.previousPageData,
      required this.isFreeListing,
      this.dataToEdit,
      Key? key})
      : super(key: key);

  @override
  _PostYourPropertyPageTwoState createState() =>
      _PostYourPropertyPageTwoState();
}

class _PostYourPropertyPageTwoState extends State<PostYourPropertyPageTwo> {
  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (context) =>
                  PostYourPropertyProviderTwo(widget.dataToEdit)),
          ChangeNotifierProvider(create: (context) => AmenitiesProvider()),
        ],
        builder: (context, child) {
          final propertyTwo =
              Provider.of<PostYourPropertyProviderTwo>(context, listen: false);
          return ModalProgressHUD(
              inAsyncCall: isLoading,
              child: Scaffold(
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
                  body: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Form(
                        key: _formKey,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomLineUnderText(
                                color: HexColor('FE7F0E'),
                                text: 'Property Information',
                                height: 3,
                                width: 135,
                              ).use(),
                              const SizedBox(height: 20),
                              Consumer<PostYourPropertyProviderTwo>(
                                builder: (context, value, child) => Column(
                                  children: [
                                    Row(
                                      children: [
                                        const Expanded(
                                            child: CustomLabel(
                                                text: 'Furnished :')),
                                        Flexible(
                                          child: CustomSelector(
                                              isDense: true,
                                              borderRadius: 10,
                                              dropDownItems:
                                                  value.furnishedDropDown,
                                              chosenValue:
                                                  value.furnishedChosenValue,
                                              onChanged:
                                                  value.onChangedFurnished),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        const Expanded(
                                            child: CustomLabel(
                                                text: 'No. of floors :')),
                                        Flexible(
                                          child: CustomSelector(
                                            isDense: true,
                                            borderRadius: 10,
                                            dropDownItems: value.floorsDropDown,
                                            chosenValue:
                                                value.floorsChosenValue,
                                            onChanged: value.onChangedFloors,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        const Expanded(
                                            child: CustomLabel(
                                                text: 'Bed Rooms :')),
                                        Flexible(
                                          child: CustomSelector(
                                            isDense: true,
                                            borderRadius: 10,
                                            dropDownItems:
                                                value.bedRoomDropDown,
                                            chosenValue:
                                                value.bedRoomChosenValue,
                                            onChanged: value.onChangedBedRoom,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        const Expanded(
                                            child: CustomLabel(
                                                text: 'Bath Rooms :')),
                                        Flexible(
                                          child: CustomSelector(
                                            isDense: true,
                                            borderRadius: 10,
                                            chosenValue:
                                                value.bathRoomChosenValue,
                                            dropDownItems:
                                                value.bathRoomDropDown,
                                            onChanged: value.onChangedBathRoom,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        const Expanded(
                                            child: CustomLabel(
                                                text: 'Car Park :')),
                                        Flexible(
                                          child: CustomSelector(
                                            isDense: true,
                                            borderRadius: 10,
                                            chosenValue:
                                                value.carParkChosenValue,
                                            dropDownItems:
                                                value.carParkDropDown,
                                            onChanged: value.onChangedCarPark,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        const Expanded(
                                            child: CustomLabel(
                                                text: 'Extra rooms :')),
                                        Flexible(
                                          child: CustomSelector(
                                            isDense: true,
                                            borderRadius: 10,
                                            chosenValue:
                                                value.extraRoomChosenValue,
                                            dropDownItems:
                                                value.extraRoomDropDown,
                                            onChanged: value.onChangedExtraRoom,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 30),
                                    Divider(
                                        color: HexColor('FE7F0E'),
                                        thickness: 2),
                                    const SizedBox(height: 10),
                                    Consumer<PostYourPropertyProviderTwo>(
                                      builder: (context, value, child) =>
                                          Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Flexible(
                                                child: CustomLabel(
                                                    text:
                                                        'Does property has rental income :'),
                                              ),
                                              Row(
                                                children: [
                                                  TextButton(
                                                      onPressed: () {
                                                        value
                                                            .onYesClickRentalIncome(
                                                                context);
                                                      },
                                                      style:
                                                          TextButton.styleFrom(
                                                        backgroundColor: (value
                                                                .rentalIncome)
                                                            ? HexColor('FE7F0E')
                                                            : Colors.white
                                                                .withOpacity(
                                                                    0.1),
                                                        minimumSize:
                                                            const Size(41, 30),
                                                      ),
                                                      child: Text('Yes',
                                                          style: TextStyle(
                                                            color: (value
                                                                    .rentalIncome)
                                                                ? HexColor(
                                                                    '131415')
                                                                : Colors.white
                                                                    .withOpacity(
                                                                        0.8),
                                                          ))),
                                                  TextButton(
                                                      onPressed: value
                                                          .onNoClickRentalIncome,
                                                      style:
                                                          TextButton.styleFrom(
                                                        backgroundColor: (value
                                                                .rentalIncome)
                                                            ? Colors.white
                                                                .withOpacity(
                                                                    0.1)
                                                            : HexColor(
                                                                'FE7F0E'),
                                                        minimumSize:
                                                            const Size(37, 30),
                                                      ),
                                                      child: Text('No',
                                                          style: TextStyle(
                                                            color: (value
                                                                    .rentalIncome)
                                                                ? Colors.white
                                                                    .withOpacity(
                                                                        0.8)
                                                                : HexColor(
                                                                    '131415'),
                                                          ))),
                                                ],
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 10),
                                          Divider(
                                              color: HexColor('FE7F0E'),
                                              thickness: 2),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                  ],
                                ),
                              ),
                              const CustomTitle(text: 'Amenities :'),
                              const SizedBox(height: 20),
                              Consumer<AmenitiesProvider>(
                                builder: (context, value, child) => Column(
                                  children: [
                                    Row(
                                      children: [
                                        IconTextButton(
                                            image: 'assets/gyms.png',
                                            text: 'Gyms',
                                            onTap: () => value.toggleGyms(),
                                            isSelected: value.gyms),
                                        const SizedBox(width: 25),
                                        IconTextButton(
                                          image: 'assets/automation.png',
                                          text: 'Home Automation',
                                          onTap: () => value.toggleAutomation(),
                                          isSelected: value.automation,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 25),
                                    Row(
                                      children: [
                                        IconTextButton(
                                          image: 'assets/elevator.png',
                                          text: 'Elevator',
                                          onTap: () => value.toggleElevator(),
                                          isSelected: value.elevator,
                                        ),
                                        const SizedBox(width: 25),
                                        IconTextButton(
                                          image: 'assets/pipe.png',
                                          text: 'Piped Gas',
                                          onTap: () => value.togglePipedGas(),
                                          isSelected: value.pipedGas,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 25),
                                    Row(
                                      children: [
                                        IconTextButton(
                                          image: 'assets/balcony.png',
                                          text: 'Balcony',
                                          onTap: () => value.toggleBalcony(),
                                          isSelected: value.balcony,
                                        ),
                                        const SizedBox(width: 25),
                                        IconTextButton(
                                          image: 'assets/bore_water.png',
                                          text: 'Bore Water',
                                          onTap: () => value.toggleBoreWater(),
                                          isSelected: value.boreWater,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 25),
                                    Row(
                                      children: [
                                        IconTextButton(
                                          image: 'assets/servant.png',
                                          text: 'Servent',
                                          onTap: () => value.toggleServant(),
                                          isSelected: value.servant,
                                        ),
                                        const SizedBox(width: 25),
                                        IconTextButton(
                                            image: 'assets/backup.png',
                                            text: 'Backup Power',
                                            onTap: () => value.toggleBackup(),
                                            isSelected: value.backup),
                                      ],
                                    ),
                                    const SizedBox(height: 25),
                                    Row(
                                      children: [
                                        IconTextButton(
                                          image: 'assets/gated.png',
                                          text: 'Gated',
                                          onTap: () => value.toggleGated(),
                                          isSelected: value.gated,
                                        ),
                                        const SizedBox(width: 25),
                                        IconTextButton(
                                          image: 'assets/municipal_water.png',
                                          text: 'Municipal Water',
                                          onTap: () =>
                                              value.toggleMunicipalWater(),
                                          isSelected: value.municipalWater,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 40),
                              Row(
                                children: [
                                  Expanded(
                                      child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: CustomButton(
                                            text: "Reset",
                                            textColor: HexColor('FE7F0E'),
                                            onClick: () {
                                              propertyTwo.resetAllData();
                                            },
                                            isNeu: false,
                                            textAlignRight: true,
                                            color: CustomColors.dark)
                                        .use(),
                                  )),
                                  Expanded(
                                      child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: CustomButton(
                                        text: "Back",
                                        color: CustomColors.dark,
                                        onClick: () =>
                                            Navigator.pop(context)).use(),
                                  )),
                                  Expanded(
                                      child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: CustomButton(
                                        text: "Next",
                                        color: HexColor('FD7E0E'),
                                        onClick: () async {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            Navigator.pushNamed(
                                                context, RouteName.amenities,
                                                arguments: [
                                                  propertyTwo.getMap(
                                                      widget.previousPageData),
                                                  widget.dataToEdit,
                                                  widget.isFreeListing
                                                ]);
                                          }
                                        }).use(),
                                  )),
                                ],
                              ),
                            ]),
                      ),
                    ),
                  )));
        });
  }
}

class CustomWidget {
  final BuildContext context;
  late String text;
  final void Function(dynamic)? onChanged;
  final dynamic chosenValue;
  final List<dynamic> dropDownItems;
  final String? Function(String?)? validator;
  final void Function(String)? submitted;
  final TextEditingController? controller;
  late bool isText;
  final void Function()? onTap;
  final bool readOnly;
  final int flex;

  CustomWidget(
      {required this.text,
      required this.context,
      this.onChanged,
      this.chosenValue,
      this.validator,
      this.submitted,
      this.controller,
      this.onTap,
      this.readOnly = false,
      this.dropDownItems = const [],
      this.isText = false,
      this.flex = 1});

  use() {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      child: Row(
        children: [
          Expanded(
            flex: flex,
            child: Text(text,
                style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    letterSpacing: -0.15)),
          ),
          Expanded(
            flex: 2,
            child: (isText)
                ? TextFormField(
                    validator: validator,
                    onChanged: submitted,
                    controller: controller,
                    readOnly: readOnly,
                    onTap: onTap,
                    cursorColor: Colors.white.withOpacity(0.1),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(10),
                      hintText: "",
                      isDense: true,
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Colors.white.withOpacity(0.3)),
                      fillColor: Colors.white.withOpacity(0.1),
                      filled: true,
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  )
                : CustomSelector(
                    hint: 'Select',
                    onChanged: onChanged,
                    chosenValue: chosenValue,
                    isDense: true,
                    borderRadius: 10,
                    textColor: Colors.white.withOpacity(0.8),
                    dropDownItems: dropDownItems),
          )
        ],
      ),
    );
  }
}

class CustomDialog extends StatelessWidget {
  CustomDialog({Key? key}) : super(key: key);

  String? _totalPortion;
  String? _totalIncome;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: CustomColors.dark,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: SizedBox(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  const Expanded(child: Text('Total Portion :')),
                  Expanded(
                      child: CustomTextField(
                    isDense: true,
                    onChanged: (value) {
                      _totalPortion = value;
                    },
                  )),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Expanded(child: Text("Totak Income :")),
                  Expanded(
                      child: CustomTextField(
                    isDense: true,
                    onChanged: (value) {
                      _totalIncome = value;
                    },
                  )),
                ],
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () {
                        if (_totalPortion != null &&
                            _totalPortion!.trim().isNotEmpty &&
                            _totalIncome != null &&
                            _totalIncome!.trim().isNotEmpty) {
                          Navigator.pop(context,
                              [_totalPortion!.trim(), _totalIncome!.trim()]);
                        }
                      },
                      style: TextButton.styleFrom(
                          backgroundColor: HexColor('FE7F0E')),
                      child: const Text('Submit',
                          style: TextStyle(color: Colors.black))),
                  const SizedBox(width: 20),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.white.withOpacity(0.1)),
                      child: Text('Cancel',
                          style:
                              TextStyle(color: Colors.white.withOpacity(0.8)))),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class IconTextButton extends StatelessWidget {
  final String image;
  final String text;
  final bool isSelected;
  final void Function() onTap;

  const IconTextButton(
      {required this.image,
      required this.text,
      required this.onTap,
      this.isSelected = false,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 16),
        decoration: BoxDecoration(
            boxShadow: shadow1,
            borderRadius: BorderRadius.circular(30),
            gradient: (isSelected)
                ? LinearGradient(
                    colors: [HexColor('FD7E0E'), HexColor('C12103')],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter)
                : null,
            color: HexColor('082640')),
        child: Row(children: [
          Image.asset(image),
          const SizedBox(width: 10),
          Text(text,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14))
        ]),
      ),
    );
  }
}
