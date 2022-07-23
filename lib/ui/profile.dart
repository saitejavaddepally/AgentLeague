import 'package:agent_league/Services/auth_methods.dart';
import 'package:agent_league/components/custom_button.dart';
import 'package:agent_league/components/home_container.dart';
import 'package:agent_league/helper/constants.dart';
import 'package:agent_league/route_generator.dart';
import 'package:agent_league/theme/colors.dart';
import 'package:agent_league/ui/edit_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../Services/upload_properties_to_firestore.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool loading = false;
  var name = '';
  var phone = '';
  String? profileUrl = '';

  Future asyncTriggerFunction() async {
    List data = await getProfileInformation();
    setState(() {
      name = data[0];
      phone = data[1];
      profileUrl = data[2];
    });
  }

  Future getProfileInformation() async {
    Map data = await UploadPropertiesToFirestore().getProfileInformation();
    String? profileUrl =
        await UploadPropertiesToFirestore().getProfilePicture();
    return [data['name'], data['phone'], profileUrl];
  }

  @override
  void initState() {
    setState(() {
      loading = true;
    });
    asyncTriggerFunction();
    setState(() {
      loading = false;
    });
    super.initState();
  }

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
                      child: Row(children: [
                    Container(
                      height: 54,
                      width: 54,
                      decoration: BoxDecoration(
                          boxShadow: shadow1,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.orange, width: 1.5)),
                      child: (profileUrl != '')
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(50.0),
                              child: Image.network(
                                profileUrl!,
                                height: 40.0,
                                width: 40.0,
                                fit: BoxFit.fill,
                              ),
                            )
                          : Image.asset("assets/profile.png", fit: BoxFit.fill),
                    ),
                    const SizedBox(width: 10),
                    (!loading)
                        ? RichText(
                            text: TextSpan(
                                style: const TextStyle(
                                    height: 1.4,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    letterSpacing: -0.15),
                                children: [
                                TextSpan(
                                    text: name.toString().toUpperCase() + "\n"),
                                TextSpan(
                                    text: phone,
                                    style: TextStyle(
                                        color: Colors.white.withOpacity(0.54)))
                              ]))
                        : const SizedBox(
                            height: 20, child: Center(child: Text('Loading..')))
                  ])),
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
                  buttonWidth: 112,
                  onButtonClick: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const EditProfile()));
                  }),
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
                  onButtonClick: () {
                    Navigator.pushNamed(context, RouteName.help);
                  }),
              const SizedBox(height: 20),
              HomeContainer(
                  text:
                      "Do you have ideas to improve our app, business, usage?",
                  textColor: Colors.white,
                  image: "assets/hear.png",
                  containerColor: const Color(0xFFF66A83),
                  buttonWidth: 100,
                  buttonText: "We Hear",
                  onButtonClick: () {
                    Navigator.pushNamed(context, RouteName.weHear);
                  }),
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
                        context, RouteName.login, (route) => false);
                  }),
            ],
          ),
        ),
      )),
    );
  }
}
