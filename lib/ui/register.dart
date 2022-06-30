import 'package:agent_league/components/custom_button.dart';
import 'package:agent_league/components/custom_text_field.dart';
import 'package:flutter/material.dart';

import '../components/custom_title.dart';
import '../theme/colors.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Row(
              children: [
                GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.keyboard_backspace_rounded)),
                const SizedBox(width: 20),
                const Flexible(child: CustomTitle(text: 'Register'))
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                    child: Icon(Icons.account_circle_rounded, size: 120),
                    radius: 60),
                const SizedBox(height: 30),
                const CustomTextField(hint: "   Enter Full Name"),
                const SizedBox(height: 30),
                CustomButton(
                        text: "Submit",
                        onClick: () {},
                        color: HexColor('FD7E0E'))
                    .use(),
              ],
            )
          ],
        ),
      )),
    );
  }
}
