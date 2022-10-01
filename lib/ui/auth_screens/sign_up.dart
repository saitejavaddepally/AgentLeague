// ignore_for_file: avoid_print

import 'package:agent_league/components/custom_button.dart';
import 'package:agent_league/components/custom_text_field.dart';
import 'package:agent_league/ui/Home/bottom_navigation.dart';
import 'package:agent_league/ui/sell_screens/post_your_property_page_one.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../location_service.dart';
import '../../provider/firestore_data_provider.dart';
import '../../route_generator.dart';
import '../../theme/colors.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();

  String name = '';
  String referralCode = '';
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _referralCodeController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset("assets/logo_onboarding.png",
                            width: 80, height: 70),
                        CustomButton(
                                text: "help_icon",
                                onClick: () {
                                  Navigator.pushNamed(context, '/help');
                                },
                                width: 48,
                                height: 48,
                                isIcon: true,
                                rounded: true,
                                color: Colors.red.withOpacity(0.9))
                            .use(),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text("Register",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        CustomTextField(
                          controller: _nameController,
                          borderRadius: 30,
                          hint: "Enter your name",
                          onChanged: (value) {
                            name = value;
                          },
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Name not be empty";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        CustomTextField(
                          controller: _locationController,
                          readOnly: true,
                          onTap: () async {
                            final result = await showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) => const CustomMapDialog());

                            if (result == 1) {
                              setState(() => isLoading = true);
                              final res =
                                  await GetUserLocation.getCurrentLocation();
                              setState(() => isLoading = false);
                              if (res != null && res.isNotEmpty) {
                                _locationController.text = res[0];
                              }
                            }
                            if (result == 2) {
                              final res =
                                  await GetUserLocation.getMapLocation(context);
                              if (res.isNotEmpty) {
                                _locationController.text = res[0];
                              }
                            }
                          },
                          borderRadius: 30,
                          hint: 'Choose location',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Choose location";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        CustomTextField(
                          controller: _referralCodeController,
                          borderRadius: 30,
                          hint: "Referral Code (optional)",
                          onChanged: (value) {
                            referralCode = value;
                          },
                        ),
                        const SizedBox(height: 50),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                                child: CustomButton(
                                        text: "Submit",
                                        onClick: () async {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            setState(() => isLoading = true);

                                            if (referralCode
                                                .trim()
                                                .isNotEmpty) {
                                              final result =
                                                  await FirestoreDataProvider
                                                      .checkReferralCode(
                                                          _referralCodeController
                                                              .text
                                                              .toUpperCase(),
                                                          _nameController.text);

                                              if (result == false) {
                                                await EasyLoading.showError(
                                                    'Incorrect Referral Code');
                                                setState(
                                                    () => isLoading = false);

                                                return;
                                              }
                                            }
                                            await registerUser(
                                                _nameController.text,
                                                _locationController.text);
                                            setState(() => isLoading = false);

                                            Navigator.pushNamed(
                                                context, RouteName.bottomBar,
                                                arguments: 0);
                                          }
                                        },
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 43,
                                        radius: 30,
                                        color: HexColor('FD7E0E'))
                                    .use()),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> registerUser(String name, String location) async {
    try {
      User? _user = FirebaseAuth.instance.currentUser;
      String? userId = _user?.uid;
      String? phoneNumber = _user?.phoneNumber;

      await FirebaseFirestore.instance.collection('users').doc(userId).set(
        {
          'name': name,
          'uid': userId,
          'freeCredit': 1,
          'isSubscribed': false,
          'freeCreditPropertyBox': 1,
          'phone': phoneNumber,
          'counter': 0,
          'wallet_amount': 0,
          'location': location,
          'ref_code': userId?.substring(0, 6).toUpperCase(),
          'email': '',
          'agent_exp': '',
          'profile_pic': '',
        },
      );
    } catch (e) {
      print(e);
    }
  }
}
