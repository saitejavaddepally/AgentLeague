// import 'package:flutter/cupertino.dart';
import 'package:agent_league/components/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../theme/colors.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        elevation: 0,
        backgroundColor: CustomColors.dark,
        title: GestureDetector(
          onTap: () {},
          child: Container(
            margin: const EdgeInsets.all(14),
            width: 75.93,
            height: 46.05,
            child: Image.asset("assets/logo_onboarding.png"),
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.all(24),
            child: CustomButton(
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
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    const Text("mobile number*",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 14)),
                    const SizedBox(
                      height: 20,
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
                        child: TextField(
                          keyboardType: TextInputType.number,
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
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(31)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(31))),
                        ),
                      ),
                    ]),
                    const SizedBox(height: 30),
                    const Text("name*",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 14)),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      cursorColor: Colors.white.withOpacity(0.1),
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
                    const Text("Referral code (optional)",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 14)),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      cursorColor: Colors.white.withOpacity(0.1),
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
                    const SizedBox(height: 30),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomButton(
                                text: "Sign Up",
                                onClick: () {
                                  Navigator.pushNamed(context, "/otp");
                                },
                                width: 360,
                                height: 43,
                                radius: 30,
                                color: HexColor('FD7E0E'))
                            .use()
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Flexible(
                          child: Image.asset("assets/member.png", height: 70))
                    ]),
                    const SizedBox(height: 30,),
                    Center(
                        child: CustomButton(
                                text: "sign in",
                                onClick: () {},
                                height: 43,
                                radius: 30,
                            textColor: Colors.yellow,
                                color: CustomColors.dark)
                            .use())
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
