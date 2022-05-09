import 'package:agent_league/Services/auth_methods.dart';
import 'package:agent_league/components/custom_button.dart';
import 'package:agent_league/components/home_container.dart';
import 'package:agent_league/helper/constants.dart';
import 'package:agent_league/route_generator.dart';
import 'package:agent_league/theme/colors.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Row(
                      children: [
                        Container(
                          height: 54,
                          width: 54,
                          decoration: BoxDecoration(
                              boxShadow: shadow1,
                              shape: BoxShape.circle,
                              border:
                                  Border.all(color: Colors.orange, width: 1.5)),
                          child: Image.asset("assets/profile.png",
                              fit: BoxFit.fill),
                        ),
                        const SizedBox(width: 10),
                        RichText(
                            text: TextSpan(
                                style: const TextStyle(
                                    height: 1.4,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    letterSpacing: -0.15),
                                children: [
                              const TextSpan(text: "Kumar\n"),
                              TextSpan(
                                  text: "+91 93765 73647",
                                  style: TextStyle(
                                      color: Colors.white.withOpacity(0.54)))
                            ])),
                      ],
                    ),
                  ),
                  CustomButton(
                          text: "close_round",
                          onClick: () {
                            Navigator.pop(context);
                          },
                          isIcon: true,
                          height: 40,
                          width: 40,
                          color: HexColor('FD7E0E').withOpacity(0.7),
                          rounded: true)
                      .use(),
                ],
              ),
              const SizedBox(height: 40),
              HomeContainer(
                  text:
                      "One wallet for all transactions in app to simplify the usage.\nRegister. Load.Transact",
                  image: "assets/calendar.png",
                  containerColor: const Color(0xFFB2E2D1),
                  buttonText: "AL Wallet",
                  onButtonClick: () {
                    Navigator.pushNamed(context, RouteName.wallet);
                  }),
              const SizedBox(height: 20),
              HomeContainer(
                  text:
                      "Update your details to keep you up to date in our system",
                  image: "assets/tasks.png",
                  containerColor: const Color(0xFFC0D9FF),
                  buttonText: "Edit Profile",
                  isSizedBox: true,
                  buttonWidth: 112,
                  onButtonClick: () {}),
              const SizedBox(height: 20),
              HomeContainer(
                  text:
                      "Earn money into your wallet by referring your friends, family and collegues",
                  image: "assets/refer.png",
                  containerColor: const Color(0xFFFFC0B2),
                  buttonWidth: 109,
                  buttonText: "Refer Now",
                  buttonTextColor: const Color(0xFF21293A),
                  buttonColor: const Color(0xFFF3F4F6),
                  onButtonClick: () {}),
              const SizedBox(height: 20),
              HomeContainer(
                  text: "Are you facing any challenge in app on anytime?",
                  image: "assets/support.png",
                  containerColor: const Color(0xFF52B597),
                  buttonWidth: 97,
                  buttonText: "Support",
                  buttonTextColor: const Color(0xFF21293A),
                  buttonColor: const Color(0xFFF3F4F6),
                  onButtonClick: () {}),
              const SizedBox(height: 20),
              HomeContainer(
                  text:
                      "Do you have ideas to improve our app, business, usage?",
                  textColor: Colors.white,
                  image: "assets/hear.png",
                  containerColor: const Color(0xFFF66A83),
                  buttonWidth: 100,
                  buttonText: "We Hear",
                  onButtonClick: () {}),
              const SizedBox(height: 20),
              HomeContainer(
                  text:
                      "Do you want to sign-out from the app to restart or other things? Don’t forget to sign in back.",
                  image: "assets/signout.png",
                  textColor: const Color(0xFF0E0E0E),
                  containerColor: const Color(0xFFE4BAF3),
                  buttonWidth: 100,
                  buttonText: "Sign Out",
                  onButtonClick: () async {
                    await AuthMethods().signOut();
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/sign_up', (route) => false);
                  }),
            ],
          ),
        ),
      )),
    );
  }
}
