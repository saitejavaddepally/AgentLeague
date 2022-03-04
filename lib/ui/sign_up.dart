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
        elevation: 1,
        backgroundColor: CustomColors.dark,
        title: GestureDetector(
          onTap: () {
          },
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
              text: "help_icon" ,
              onClick: () {
                Navigator.pushNamed(context, '/help');
              },
              width: 48,
              height: 48,
              isIcon: true,
              rounded: true,
              color: Colors.red.withOpacity(0.9)
            ).use(),
          )

        ],
      ),
    );
  }
}
