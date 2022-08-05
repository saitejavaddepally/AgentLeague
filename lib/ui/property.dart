import 'package:agent_league/components/custom_line_under_text.dart';
import 'package:agent_league/components/custom_text_field.dart';
import 'package:agent_league/components/custom_title.dart';
import 'package:agent_league/provider/property_provider.dart';
import 'package:agent_league/route_generator.dart';
import 'package:agent_league/ui/property_info.dart';
import 'package:agent_league/ui/uploads_screen.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../components/custom_button.dart';
import '../components/custom_map_dialog.dart';
import '../components/custom_selector.dart';
import '../location_service.dart';
import '../theme/colors.dart';

class Property extends StatefulWidget {
  const Property({Key? key}) : super(key: key);

  @override
  State<Property> createState() => _PropertyState();
}

class _PropertyState extends State<Property> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  late double _latitude;
  late double _longitude;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PropertyProvider>(
        create: (context) => PropertyProvider(),
        builder: (context, child) {
          final _propertyProvider =
              Provider.of<PropertyProvider>(context, listen: false);
          return Scaffold(
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.only(bottom: 10.0, right: 25),
              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                CustomButton(
                  text: 'Reset',
                  onClick: () {
                    _propertyProvider.resetAllData();
                  },
                  color: HexColor('082640'),
                  width: 89,
                  height: 40,
                ).use(),
                const SizedBox(width: 20),
                CustomButton(
                  text: 'Next',
                  onClick: () {
                    if (_formKey.currentState!.validate()) {

                      Map<String, dynamic> data = _propertyProvider.getMap();
                      data.addAll({
                        'latitude': _latitude,
                        'longitude': _longitude
                      });
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UploadsScreen(
                                  projectInfo: data)));
                    }
                  },
                  color: HexColor('FD7E0E'),
                  width: 82,
                  height: 40,
                ).use(),
              ]),
            ),
            body: SafeArea(
              child: ModalProgressHUD(
                inAsyncCall: isLoading,
                child: SingleChildScrollView(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 25),
                      child: Form(
                        key: _formKey,
                        child: Column(children: [
                          Row(
                            children: [
                              GestureDetector(
                                  onTap: () => Navigator.pop(context),
                                  child: const Icon(
                                      Icons.keyboard_backspace_rounded)),
                              const SizedBox(width: 20),
                              const Flexible(
                                  child: CustomTitle(text: 'Project Info'))
                            ],
                          ),
                          const SizedBox(height: 20),
                          CustomLineUnderText(
                                  text: 'Basic Info',
                                  color: HexColor('FE7F0E'),
                                  height: 4,
                                  width: 60)
                              .use(),
                          const SizedBox(height: 5),
                          Consumer<PropertyProvider>(
                            builder: (context, value, child) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomWidget(
                                  text: 'Company Name :',
                                  isText: true,
                                  flex: 2,
                                  controller: value.companyNameController,
                                  validator: value.validateCompanyName,
                                  submitted: value.onSubmittedCompanyName,
                                ).use(),
                                CustomWidget(
                                  text: 'Venture Name :',
                                  isText: true,
                                  flex: 2,
                                  controller: value.ventureNameController,
                                  validator: value.validateVentureName,
                                  submitted: value.onSubmittedVentureName,
                                ).use(),
                                CustomWidget(
                                  text: 'Project category :',
                                  flex: 2,
                                  chosenValue: value.projectCategoryChosenValue,
                                  dropDownItems: value.projectCategoryDropDown,
                                  onChanged: value.onChangedProjectCategory,
                                ).use(),
                                CustomWidget(
                                  text: 'Project location :',
                                  isText: true,
                                  flex: 2,
                                  readOnly: true,
                                  onTap: () async {
                                    final result = await showDialog(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (context) =>
                                            const CustomMapDialog());

                                    if (result == 1) {
                                      setState(() => isLoading = true);
                                      final res = await GetUserLocation
                                          .getCurrentLocation();

                                      print(res![0]);
                                      _latitude = (res[1]);
                                      _longitude = (res[2]);

                                      setState(() => isLoading = false);
                                      if (res != null && res.isNotEmpty) {
                                        value.projectLocationController.text =
                                            res[0];
                                      }
                                    }
                                    if (result == 2) {
                                      final res =
                                          await GetUserLocation.getMapLocation(
                                              context);
                                      if (res.isNotEmpty) {
                                        value.projectLocationController.text =
                                            res[0];
                                      }
                                    }
                                  },
                                  controller: value.projectLocationController,
                                  validator: value.validateProjectLocation,
                                ).use(),
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    const Expanded(
                                        child: Text('Total project area :',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16,
                                                letterSpacing: -0.15))),
                                    Expanded(
                                      child: Row(children: [
                                        Expanded(
                                          child: CustomTextField(
                                            validator:
                                                value.validateTotalProjectArea,
                                            onChanged: value
                                                .onSubmittedTotalProjectArea,
                                            controller: value
                                                .totalProjectAreaController,
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        const Text(
                                          'Acres',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                              letterSpacing: -0.15),
                                        )
                                      ]),
                                    ),
                                  ],
                                ),
                                CustomWidget(
                                  text: 'Total units/plots :',
                                  isText: true,
                                  flex: 2,
                                  controller: value.totalUnitsController,
                                  validator: value.validateTotalUnits,
                                  submitted: value.onSubmittedTotalUnits,
                                ).use(),
                                CustomWidget(
                                  text: 'Possession states :',
                                  flex: 2,
                                  chosenValue: value.possessionStateChosenValue,
                                  dropDownItems: value.possessionStateDropDown,
                                  onChanged: value.onChangedPossessionState,
                                ).use(),
                                const SizedBox(height: 15),
                                const Text('Unit/Plot size :',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                        letterSpacing: -0.15)),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Flexible(
                                        flex: 2,
                                        child: CustomTextField(
                                          controller:
                                              value.unitSizeOneController,
                                          onChanged:
                                              value.onSubmittedUnitSizeOne,
                                          validator: value.validateUnitSizeOne,
                                        )),
                                    const SizedBox(width: 10),
                                    const Text('to'),
                                    const SizedBox(width: 10),
                                    Flexible(
                                        flex: 2,
                                        child: CustomTextField(
                                          controller:
                                              value.unitSizeTwoController,
                                          onChanged:
                                              value.onSubmittedUnitSizeTwo,
                                          validator: value.validateUnitSizeTwo,
                                        )),
                                    const SizedBox(width: 5),
                                    Flexible(
                                        flex: 3,
                                        child: CustomSelector(
                                          borderRadius: 10,
                                          hint: const Text('Select'),
                                          dropDownItems: value.unitSizeDropDown,
                                          onChanged: value.onChangedUnitSize,
                                          chosenValue:
                                              value.unitSizeChosenValue,
                                        ).use()),
                                  ],
                                ),
                                const SizedBox(height: 15),
                                const Text('Price per unit :',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                        letterSpacing: -0.15)),
                                const SizedBox(height: 7),
                                Row(
                                  children: [
                                    Flexible(
                                        child: CustomTextField(
                                      controller: value.pricePerUnitController,
                                      onChanged: value.onSubmittedPricePerUnit,
                                      validator: value.validatePricePerUnit,
                                    )),
                                    const SizedBox(width: 15),
                                    const Text('per'),
                                    const SizedBox(width: 15),
                                    Flexible(
                                        child: CustomSelector(
                                      borderRadius: 10,
                                      hint: const Text('Select'),
                                      dropDownItems: value.pricePerUnitDropDown,
                                      chosenValue:
                                          value.pricePerUnitChosenValue,
                                      onChanged: value.onChangedPricePerUnit,
                                    ).use()),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                CustomWidget(
                                  text: 'Approved by :',
                                  flex: 2,
                                  chosenValue: value.approvedByChosenValue,
                                  dropDownItems: value.approvedByDropDown,
                                  onChanged: value.onChangedApprovedBy,
                                ).use(),
                              ],
                            ),
                          )
                        ]),
                      )),
                ),
              ),
            ),
          );
        });
  }
}
