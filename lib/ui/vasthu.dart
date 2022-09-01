import 'package:agent_league/provider/vasthu_provider.dart';
import 'package:agent_league/ui/property_loan.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/custom_button.dart';
import '../components/custom_selector.dart';
import '../components/custom_text_field.dart';
import '../theme/colors.dart';

class VasthuScreen extends StatefulWidget {
  const VasthuScreen({Key? key}) : super(key: key);

  @override
  State<VasthuScreen> createState() => _VasthuScreenState();
}

class _VasthuScreenState extends State<VasthuScreen> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => VasthuProvider(),
        builder: (context, child) {
          final _pr = Provider.of<VasthuProvider>(context, listen: false);
          return Scaffold(
              bottomNavigationBar: Padding(
                padding: const EdgeInsets.only(bottom: 10.0, right: 20),
                child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
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
                      if (_formKey.currentState!.validate()) {}
                    },
                    color: HexColor('FD7E0E'),
                    width: 102,
                    height: 41,
                  ).use(),
                ]),
              ),
              body: SafeArea(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Consumer<VasthuProvider>(
                    builder: (context, value, child) => Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Icon(Icons.keyboard_backspace)),
                          const SizedBox(height: 20),
                          CustomRow(
                              label: 'Name :',
                              child: CustomTextField(
                                  controller: value.nameController,
                                  onChanged: value.onNameSubmitted,
                                  validator: value.validateName,
                                  isDense: true,
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10))),
                          const SizedBox(height: 10),
                          CustomRow(
                            label: 'Mobile :',
                            child: Container(
                              padding: const EdgeInsets.only(left: 10),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.05),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(children: [
                                const Text(
                                  "(+91)",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                                Expanded(
                                  child: CustomTextField(
                                      controller: value.mobileController,
                                      onChanged: value.onMobileSubmitted,
                                      validator: value.validateMobile,
                                      keyboardType: TextInputType.phone,
                                      isDense: true,
                                      fillColor: Colors.white.withOpacity(0.01),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 10)),
                                ),
                              ]),
                            ),
                          ),
                          const SizedBox(height: 10),
                          CustomRow(
                              label: 'Address :',
                              child: CustomSelector(
                                isDense: true,
                                onChanged: value.onChangedAddress,
                                borderRadius: 10,
                                chosenValue: value.addressChosenValue,
                                dropDownItems: value.addressDropDown,
                              ).use()),
                          const SizedBox(height: 10),
                          CustomRow(
                            label: 'Schedule :',
                            child: CustomTextField(
                              controller: value.dateController,
                              validator: value.validateDate,
                              readOnly: true,
                              isDense: true,
                              onTap: () => value.selectDate(context),
                              icon: Icon(Icons.calendar_month_outlined,
                                  color: CustomColors.orange, size: 30),
                            ),
                          ),
                          const SizedBox(height: 10),
                          CustomRow(
                              label: 'Property type :',
                              child: CustomSelector(
                                onChanged: value.onChangedPropertyType,
                                borderRadius: 10,
                                isDense: true,
                                chosenValue: value.propertyTypeChosenValue,
                                dropDownItems: value.propertyTypeDropDown,
                              ).use()),
                        ],
                      ),
                    ),
                  ),
                ),
              ));
        });
  }
}
