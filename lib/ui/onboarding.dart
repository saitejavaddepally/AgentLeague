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

class Onboarding extends StatefulWidget {
  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final List<Widget> list = [
    Page(
        image: "assets/onboarding1.png",
        text1: "Never miss your ",
        colorText: "sale",
        text2: "",
        text3:
            "Increase real estate sales with\ntechnology enabled lead\nmanagement at your fingertips"),
    Page(
        image: "assets/onboarding2.png",
        text1: "Don't carry bundles of\n",
        colorText: "marketing ",
        text2: "flyers",
        text3:
            "It's time to upgrade the way you\ndemonstrate realty projects to\nyour customers"),
    Page(
        image: "assets/onboarding3.png",
        text1: "Introducing ",
        colorText: "LeadsBox\n",
        text2: "(The Agent Genie)",
        text3: "Ask your genie how many leads\nyou want right now."),
    Page(
        image: "assets/onboarding4.png",
        text1: "",
        colorText: "Analytics ",
        text2: "at work",
        text3:
            "Analyse your sales, leads and\nearnings with our customised \ndashboards made for you"),
    Page(
        image: "assets/onboarding5.png",
        text1: "Become ",
        colorText: "personal realty\n",
        text2: "officer not just an agent",
        text3:
            "Provide reality services like legal\nverification, drafting and loans etc\nto your customers with our support")
  ];

  final PageController _controller = PageController();
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.keyboard_backspace)),
                    Image.asset("assets/logo_onboarding.png"),
                    (_currentPage == 5)
                        ? const SizedBox(width: 50)
                        : GestureDetector(
                            onTap: () {
                              setState(() {
                                _controller.jumpToPage(4);
                              });
                            },
                            child: const Text("Skip All",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                )),
                          )
                  ],
                ),
              ),
              SizedBox(
                width: double.maxFinite,
                height: 490,
                child: PageView.builder(
                    physics: const ClampingScrollPhysics(),
                    controller: _controller,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page + 1;
                      });
                    },
                    itemCount: list.length,
                    itemBuilder: (context, index) => list[index]),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  (_currentPage == 1) ? activeIndicator() : inactiveIndicator(),
                  (_currentPage == 2) ? activeIndicator() : inactiveIndicator(),
                  (_currentPage == 3) ? activeIndicator() : inactiveIndicator(),
                  (_currentPage == 4) ? activeIndicator() : inactiveIndicator(),
                  (_currentPage == 5) ? activeIndicator() : inactiveIndicator(),
                ],
              ),
              const SizedBox(height: 80),
              GestureDetector(
                onTap: () {
                  _controller.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.ease);
                },
                child: Container(
                  width: 140,
                  height: 43,
                  decoration: BoxDecoration(
                      boxShadow: shadow,
                      borderRadius: BorderRadius.circular(30),
                      gradient: const LinearGradient(
                          colors: [Color(0xFFFD7E0E), Color(0xFFC12103)])),
                  child: Center(
                    child: (_currentPage == 5)
                        ? const Text("Sign Up",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                letterSpacing: 0.4,
                                color: Colors.white))
                        : const Text("Next",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                letterSpacing: 0.4,
                                color: Colors.white)),
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget activeIndicator() {
    return AnimatedContainer(
      height: 5,
      width: 18,
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
          color: const Color(0xFFFE7F0E)),
      curve: Curves.ease,
      duration: const Duration(milliseconds: 500),
    );
  }
}

Widget inactiveIndicator() {
  return Container(
    width: 5,
    height: 5,
    margin: const EdgeInsets.only(right: 8),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        color: const Color(0xFFFFFFFF).withOpacity(0.54)),
  );
}

class Page extends StatelessWidget {
  final String image;
  final String text1;
  final String colorText;
  final String text2;
  final String text3;

  Page(
      {required this.image,
      required this.text1,
      required this.colorText,
      required this.text2,
      required this.text3});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(13.0),
      child: Container(
        margin: const EdgeInsets.only(top: 10, right: 5, left: 10, bottom: 5),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        decoration: BoxDecoration(
            boxShadow: shadow,
            color: const Color(0xFF082640),
            borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            Expanded(child: Image.asset(image)),
            const SizedBox(height: 20),
            RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        letterSpacing: 0.4,
                        color: Color(0xFFFFFFFF)),
                    children: [
                      TextSpan(text: text1),
                      TextSpan(
                          text: colorText,
                          style: const TextStyle(color: Color(0xFFFE7F0E))),
                      TextSpan(text: text2)
                    ])),
            const SizedBox(height: 10),
            Text(
              text3,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: Colors.white,
                letterSpacing: 0.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
