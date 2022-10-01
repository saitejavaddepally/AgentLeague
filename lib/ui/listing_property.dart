import 'package:agent_league/provider/firestore_data_provider.dart';
import 'package:agent_league/provider/sell_providers/sell_screen_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../Services/firestore_crud_operations.dart';
import '../components/custom_button.dart';
import '../components/home_container.dart';
import '../route_generator.dart';
import '../theme/colors.dart';

class ListingPropertyBox extends StatefulWidget {
  final String id;
  const ListingPropertyBox({required this.id, Key? key}) : super(key: key);

  @override
  State<ListingPropertyBox> createState() => _ListingPropertyBoxState();
}

class _ListingPropertyBoxState extends State<ListingPropertyBox> {
  List<String> text = [
    '1. Buyers can browse all properties.',
    '2. You can view all buyers interested.',
    '3. You can edit the property after posting.',
    '4. Chat/talk to buyers instantly.',
    '5. Close the deal on - spot.'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
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
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                'Advantages of listing in property box',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    height: 1.5,
                    color: Colors.white.withOpacity(0.9),
                    letterSpacing: -0.15),
              ),
              for (var i in text)
                Text(i,
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                        height: 1.6,
                        color: Colors.white.withOpacity(0.8),
                        letterSpacing: -0.15)),
              const SizedBox(height: 25),
              FutureBuilder<num>(
                  initialData: 0,
                  future: SellScreenMethods.getPropertyBoxFreeCredit(),
                  builder: (context, snapshot) {
                    return HomeContainer(
                        text: '',
                        isFirstText: false,
                        isSecondText: true,
                        text2:
                            'AgentFly offers one free listing as part of promotion.',
                        image: "assets/listing_property_1.png",
                        isGradient: true,
                        gradient: LinearGradient(colors: [
                          HexColor('51E9B2'),
                          HexColor('B4FAA9').withOpacity(0.2),
                        ]),
                        isButtonDisabled: (snapshot.data == 0) ? true : false,
                        textColor: Colors.black,
                        buttonWidth: 109,
                        buttonText: "Free Listing",
                        buttonColor: const Color(0xFF1B1B1B),
                        onButtonClick: () async {
                          await EasyLoading.show(status: "Please wait...");
                          await SellScreenMethods.updatePropertyBoxEnable(
                              widget.id);
                          await SellScreenMethods
                              .decrementPropertyBoxFreeCredit();
                          await EasyLoading.dismiss();
                          EasyLoading.showSuccess(
                              'Property added to property box',
                              duration: const Duration(seconds: 3));
                          Navigator.pushNamed(context, RouteName.bottomBar,
                              arguments: 1);
                        });
                  }),
              const SizedBox(
                height: 20,
              ),
              HomeContainer(
                  text: '',
                  isFirstText: false,
                  isSecondText: true,
                  text2:
                      'AgentFly charges \$300 as one time fee to list your property till you close the deal.',
                  image: "assets/listing_property_2.png",
                  isGradient: true,
                  gradient: LinearGradient(colors: [
                    HexColor('ECB1A8'),
                    HexColor('F2DFD1').withOpacity(0.2),
                  ]),
                  textColor: Colors.black,
                  buttonWidth: 109,
                  buttonText: "Paid Listing",
                  buttonColor: const Color(0xFF1B1B1B),
                  onButtonClick: () async {}),
            ],
          ),
        ),
      ),
    ));
  }
}
