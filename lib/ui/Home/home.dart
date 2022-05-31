import 'package:flutter/material.dart';

import '../../components/custom_button.dart';
import '../../components/custom_title.dart';
import '../../components/home_container.dart';
import '../../helper/constants.dart';
import '../../theme/colors.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(children: [
                      CustomImage(
                        image: "assets/leadsBox.png",
                        text: "LeadsBox",
                        isDecorated: true,
                        onTap: () {
                          Navigator.pushNamed(context, '/leads_box');
                        },
                      ),
                    ]),
                    Row(
                      children: [
                        CustomImage(
                            image: "assets/profile.png",
                            text: "profile",
                            onTap: () {
                              Navigator.pushNamed(context, '/profile');
                            }),
                        const SizedBox(width: 15),
                        CustomImage(
                            image: "assets/explorer.png",
                            text: "explore",
                            onTap: () {
                              Navigator.pushNamed(context, '/explore');
                            }),
                        const SizedBox(width: 15),
                        const CustomImage(
                            image: "assets/alerts.png", text: "alerts"),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                RichText(
                    text: const TextSpan(
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 18),
                        children: [
                      TextSpan(text: "Hello, "),
                      TextSpan(
                          text: "Name",
                          style: TextStyle(fontWeight: FontWeight.w600))
                    ])),
                const SizedBox(height: 5),
                const Text('Todays recommended actions for you',
                    style:
                        TextStyle(fontWeight: FontWeight.w400, fontSize: 14)),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.only(
                      top: 20, right: 20, left: 20, bottom: 12),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      HexColor('11073E'),
                      HexColor('53439B').withOpacity(0.40)
                    ]),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                          offset: const Offset(-6, -6),
                          spreadRadius: 0,
                          color: HexColor('113B5F'),
                          blurRadius: 12)
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Digitalize your property',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white.withOpacity(0.87))),
                      const SizedBox(height: 5),
                      Text(
                          'Don’t carry property docs to demonstrate, just digitalize',
                          style: TextStyle(
                              fontSize: 14,
                              height: 1.4,
                              fontWeight: FontWeight.w600,
                              color: Colors.white.withOpacity(0.87))),
                      const SizedBox(height: 5),
                      Text('One free digitalization.',
                          style: TextStyle(
                              fontSize: 14,
                              height: 1.4,
                              fontWeight: FontWeight.w400,
                              color: Colors.white.withOpacity(0.7))),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset("assets/digital.png"),
                          CustomButton(
                                  text: 'Go Digital',
                                  onClick: () {},
                                  color: HexColor('F3F4F6'),
                                  textColor: HexColor('21293A'),
                                  width: 109)
                              .use(),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                HomeContainer(
                    text: "Refer and Earn",
                    isSecondText: true,
                    text2:
                        'Earn one more free difitalization by referring your friends.',
                    image: "assets/refer.png",
                    isGradient: true,
                    gradient: LinearGradient(colors: [
                      HexColor('6AFFE4').withOpacity(0.40),
                      HexColor('4CCDB6').withOpacity(0.80)
                    ]),
                    textColor: Colors.white.withOpacity(0.87),
                    buttonWidth: 109,
                    buttonText: "Refer Now",
                    buttonTextColor: const Color(0xFF21293A),
                    buttonColor: const Color(0xFFF3F4F6),
                    onButtonClick: () {}),
                const SizedBox(height: 30),
                HomeContainer(
                    text: "Are you a Corporate Agent selling project?",
                    isSecondText: true,
                    text2: 'Subscribe to your project now.',
                    image: "assets/subscribe.png",
                    isGradient: true,
                    gradient: LinearGradient(colors: [
                      HexColor('EC6780').withOpacity(0.20),
                      HexColor('EE6881').withOpacity(0.70)
                    ]),
                    textColor: Colors.white.withOpacity(0.87),
                    buttonWidth: 109,
                    buttonText: "Subscribe",
                    buttonTextColor: const Color(0xFF21293A),
                    buttonColor: const Color(0xFFF3F4F6),
                    onButtonClick: () {}),
                const SizedBox(height: 30),
                HomeContainer(
                    text:
                        "Are your customers confused to which project they can afford?",
                    isSecondText: true,
                    text2: 'Property buying score will help you.',
                    image: "assets/check_now.png",
                    isGradient: true,
                    gradient: LinearGradient(colors: [
                      HexColor('D29AF3').withOpacity(0.30),
                      HexColor('A461CD').withOpacity(0.70)
                    ]),
                    textColor: Colors.white.withOpacity(0.87),
                    buttonWidth: 117,
                    buttonText: "Check Now",
                    buttonTextColor: const Color(0xFF21293A),
                    buttonColor: const Color(0xFFF3F4F6),
                    onButtonClick: () {}),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomImage extends StatelessWidget {
  final String image;
  final String text;
  final bool isDecorated;

  final void Function()? onTap;

  const CustomImage(
      {required this.image,
      required this.text,
      this.onTap,
      this.isDecorated = false,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: const BoxDecoration(shape: BoxShape.circle),
        child: Column(children: [
          Container(
              decoration: (isDecorated)
                  ? BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.blue))
                  : const BoxDecoration(boxShadow: shadow1),
              child: Image.asset(image, height: 40, width: 40)),
          const SizedBox(height: 3),
          Text(
            text,
            style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12,
                letterSpacing: -0.15),
          ),
        ]),
      ),
    );
  }
}
