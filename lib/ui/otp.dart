import 'dart:async';

import 'package:flutter/material.dart';

const shadow = [
  BoxShadow(
      offset: Offset(-6, -6),
      blurRadius: 12,
      spreadRadius: 0,
      color: Color(0xFF113B5F)),
  BoxShadow(
      offset: Offset(6, 6),
      blurRadius: 12,
      spreadRadius: 0,
      color: Color(0xFF031E35)),
];

class Otp extends StatefulWidget {
  const Otp({Key? key}) : super(key: key);

  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  static const maxSecond = 30;
  int seconds = maxSecond;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (seconds > 0) {
        setState(() => seconds--);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                color: const Color(0xFF000000).withOpacity(0.1),
                width: double.maxFinite,
                height: 170,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/logo.png",
                        width: 150,
                        height: 74.6,
                      ),
                      const SizedBox(height: 2),
                      const Padding(
                        padding: EdgeInsets.only(left: 157.0),
                        child: Text(
                          "Every lead counts",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Color(0xFFFFFFFF),
                              fontSize: 10),
                        ),
                      ),
                    ]),
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: Text(
                  "enter otp send to your mobile\nnumber 90******78",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontSize: 16),
                ),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildTextField(),
                  const SizedBox(width: 15),
                  buildTextField(),
                  const SizedBox(width: 15),
                  buildTextField(),
                  const SizedBox(width: 15),
                  buildTextField()
                ],
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(30),
                    onTap: (seconds == 0) ? () {} : null,
                    child: Container(
                      width: 98,
                      height: 36,
                      decoration: BoxDecoration(
                          color: (seconds == 0)
                              ? const Color(0xFF082640)
                              : Colors.white.withOpacity(0.3),
                          boxShadow: shadow,
                          borderRadius: BorderRadius.circular(30)),
                      child: Center(
                          child: Text(
                        "resend",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            letterSpacing: 0.4,
                            color: (seconds == 0)
                                ? const Color(0xFFFE7F0E)
                                : Colors.white.withOpacity(0.3)),
                      )),
                    ),
                  ),
                  const SizedBox(width: 20),
                  buildTimer(),
                  const SizedBox(width: 20),
                  Container(
                    width: 98,
                    height: 36,
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            colors: [Color(0xFFFD7E0E), Color(0xFFC12103)]),
                        boxShadow: shadow,
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
                ],
              ),
              const SizedBox(height: 80),
              Wrap(
                spacing: 50,
                children: [
                  KeyPad(number: '1', onTap: () {}),
                  KeyPad(number: '2', onTap: () {}),
                  KeyPad(number: '3', onTap: () {}),
                ],
              ),
              const SizedBox(height: 25),
              Wrap(
                spacing: 50,
                children: [
                  KeyPad(number: '4', onTap: () {}),
                  KeyPad(number: '5', onTap: () {}),
                  KeyPad(number: '6', onTap: () {}),
                ],
              ),
              const SizedBox(height: 25),
              Wrap(
                spacing: 50,
                children: [
                  KeyPad(number: '7', onTap: () {}),
                  KeyPad(number: '8', onTap: () {}),
                  KeyPad(number: '9', onTap: () {}),
                ],
              ),
              const SizedBox(height: 25),
              Wrap(
                spacing: 50,
                children: [
                  const SizedBox(width: 60),
                  KeyPad(number: '0', onTap: () {}),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: const Color(0xFF082640),
                        boxShadow: shadow,
                      ),
                      child:
                          const Center(child: Icon(Icons.backspace_outlined)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField() {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(31),
          color: Colors.white.withOpacity(0.1)),
      child: const Center(
          child: Text("",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16))),
    );
  }

  Widget buildTime() {
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

  Widget buildTimer() {
    return Container(
      height: 72,
      width: 72,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(40),
          boxShadow: shadow),
      child: Stack(
        children: [
          Center(
            child: SizedBox(
              height: 50,
              width: 50,
              child: CircularProgressIndicator(
                value: 1 - seconds / maxSecond,
                strokeWidth: 3,
                valueColor: const AlwaysStoppedAnimation(Colors.white),
                backgroundColor: Colors.orange,
              ),
            ),
          ),
          Center(child: buildTime())
        ],
      ),
    );
  }
}

class KeyPad extends StatelessWidget {
  final String number;
  void Function() onTap;

  KeyPad({required this.number, required this.onTap});

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
          boxShadow: shadow,
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
