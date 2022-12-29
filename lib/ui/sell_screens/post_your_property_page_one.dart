import 'package:agent_league/components/custom_button.dart';
import 'package:agent_league/components/custom_line_under_text.dart';
import 'package:agent_league/components/custom_selector.dart';

import 'package:agent_league/provider/sell_providers/post_your_property_provider_one.dart';
import 'package:agent_league/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import '../../Services/location_service.dart';
import '../../components/custom_label.dart';
import '../../components/custom_text_field.dart';
import '../../theme/colors.dart';

class PostYourPropertyPageOne extends StatefulWidget {
  final Map<String, dynamic>? dataToEdit;
  final bool isFreeListing;

  const PostYourPropertyPageOne(
      {this.dataToEdit, this.isFreeListing = false, Key? key})
      : super(key: key);

  @override
  _PostYourPropertyPageOneState createState() =>
      _PostYourPropertyPageOneState();
}

class _PostYourPropertyPageOneState extends State<PostYourPropertyPageOne> {
  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    // print(widget.isFreeListing);
    // print(widget.dataToEdit);
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
                                                      .onChangedPropertyCategory),
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
                                                      .onChangedPropertyType),
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
                                                      .onChangedPossessionStatus),
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
                                              controller: value.priceController,
                                              validator: value.validatePrice,
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
                                                        await GetUserLocation
                                                            .getCurrentLocation();
                                                    setState(() =>
                                                        isLoading = false);
                                                    if (res != null &&
                                                        res.isNotEmpty) {
                                                      value.locationController
                                                          .text = res[0];
                                                      value.latitude = res[1];
                                                      value.longitude = res[2];
                                                    }
                                                  }
                                                  if (result == 2) {
                                                    final res =
                                                        await GetUserLocation
                                                            .getMapLocation(
                                                                context);
                                                    if (res != null &&
                                                        res.isNotEmpty) {
                                                      value.locationController
                                                          .text = res[0];
                                                      value.latitude = res[1];
                                                      value.longitude = res[2];
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
                                                  onChanged: (value.disableAge)
                                                      ? null
                                                      : value.onChangedAge),
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
                                                  chosenValue:
                                                      value.facingChosenValue,
                                                  onChanged:
                                                      value.onChangedFacing),
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
                                                  )),
                                                  const SizedBox(width: 5),
                                                  Flexible(
                                                    child: CustomSelector(
                                                        isDense: true,
                                                        borderRadius: 10,
                                                        dropDownItems:
                                                            value.sizeDropDown,
                                                        chosenValue: value
                                                            .sizeChosenValue,
                                                        onChanged: value
                                                            .onChangedSize),
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
                                                  if (_formKey.currentState!
                                                      .validate()) {
                                                    if (propertyOne
                                                        .isSkipPageTwo) {
                                                      Navigator.pushNamed(
                                                          context,
                                                          RouteName.amenities,
                                                          arguments: [
                                                            propertyOne
                                                                .getMap(),
                                                            widget.dataToEdit,
                                                            widget.isFreeListing
                                                          ]);
                                                    } else {
                                                      Navigator
                                                          .pushReplacementNamed(
                                                              context,
                                                              RouteName
                                                                  .postYourPropertyPageTwo,
                                                              arguments: [
                                                            propertyOne
                                                                .getMap(),
                                                            widget.dataToEdit,
                                                            widget.isFreeListing
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
  final BuildContext context;
  final void Function(dynamic)? onChanged;
  final String text;
  final List dropDownItems;
  final dynamic selectedValue;
  final String hint;

  CommonWidget({
    required this.onChanged,
    required this.dropDownItems,
    required this.selectedValue,
    required this.text,
    required this.context,
    this.hint = "",
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
                    onChanged: onChanged),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
