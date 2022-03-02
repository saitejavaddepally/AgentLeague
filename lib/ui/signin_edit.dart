import 'package:agent_league/components/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class SignInEdit extends StatefulWidget {
  const SignInEdit({Key? key}) : super(key: key);

  @override
  _SignInEditState createState() => _SignInEditState();
}

class _SignInEditState extends State<SignInEdit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(
              child: CustomButton(text: 'sign up', color: Colors.green )
                  .use()),
        ],
      ),
    );
  }
}
