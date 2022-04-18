import 'package:flutter/material.dart';

import '../../components/custom_title.dart';
import '../../components/home_container.dart';
import '../../helper/constants.dart';

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
                  height: 360,
                  width: double.maxFinite,
                  padding: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                      image: const DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage('assets/frame.png')),
                      boxShadow: const [
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
                      ],
                      borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                          text: const TextSpan(
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 18),
                              children: [
                            TextSpan(text: "Introducing LeadsBox "),
                            TextSpan(
                                text: "(The Agent Genie)",
                                style: TextStyle(fontWeight: FontWeight.w400))
                          ])),
                      const Text(
                          'Tired of asking referrals from friends? Just rub the LeadsBox lantern and ask your genie how many leads you want right now.',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              letterSpacing: 0.4)),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                const CustomTitle(text: "Refer Your Friends"),
                const SizedBox(height: 10),
                HomeContainer(
                    text:
                        "Earn 200 INR into your AL money by referring your friend",
                    image: "assets/refer.png",
                    containerColor: const Color(0xFF5BE4CC),
                    buttonWidth: 109,
                    buttonText: "Refer Now",
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
