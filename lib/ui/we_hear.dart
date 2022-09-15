import 'package:agent_league/Services/auth_methods.dart';
import 'package:agent_league/components/custom_button.dart';
import 'package:agent_league/components/home_container.dart';
import 'package:agent_league/helper/constants.dart';
import 'package:agent_league/route_generator.dart';
import 'package:agent_league/theme/colors.dart';
import 'package:agent_league/ui/profile/edit_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../Services/upload_properties_to_firestore.dart';
import '../components/custom_label.dart';
import '../components/custom_selector.dart';
import '../components/custom_text_field.dart';

class WeHear extends StatefulWidget {
  const WeHear({Key? key}) : super(key: key);

  @override
  State<WeHear> createState() => _WeHearState();
}

class _WeHearState extends State<WeHear> {
  bool loading = false;
  var name = '';
  var phone = '';

  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  Future asyncTriggerFunction() async {
    List data = await getProfileInformation();
    setState(() {
      name = data[0];
      phone = data[1];
    });
  }

  Future getProfileInformation() async {
    Map data = await UploadPropertiesToFirestore().getProfileInformation();
    setState(() {
      nameController.text = data['name'];
      phoneNumberController.text = data['phone'];
    });
    return [data['name'], data['phone']];
  }

  @override
  void initState() {
    setState(() {
      loading = true;
    });
    asyncTriggerFunction();
    setState(() {
      loading = false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                    child: Row(children: [
                  Container(
                    height: 54,
                    width: 54,
                  ),
                  const SizedBox(width: 10),
                ])),
                CustomButton(
                        text: "close_round",
                        onClick: () {
                          Navigator.pop(context);
                        },
                        isIcon: true,
                        height: 40,
                        width: 40,
                        color: HexColor('FD7E0E').withOpacity(0.7),
                        rounded: true)
                    .use(),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const Expanded(child: CustomLabel(text: 'Name :')),
                Flexible(
                    child: CustomTextField(
                  controller: nameController,
                  onChanged: (value) {},
                )),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(children: [
              const Expanded(child: CustomLabel(text: 'Mobile :')),
              Flexible(
                flex: 1,
                child: SizedBox(
                  height: 40,
                  child: TextFormField(
                    controller: phoneNumberController,
                    // maxLength: 10,
                    keyboardType: TextInputType.number,
                    onChanged: (number) {},

                    validator: (number) {
                      if (number == null ||
                          number.isEmpty ||
                          number.length != 10) {
                        return "Enter Correct Mobile Number";
                      }
                      return null;
                    },
                    cursorColor: Colors.white.withOpacity(0.1),
                    decoration: InputDecoration(
                        prefixIcon: const Padding(
                            padding: EdgeInsets.all(10), child: Text('+91 ')),
                        contentPadding: const EdgeInsets.all(10),
                        hintText: "    Your number here",
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Colors.white.withOpacity(0.3)),
                        fillColor: Colors.white.withOpacity(0.1),
                        filled: true,
                        errorBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.red, width: 0.5),
                            borderRadius: BorderRadius.circular(10)),
                        focusedErrorBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.red, width: 0.5),
                            borderRadius: BorderRadius.circular(10)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10))),
                  ),
                ),
              ),
            ]),
            const SizedBox(height: 10),
            Row(
              children: [
                const Expanded(child: CustomLabel(text: 'Category: ')),
                Flexible(
                  child: CustomSelector(
                          isDense: true,
                          borderRadius: 10,
                          dropDownItems: [
                            'cat_1',
                            'cat_2',
                          ],
                          chosenValue: 'cat_1',
                          onChanged: (value) {})
                      .use(),
                ),
              ],
            ),
            const SizedBox(height: 30),
            const Text("Feedback : ",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
            const SizedBox(height: 10),
            TextField(
              cursorColor: Colors.white.withOpacity(0.1),
              minLines: 4,
              maxLines: 4,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(10),
                  fillColor: Colors.white.withOpacity(0.1),
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(12)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(12))),
            ),
            Expanded(
                child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: Row(
                children: [
                  const Expanded(flex: 1, child: SizedBox()),
                  Expanded(
                      flex: 2,
                      child: Padding(
                          padding: const EdgeInsets.all(9),
                          child: CustomButton(
                                  text: 'reset',
                                  color: CustomColors.dark,
                                  onClick: () {})
                              .use())),
                  Expanded(
                      flex: 2,
                      child: Padding(
                          padding: const EdgeInsets.all(9),
                          child: CustomButton(
                                  text: 'submit',
                                  color: HexColor('FD7E0E'),
                                  onClick: () async {})
                              .use())),
                ],
              ),
            ))
          ],
        ),
      )),
    );
  }
}
