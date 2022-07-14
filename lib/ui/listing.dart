import 'package:agent_league/Services/upload_properties_to_firestore.dart';
import 'package:agent_league/helper/shared_preferences.dart';
import 'package:agent_league/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../components/custom_button.dart';
import '../components/home_container.dart';
import '../theme/colors.dart';

class Listing extends StatefulWidget {
  const Listing({Key? key}) : super(key: key);

  @override
  State<Listing> createState() => _ListingState();
}

class _ListingState extends State<Listing> {
  bool freeListingDisabled = false;

  @override
  void initState() {
    asyncTrigger();
    super.initState();
  }

  Future asyncTrigger() async {
    EasyLoading.show(status: "Please wait..");
    String data = await UploadPropertiesToFirestore().plotCreditChecker();
    print("credits are $data");
    if (data == "0") {
      setState(() {
        freeListingDisabled = true;
      });
    }

    EasyLoading.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
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
              const SizedBox(
                height: 30,
              ),
              HomeContainer(
                  text: "Free listing",
                  isSecondText: true,
                  text2:
                      'You are eligible for one free \ndigitalization as part of company \npromotion.',
                  image: "assets/listing_1.png",
                  isGradient: true,
                  gradient: LinearGradient(colors: [
                    HexColor('5BE4CC'),
                    HexColor('5BE4CC').withOpacity(0.2),
                  ]),
                  textColor: Colors.black,
                  buttonWidth: 109,
                  buttonText: "Free Listing",
                  buttonTextColor: const Color(0xFF21293A),
                  isButtonDisabled: freeListingDisabled,
                  buttonColor: const Color(0xFFF3F4F6),
                  onButtonClick: () async {
                    await SharedPreferencesHelper().savePaidCreditStatus(false);
                    Navigator.pushNamed(
                        context, RouteName.postYourPropertyPageOne);
                  }),
              const SizedBox(
                height: 20,
              ),
              HomeContainer(
                  text: "Paid Listing",
                  isSecondText: true,
                  text2:
                      'AgentFly charges \n100 per digitalization of one property Go for paid listing if \n 1. Your free listing is availed. \n 2. not interested for free listing.',
                  image: "assets/listing_2.png",
                  isGradient: true,
                  gradient: LinearGradient(colors: [
                    HexColor('A461CD').withOpacity(0.7),
                    HexColor('D29AF3').withOpacity(0.3),
                  ]),
                  textColor: Colors.white.withOpacity(0.87),
                  buttonWidth: 109,
                  buttonText: "Paid Listing",
                  buttonTextColor: const Color(0xFF21293A),
                  buttonColor: const Color(0xFFF3F4F6),
                  onButtonClick: () async {
                    await SharedPreferencesHelper().savePaidCreditStatus(true);
                    Navigator.pushNamed(
                      context,
                      RouteName.postYourPropertyPageOne,
                    );
                  }),
            ],
          ),
        ),
      ),
    ));
  }
}
