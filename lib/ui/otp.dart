// ignore_for_file: avoid_print

import 'dart:async';

import 'package:agent_league/helper/constants.dart';
import 'package:agent_league/provider/otp_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class Otp extends StatefulWidget {
  final String args;
  const Otp({required this.args, Key? key}) : super(key: key);

  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  late final String phoneNumber;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _verificationId;
  bool loading = false;

  Future<void> verifyUser() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: "+91" + phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        //   print("verification complete");
        //   UserCredential userCredentials =
        //       await _auth.signInWithCredential(credential);

        //   Navigator.pushReplacementNamed(context, '/');
      },
      verificationFailed: (FirebaseAuthException e) {
        print("Verification failed" + e.code);
        if (e.code == 'invalid-phone-number') {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Invalid Phone Number')));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Something Went Wrong")));
        }
      },
      codeSent: (String verificationId, int? resendToken) {
        print("code sent");
        _verificationId = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  @override
  void initState() {
    super.initState();
    phoneNumber = widget.args;
    verifyUser().then((value) {});
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => OtpTimer()),
          ChangeNotifierProvider(create: (context) => OtpProvider())
        ],
        builder: (context, widget) {
          final otpProvider = Provider.of<OtpProvider>(context, listen: false);
          return ModalProgressHUD(
            inAsyncCall: loading,
            child: Scaffold(
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        color: const Color(0xFF000000).withOpacity(0.1),
                        width: double.maxFinite,
                        height: 150,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/logo_otp.png",
                              ),
                            ]),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Text(
                          "enter otp send to your mobile\nnumber ${phoneNumber.replaceRange(2, 8, '******')}",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              fontSize: 16),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Consumer<OtpProvider>(builder: (context, value, child) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: buildTextField(
                                  (value.otp.asMap().containsKey(0))
                                      ? value.otp[0].toString()
                                      : ''),
                            ),
                            const SizedBox(width: 10),
                            Flexible(
                              child: buildTextField(
                                  (value.otp.asMap().containsKey(1))
                                      ? value.otp[1].toString()
                                      : ''),
                            ),
                            const SizedBox(width: 10),
                            Flexible(
                              child: buildTextField(
                                  (value.otp.asMap().containsKey(2))
                                      ? value.otp[2].toString()
                                      : ''),
                            ),
                            const SizedBox(width: 10),
                            Flexible(
                              child: buildTextField(
                                  (value.otp.asMap().containsKey(3))
                                      ? value.otp[3].toString()
                                      : ''),
                            ),
                            const SizedBox(width: 10),
                            Flexible(
                              child: buildTextField(
                                  (value.otp.asMap().containsKey(4))
                                      ? value.otp[4].toString()
                                      : ''),
                            ),
                            const SizedBox(width: 10),
                            Flexible(
                              child: buildTextField(
                                  (value.otp.asMap().containsKey(5))
                                      ? value.otp[5].toString()
                                      : ''),
                            )
                          ],
                        );
                      }),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Consumer<OtpTimer>(builder: (context, value, child) {
                            return Flexible(
                              child: InkWell(
                                borderRadius: BorderRadius.circular(30),
                                onTap: (value.seconds == 0) ? () {} : null,
                                child: Container(
                                  width: 98,
                                  height: 36,
                                  decoration: BoxDecoration(
                                      color: (value.seconds == 0)
                                          ? const Color(0xFF082640)
                                          : Colors.white.withOpacity(0.3),
                                      boxShadow: shadow1,
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Center(
                                      child: Text(
                                    "resend",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                        letterSpacing: 0.4,
                                        color: (value.seconds == 0)
                                            ? const Color(0xFFFE7F0E)
                                            : Colors.white.withOpacity(0.3)),
                                  )),
                                ),
                              ),
                            );
                          }),
                          const SizedBox(width: 20),
                          Consumer<OtpTimer>(builder: (context, value, child) {
                            return buildTimer(value);
                          }),
                          const SizedBox(width: 20),
                          Flexible(
                            child: GestureDetector(
                              onTap: () async {
                                if (_verificationId != null) {
                                  final result = await otpProvider
                                      .checkOtp(_verificationId!);
                                  if (result == "correct") {
                                    Navigator.pushNamedAndRemoveUntil(
                                        context, '/', (route) => false);
                                  } else if (result == 'incorrect') {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                "Please Enter Correct OTP"),
                                            duration: Duration(seconds: 2)));
                                  } else if (result == 'enterotp') {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text("Please Enter OTP"),
                                            duration: Duration(seconds: 2)));
                                  }
                                }
                              },
                              child: Container(
                                width: 98,
                                height: 36,
                                decoration: BoxDecoration(
                                    gradient: const LinearGradient(colors: [
                                      Color(0xFFFD7E0E),
                                      Color(0xFFC12103)
                                    ]),
                                    boxShadow: shadow1,
                                    borderRadius: BorderRadius.circular(30)),
                                child: const Center(
                                    child: Text(
                                  "submit",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      letterSpacing: 0.4,
                                      color: Color(0xFFFFFFFF)),
                                )),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 70),
                      Wrap(
                        spacing: 50,
                        children: [
                          KeyPad(
                              number: '1',
                              onTap: () => otpProvider.pushToOtp(1)),
                          KeyPad(
                              number: '2',
                              onTap: () => otpProvider.pushToOtp(2)),
                          KeyPad(
                              number: '3',
                              onTap: () => otpProvider.pushToOtp(3)),
                        ],
                      ),
                      const SizedBox(height: 25),
                      Wrap(
                        spacing: 50,
                        children: [
                          KeyPad(
                              number: '4',
                              onTap: () => otpProvider.pushToOtp(4)),
                          KeyPad(
                              number: '5',
                              onTap: () => otpProvider.pushToOtp(5)),
                          KeyPad(
                              number: '6',
                              onTap: () => otpProvider.pushToOtp(6)),
                        ],
                      ),
                      const SizedBox(height: 25),
                      Wrap(
                        spacing: 50,
                        children: [
                          KeyPad(
                              number: '7',
                              onTap: () => otpProvider.pushToOtp(7)),
                          KeyPad(
                              number: '8',
                              onTap: () => otpProvider.pushToOtp(8)),
                          KeyPad(
                              number: '9',
                              onTap: () => otpProvider.pushToOtp(9)),
                        ],
                      ),
                      const SizedBox(height: 25),
                      Wrap(
                        spacing: 50,
                        children: [
                          const SizedBox(width: 60),
                          KeyPad(
                              number: '0',
                              onTap: () => otpProvider.pushToOtp(0)),
                          GestureDetector(
                            onTap: () => otpProvider.popFromOtp(),
                            child: Container(
                              height: 48,
                              width: 48,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: const Color(0xFF082640),
                                boxShadow: shadow1,
                              ),
                              child: const Center(
                                  child: Icon(Icons.backspace_outlined)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  Widget buildTextField(String number) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(31),
          color: Colors.white.withOpacity(0.1)),
      child: Center(
          child: Text(number,
              style:
                  const TextStyle(fontWeight: FontWeight.w500, fontSize: 16))),
    );
  }

  Widget buildTime(seconds) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(children: [
        TextSpan(
            text: '$seconds',
            style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                letterSpacing: 0.4,
                color: Color(0xFF1B1B1B))),
        const TextSpan(
            text: 's',
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                letterSpacing: 0.4,
                color: Color(0xFF1B1B1B)))
      ]),
    );
  }

  Widget buildTimer(OtpTimer value) {
    return Container(
      height: 72,
      width: 72,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(40),
          boxShadow: shadow1),
      child: Stack(
        children: [
          Center(
            child: SizedBox(
              height: 50,
              width: 50,
              child: CircularProgressIndicator(
                value: 1 - value.seconds / OtpTimer.maxSecond,
                strokeWidth: 3,
                valueColor: const AlwaysStoppedAnimation(Colors.white),
                backgroundColor: Colors.orange,
              ),
            ),
          ),
          Center(child: buildTime(value.seconds))
        ],
      ),
    );
  }
}

class KeyPad extends StatelessWidget {
  final String number;
  final void Function() onTap;

  const KeyPad({Key? key, required this.number, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48,
        width: 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: const Color(0xFF082640),
          boxShadow: shadow1,
        ),
        child: Center(
          child: Text(
            number,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 18,
                color: Color(0xFFFFFFFF),
                letterSpacing: 0.4),
          ),
        ),
      ),
    );
  }
}
