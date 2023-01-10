import 'package:agent_league/components/custom_selector.dart';
import 'package:agent_league/provider/property_loan_provider.dart';
import 'package:agent_league/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/custom_button.dart';
import '../components/custom_text_field.dart';

class PropertyLoan extends StatefulWidget {
  const PropertyLoan({Key? key}) : super(key: key);

  @override
  State<PropertyLoan> createState() => _PropertyLoanState();
}

class _PropertyLoanState extends State<PropertyLoan> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => PropertyLoanProvider(),
        builder: (context, child) {
          final pr = Provider.of<PropertyLoanProvider>(context, listen: false);
          return Scaffold(
              bottomNavigationBar: Padding(
                padding: const EdgeInsets.only(bottom: 10.0, right: 20),
                child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  CustomButton(
                    text: 'Reset',
                    onClick: () {
                      pr.resetData();
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
                  child: Consumer<PropertyLoanProvider>(
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
                              label: 'Loan type :',
                              child: CustomSelector(
                                onChanged: value.onChangedLoanType,
                                borderRadius: 10,
                                chosenValue: value.loanTypeChosenValue,
                                dropDownItems: value.loanTypeDropDown,
                              )),
                          const SizedBox(height: 10),
                          CustomRow(
                              label: 'Req. amount :',
                              child: Row(children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: CustomTextField(
                                        isDense: true,
                                        keyboardType: TextInputType.number,
                                        controller: value.crController,
                                        validator: value.validateCr,
                                      )),
                                      const ColorText(text: 'Cr')
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: CustomTextField(
                                        keyboardType: TextInputType.number,
                                        controller: value.lksController,
                                        validator: value.validateLks,
                                        isDense: true,
                                      )),
                                      const ColorText(text: 'Lks')
                                    ],
                                  ),
                                ),
                              ])),
                        ],
                      ),
                    ),
                  ),
                ),
              ));
        });
  }
}

class CustomRow extends StatelessWidget {
  final String label;
  final Widget child;
  const CustomRow({required this.label, required this.child, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                letterSpacing: -0.15,
                color: Colors.white),
          ),
        ),
        Expanded(
          flex: 3,
          child: child,
        ),
      ],
    );
  }
}

class ColorText extends StatelessWidget {
  final String text;
  const ColorText({required this.text, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 10),
      decoration: BoxDecoration(
          color: CustomColors.orange,
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(10), bottomRight: Radius.circular(10))),
      child: Text(text),
    );
  }
}
