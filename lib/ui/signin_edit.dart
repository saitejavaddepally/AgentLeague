import 'package:agent_league/components/custom_button.dart';
import 'package:agent_league/components/custom_container.dart';
import 'package:agent_league/theme/colors.dart';
import 'package:agent_league/theme/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class SignInEdit extends StatefulWidget {
  const SignInEdit({Key? key}) : super(key: key);

  @override
  _SignInEditState createState() => _SignInEditState();
}

class _SignInEditState extends State<SignInEdit> {
  double height = 500;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      Container(
        color: const Color(0xFF000000).withOpacity(0.1),
        width: double.maxFinite,
        height: 170,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset(
            "assets/logo.png",
            width: 150,
            height: 74.6,
          ),
        ]),
      ),
      CustomContainer(
        margin: const EdgeInsets.all(14),
        padding: const EdgeInsets.all(12.0),
        height: 400,
        color: CustomColors.dark,
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Container(
                  width: 350,
                  height: 400 * 0.55,
                  child: Image.asset("assets/img.png"),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      color: Colors.red),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 14, 0, 0),
                  width: 350,
                  height: 500 * 0.2,
                  // decoration:
                  //     BoxDecoration(border: Border.all(color: Colors.red)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomButton(
                        width: 160,
                        height: 50,
                        color: CustomColors.dark,
                        textColor: Colors.yellow,
                        onClick: () {
                          Navigator.pushNamed(context, '/sign_up');
                        },
                        text: 'Sign Up',
                      ).use(),
                      CustomButton(
                        width: 160,
                        height: 50,
                        textColor: Colors.yellow,
                        color: CustomColors.dark,
                        onClick: () {
                          Navigator.pushNamed(context, '/');
                        },
                        text: 'Sign In',
                      ).use(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ).use()
    ]));
  }
}

// CustomButton(
// text: 'sign up',
// color: HexColor('#FD7E0E').withOpacity(0.7),
// onClick: () => currentTheme.toggleTheme(),
//
// ).use()),
