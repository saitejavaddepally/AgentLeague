import 'package:agent_league/Services/auth_methods.dart';
import 'package:agent_league/components/custom_button.dart';
import 'package:agent_league/components/custom_selector.dart';
import 'package:agent_league/helper/shared_preferences.dart';
import 'package:agent_league/provider/post_your_property_provider_two.dart';
import 'package:agent_league/route_generator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../components/custom_line_under_text.dart';
import '../theme/colors.dart';

class PostYourPropertyPageTwo extends StatefulWidget {
  final Map<String, dynamic> pageOneData;

  const PostYourPropertyPageTwo({required this.pageOneData, Key? key})
      : super(key: key);

  @override
  _PostYourPropertyPageTwoState createState() =>
      _PostYourPropertyPageTwoState();
}

class _PostYourPropertyPageTwoState extends State<PostYourPropertyPageTwo> {
  final _formKey = GlobalKey<FormState>();
  String? currentPlot = '';
  bool isLoading = false;

  Future postPropertyPageTwo(Map<String, dynamic> data) async {
    await SharedPreferencesHelper()
        .getCurrentPlot()
        .then((value) => currentPlot = value);

    AuthMethods().getUserId().then((value) => {
          FirebaseFirestore.instance
              .collection("sell_plots")
              .doc(value)
              .collection("standlone")
              .doc(currentPlot)
              .collection("page_2")
              .add(data)
        });
  }

  @override
  void initState() {
    super.initState();
    print(widget.pageOneData);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PostYourPropertyProviderTwo>(
        create: (context) => PostYourPropertyProviderTwo(),
        builder: (context, child) {
          final _propertyTwo =
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
                      children: [
                        CustomLineUnderText(
                          color: HexColor('FE7F0E'),
                          text: 'Personal  Information',
                          height: 3,
                          width: 135,
                        ).use(),
                        Consumer<PostYourPropertyProviderTwo>(
                          builder: (context, value, child) => Column(
                            children: [
                              CustomWidget(
                                text: 'Facing :',
                                chosenValue: value.facingChosenValue,
                                dropDownItems: value.facingDropDown,
                                onChanged: value.onChangedFacing,
                              ).use(),
                              CustomWidget(
                                text: 'Furnished :',
                                chosenValue: value.furnishedChosenValue,
                                dropDownItems: value.furnishedDropDown,
                                onChanged: value.onChangedFurnished,
                              ).use(),
                              CustomWidget(
                                text: 'No. of floors :',
                                chosenValue: value.floorsChosenValue,
                                dropDownItems: value.floorsDropDown,
                                onChanged: value.onChangedFloors,
                              ).use(),
                              Container(
                                margin: const EdgeInsets.only(top: 16),
                                child: Row(
                                  children: [
                                    const Expanded(child: Text('Size : ')),
                                    Expanded(
                                        flex: 2,
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: TextFormField(
                                                controller:
                                                    value.sizeController,
                                                onChanged:
                                                    value.onSubmittedSize,
                                                validator: value.validateSize,
                                                cursorColor: Colors.white
                                                    .withOpacity(0.1),
                                                decoration: InputDecoration(
                                                  contentPadding:
                                                      const EdgeInsets.all(10),
                                                  hintText: "",
                                                  hintStyle: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 16,
                                                      color: Colors.white
                                                          .withOpacity(0.3)),
                                                  fillColor: Colors.white
                                                      .withOpacity(0.1),
                                                  filled: true,
                                                  border: OutlineInputBorder(
                                                      borderSide:
                                                          BorderSide.none,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Expanded(
                                                child: CustomSelector(
                                              chosenValue:
                                                  value.sizeChosenValue,
                                              dropDownItems: value.sizeDropDown,
                                              onChanged: value.onChangedSize,
                                              borderRadius: 10,
                                              textColor:
                                                  Colors.white.withOpacity(0.8),
                                              hint: const Text('Select'),
                                            ).use())
                                          ],
                                        )),
                                  ],
                                ),
                              ),
                              CustomWidget(
                                text: 'Carpet Area :',
                                isText: true,
                                controller: value.carpetAreaController,
                                submitted: value.onSubmittedCarpetArea,
                                validator: value.validateCarpetArea,
                              ).use(),
                              CustomWidget(
                                text: 'Bed Rooms :',
                                chosenValue: value.bedRoomChosenValue,
                                dropDownItems: value.bedRoomDropDown,
                                onChanged: value.onChangedBedRoom,
                              ).use(),
                              CustomWidget(
                                text: 'Bath Rooms :',
                                chosenValue: value.bathRoomChosenValue,
                                dropDownItems: value.bathRoomDropDown,
                                onChanged: value.onChangedBathRoom,
                              ).use(),
                              CustomWidget(
                                text: 'Car Park :',
                                chosenValue: value.carParkChosenValue,
                                dropDownItems: value.carParkDropDown,
                                onChanged: value.onChangedCarPark,
                              ).use(),
                              CustomWidget(
                                text: 'Extra rooms :',
                                chosenValue: value.extraRoomChosenValue,
                                dropDownItems: value.extraRoomDropDown,
                                onChanged: value.onChangedExtraRoom,
                              ).use(),
                              const SizedBox(
                                height: 30,
                              ),
                              CustomLineUnderText(
                                      text: 'Rental Income (optional)',
                                      height: 3,
                                      color: HexColor('FE7F0E'),
                                      width: 150)
                                  .use(),
                              CustomWidget(
                                text: 'Total Portions :',
                                isText: true,
                                controller: value.totalPortionController,
                                submitted: value.onSubmittedTotalPortion,
                              ).use(),
                              CustomWidget(
                                text: 'Total Income :',
                                isText: true,
                                controller: value.totalIncomeController,
                                submitted: value.onSubmittedTotalIncome,
                              ).use(),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: CustomButton(
                                      text: "Reset",
                                      textColor: HexColor('FE7F0E'),
                                      onClick: () {
                                        _propertyTwo.resetAllData();
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
                                  onClick: () => Navigator.pop(context)).use(),
                            )),
                            Expanded(
                                child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: CustomButton(
                                  text: "Next",
                                  color: HexColor('FD7E0E'),
                                  onClick: () async {
                                    if (_formKey.currentState!.validate()) {
                                      setState(() => isLoading = true);
                                      await postPropertyPageTwo(_propertyTwo
                                          .getMap(widget.pageOneData));
                                      Navigator.pushNamed(
                                          context, RouteName.amenities,
                                          arguments: _propertyTwo
                                              .getMap(widget.pageOneData));
                                    }
                                  }).use(),
                            )),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}

class CustomWidget {
  late String text;
  final void Function(dynamic)? onChanged;
  final dynamic chosenValue;
  final List<dynamic> dropDownItems;
  final String? Function(String?)? validator;
  final void Function(String)? submitted;
  final TextEditingController? controller;
  late bool isText;
  final int flex;

  CustomWidget(
      {required this.text,
      this.onChanged,
      this.chosenValue,
      this.validator,
      this.submitted,
      this.controller,
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
                    cursorColor: Colors.white.withOpacity(0.1),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(10),
                      hintText: "",
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
                        hint: const Text('Select'),
                        onChanged: onChanged,
                        chosenValue: chosenValue,
                        borderRadius: 10,
                        textColor: Colors.white.withOpacity(0.8),
                        dropDownItems: dropDownItems)
                    .use(),
          )
        ],
      ),
    );
  }
}
