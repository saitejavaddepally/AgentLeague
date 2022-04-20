// ignore_for_file: avoid_print

import 'package:agent_league/components/custom_button.dart';
import 'package:agent_league/route_generator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../theme/colors.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  String phoneNumber = '';
  String name = '';
  String referralCode = '';
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: loading,
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
                    const Text("create new account",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 25,
                        ),
                        Row(children: [
                          const SizedBox(width: 5),
                          Image.asset("assets/flag-india.png"),
                          const Text(
                            " (+91)",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 14),
                          ),
                          const SizedBox(width: 10),
                          Flexible(
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              onChanged: (number) {
                                phoneNumber = number;
                              },
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
                                  contentPadding: const EdgeInsets.all(10),
                                  hintText: "    Your number here",
                                  hintStyle: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      color: Colors.white.withOpacity(0.3)),
                                  fillColor: Colors.white.withOpacity(0.1),
                                  filled: true,
                                  errorBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.red, width: 0.5),
                                      borderRadius: BorderRadius.circular(31)),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.red, width: 0.5),
                                      borderRadius: BorderRadius.circular(31)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(31)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(31))),
                            ),
                          ),
                        ]),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          cursorColor: Colors.white.withOpacity(0.1),
                          onChanged: (value) {
                            name = value;
                          },
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(10),
                              hintText: "    Enter your name",
                              hintStyle: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: Colors.white.withOpacity(0.3)),
                              fillColor: Colors.white.withOpacity(0.1),
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(31)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(31))),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextField(
                          cursorColor: Colors.white.withOpacity(0.1),
                          onChanged: (value) {
                            referralCode = value;
                          },
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(10),
                              hintText: "    Enter code",
                              hintStyle: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: Colors.white.withOpacity(0.3)),
                              fillColor: Colors.white.withOpacity(0.1),
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(31)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(31))),
                        ),
                        const SizedBox(height: 50),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                                child: CustomButton(
                                        text: "Sign Up",
                                        onClick: () async {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            Navigator.pushNamed(
                                              context,
                                              RouteName.otp,
                                              arguments: phoneNumber,
                                            );
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
                        const SizedBox(height: 30),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                  child: Image.asset("assets/member.png",
                                      height: 70))
                            ]),
                        const SizedBox(
                          height: 30,
                        ),
                        Center(
                            child: CustomButton(
                                    text: "sign in",
                                    onClick: () {
                                      Navigator.pushNamed(context, '/');
                                    },
                                    height: 43,
                                    radius: 30,
                                    textColor: Colors.yellow,
                                    color: CustomColors.dark)
                                .use()),
                        const SizedBox(
                          height: 40,
                        ),
                        Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.7,
                            height: 50,
                            child: Column(
                              children: const [
                                Center(
                                  child: Text(
                                    'By clicking signup you agree for our ',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    'Terms & Conditions',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
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
}
