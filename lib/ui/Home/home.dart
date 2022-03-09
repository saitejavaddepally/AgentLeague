import 'package:agent_league/components/custom_button.dart';
import 'package:agent_league/components/custom_container.dart';
import 'package:flutter/material.dart';

const shadow = [
  BoxShadow(
      offset: Offset(-6, -6),
      blurRadius: 12,
      spreadRadius: 0,
      color: Color(0xFF113B5F)),
  BoxShadow(
      offset: Offset(0, 6),
      blurRadius: 12,
      spreadRadius: 0,
      color: Color(0xFF031E35)),
];

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
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    Flexible(
                        child: CustomImage(
                            image: "assets/leadsBox.png",
                            text: "LeadsBox",
                            isDecorated: true)),
                    Spacer(flex: 2),
                    Flexible(
                        child: CustomImage(
                            image: "assets/profile.png", text: "profile")),
                    Flexible(
                        child: CustomImage(
                            image: "assets/profile.png", text: "explore")),
                    Flexible(
                        child: CustomImage(
                            image: "assets/profile.png", text: "alerts")),
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
                                text: "(TheAgent Genie)",
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
                const Title(text: "Site visits"),
                const SizedBox(height: 10),
                HomeContainer(
                    text:
                        "Don’t miss scheduled site visits. It's  first step towards real estate sales.",
                    image: "assets/calendar.png",
                    containerColor: const Color(0xFFF7C6FF),
                    buttonText: "What's Schedule",
                    buttonWidth: 159,
                    buttonTextColor: Colors.white,
                    buttonColor: const Color(0xFF1B1B1B),
                    onButtonClick: () {}),
                const SizedBox(height: 30),
                const Title(text: "Tasks"),
                const SizedBox(height: 10),
                HomeContainer(
                    text:
                        "Complete all pending tasks to keep your deals upto date",
                    image: "assets/tasks.png",
                    containerColor: const Color(0xFFC0D9FF),
                    buttonWidth: 116,
                    buttonText: "View Tasks",
                    buttonTextColor: Colors.white,
                    buttonColor: const Color(0xFF1B1B1B),
                    onButtonClick: () {}),
                const SizedBox(height: 30),
                const Title(text: "Refer Your Friends"),
                const SizedBox(height: 10),
                HomeContainer(
                    text:
                        "Earn 200 INR into your AL money by referring your friend",
                    image: "assets/refer.png",
                    containerColor: const Color(0xFF55C18D),
                    buttonWidth: 109,
                    buttonText: "Refer Now",
                    buttonTextColor: Color(0xFF21293A),
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
  const CustomImage(
      {required this.image,
      required this.text,
      this.isDecorated = false,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(shape: BoxShape.circle),
      child: Column(children: [
        Container(
            decoration: (isDecorated)
                ? BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.blue))
                : null,
            child: Image.asset(image, height: 40, width: 40)),
        const SizedBox(height: 3),
        Text(
          text,
          style: const TextStyle(
              fontWeight: FontWeight.w500, fontSize: 12, letterSpacing: -0.15),
        ),
      ]),
    );
  }
}

class Title extends StatelessWidget {
  final String text;
  const Title({required this.text, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        textAlign: TextAlign.center,
        style: const TextStyle(
            fontWeight: FontWeight.w600, fontSize: 18, letterSpacing: -0.15));
  }
}

class HomeContainer extends StatelessWidget {
  final String text;
  final String image;
  final Color containerColor;
  final String buttonText;
  final Color buttonTextColor;
  final Color buttonColor;
  final double buttonWidth;
  final void Function() onButtonClick;
  const HomeContainer(
      {required this.text,
      required this.image,
      required this.containerColor,
      required this.buttonText,
      required this.buttonTextColor,
      required this.buttonColor,
      required this.buttonWidth,
      required this.onButtonClick,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 5, top: 20, right: 20, left: 20),
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: shadow,
      ),
      child: Column(
        children: [
          Text(
            text,
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: const Color(0xFF1B1B1B).withOpacity(0.87)),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(child: Image.asset(image)),
              const SizedBox(width: 10),
              Flexible(
                  child: CustomButton(
                          text: buttonText,
                          onClick: onButtonClick,
                          width: buttonWidth,
                          textColor: buttonTextColor,
                          color: buttonColor)
                      .use()),
            ],
          ),
        ],
      ),
    );
  }
}
