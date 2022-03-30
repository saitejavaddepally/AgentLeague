// import 'package:flutter/cupertino.dart';
import 'package:agent_league/components/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../theme/colors.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:http/http.dart' as http;

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

  Future<bool> sendOtp(String number) async {
    try {
      var response = await http.get(Uri.parse(
          'http://pwtpl.com/sms/V1/send-sms-api.php?apikey=uJ1ihilQ2YmkLQgv&senderid=PROBOX&templateid=1207161182287211693&entityid=1201160586379471408&number=$number&message=Welcome%20to%20PropertyBox%3A-%20Your%20OTP%20is%20-%20%7B%23var%23%7D&format=json'));

      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: loading,
      child: Scaffold(
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
            child: Form(
              key: _formKey,
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
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              onChanged: (number) {
                                phoneNumber = number;
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
                        const Text("Referral code (optional)",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 14)),
                        const SizedBox(
                          height: 20,
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
                                          setState(() {
                                            loading = true;
                                          });
                                          bool result =
                                              await sendOtp(phoneNumber);
                                          if (result) {
                                            setState(() {
                                              loading = false;
                                            });

                                            Navigator.pushNamed(
                                                context, "/otp");
                                          } else {
                                            setState(() {
                                              loading = false;
                                            });
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    content: Text(
                                                        'Something Went Wrong!')));
                                          }
                                        },
                                        width: 360,
                                        height: 43,
                                        radius: 30,
                                        color: HexColor('FD7E0E'))
                                    .use()),
                          ],
                        ),
                        const SizedBox(height: 20),
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
                                      Navigator.pushNamed(context, '/home');
                                    },
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
        ),
      ),
    );
  }
}
