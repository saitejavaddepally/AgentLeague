import 'package:agent_league/components/custom_title.dart';
import 'package:agent_league/components/home_container.dart';
import 'package:agent_league/route_generator.dart';
import 'package:flutter/material.dart';

import '../components/custom_button.dart';
import '../helper/constants.dart';
import '../theme/colors.dart';

class Explore extends StatefulWidget {
  const Explore({Key? key}) : super(key: key);

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Container(
                    decoration: BoxDecoration(
                      boxShadow: shadow1,
                      shape: BoxShape.circle,
                      color: HexColor('F37F20'),
                    ),
                    child:
                        const Icon(Icons.arrow_back_ios_new_rounded, size: 20)),
              ),
            ),
            backgroundColor: CustomColors.dark,
            elevation: 0,
            flexibleSpace: Container(
              padding: const EdgeInsets.all(2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TabBar(
                    unselectedLabelColor: HexColor("#b48484"),
                    indicatorSize: TabBarIndicatorSize.label,
                    labelStyle: const TextStyle(fontSize: 27),
                    indicator: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: HexColor("#FE7F0E"),
                          width: 4,
                        ),
                      ),
                    ),
                    tabs: const [
                      Tab(
                        child: Text(
                          "For you",
                          style: TextStyle(
                              fontSize: 12.0, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Tab(
                        child: Text(
                          "For your customers",
                          style: TextStyle(
                              fontSize: 12.0, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          body: const TabBarView(children: [ForYou(), ForYourCustomers()]),
        ));
  }
}

class ForYou extends StatelessWidget {
  const ForYou({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomTitle(text: "Escrow Account :"),
            const SizedBox(height: 10),
            HomeContainer(
                text: "Don’t worry about your real estate commission any more.",
                isSecondText: true,
                text2:
                    'we help you to legalize your sale with an escrow account to guarantee your commission',
                image: "assets/rupee.png",
                containerColor: HexColor('D5FFFA'),
                buttonText: "What is Escrow",
                buttonWidth: 140,
                onButtonClick: () {
                  Navigator.pushNamed(context, RouteName.escrow);
                }),
            const SizedBox(height: 25),
            const CustomTitle(text: "Personal loan :"),
            const SizedBox(height: 10),
            HomeContainer(
                text: "Looing for an instant Personal loan upto INR 500000",
                isSecondText: true,
                text2:
                    'We are partnering with major fintech companies to fulfill your financial needs',
                image: "assets/apply_now.png",
                textColor: Colors.white,
                containerColor: HexColor('5F455B'),
                buttonText: "Apply Now",
                buttonWidth: 113,
                onButtonClick: () {})
          ],
        ),
      ),
    );
  }
}

class ForYourCustomers extends StatelessWidget {
  const ForYourCustomers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HomeContainer(
                text: "Verify property legality with our experts",
                isSecondText: true,
                text2:
                    'provide property legal check services to your customer in simple steps',
                textColor: Colors.white.withOpacity(0.8),
                image: 'assets/know_more.png',
                containerColor: HexColor('63567E'),
                buttonText: 'Know More',
                buttonColor: Colors.white,
                buttonTextColor: HexColor('1B1B1B'),
                buttonWidth: 116,
                onButtonClick: () {}),
            const SizedBox(height: 20),
            ExploreContainer(
                containerColor: HexColor('4A6170'),
                image: 'assets/how_it_works.png',
                text1:
                    'If your customers are looking for any property loans or Home loans ?',
                text2:
                    'Earn commission by providing loan services at your customer door step with our support',
                buttonText: 'How it Works',
                buttonWidth: 127,
                textColor: Colors.white,
                onButtonClick: () {
                  Navigator.pushNamed(context, RouteName.propertyLoan);
                }),
            const SizedBox(height: 20),
            ExploreContainer(
                containerColor: HexColor('EDBE88'),
                image: 'assets/book_now.png',
                text1:
                    'Get complete vasthu report for your Home before buying it.',
                text2:
                    'Our experts will provide vasthu consultancy for you customers at their doorstep',
                buttonText: 'Book Now',
                buttonWidth: 108,
                onButtonClick: () {
                  Navigator.pushNamed(context, RouteName.vasthu);
                }),
            const SizedBox(height: 20),
            ExploreContainer(
                containerColor: HexColor('BAD8B0'),
                image: 'assets/agent.png',
                text1:
                    'Is your customer looking for a property in different location and budget??',
                text2: 'We help you to find out that with other Agents.',
                buttonText: 'How it works',
                buttonWidth: 127,
                onButtonClick: () {}),
            const SizedBox(height: 20),
            ExploreContainer(
                containerColor: HexColor('#52B597'),
                image: 'assets/property_store.png',
                text1:
                    'Help your customer to chase right property bases on his buying capacity.',
                isSecondText: false,
                buttonText: 'Property Buying score',
                buttonWidth: 183,
                onButtonClick: () => Navigator.pushNamed(
                    context, RouteName.propertyBuyingScore)),
            const SizedBox(height: 20),
            HomeContainer(
                text:
                    'How much loan your customer can attorel to buy his dream home. Use our customized home loan calculator for EMI.',
                image: 'assets/emii.png',
                containerColor: HexColor('E4C8F5'),
                buttonText: 'Monthly EMI',
                buttonWidth: 121,
                onButtonClick: () {
                  Navigator.pushNamed(context, RouteName.monthlyEmi);
                })
          ],
        ),
      ),
    );
  }
}

class ExploreContainer extends StatelessWidget {
  final Color containerColor;
  final String image;
  final String text1;
  final String text2;
  final Color textColor;
  final String buttonText;
  final Color buttonTextColor;
  final Color buttonColor;
  final bool isSecondText;
  final void Function() onButtonClick;
  final double buttonWidth;
  const ExploreContainer(
      {required this.containerColor,
      required this.image,
      required this.text1,
      required this.buttonText,
      required this.onButtonClick,
      this.text2 = '',
      this.isSecondText = true,
      this.buttonTextColor = Colors.white,
      this.buttonColor = Colors.black,
      this.buttonWidth = 100,
      this.textColor = const Color(0xFF1B1B1B),
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var style = TextStyle(
        height: 1.5,
        fontWeight: FontWeight.w500,
        fontSize: 14,
        color: textColor.withOpacity(0.8));
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: shadow1,
      ),
      child: Column(
        children: [
          Image.asset(image),
          const SizedBox(height: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(text1, style: style),
              (isSecondText)
                  ? Column(
                      children: [
                        const SizedBox(height: 5),
                        Text(text2, style: style),
                      ],
                    )
                  : const SizedBox(),
              const SizedBox(height: 20),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Flexible(
                  child: CustomButton(
                          text: buttonText,
                          onClick: onButtonClick,
                          width: buttonWidth,
                          textColor: buttonTextColor,
                          height: 40,
                          color: buttonColor)
                      .use()),
            ],
          )
        ],
      ),
    );
  }
}
