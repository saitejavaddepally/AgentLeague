import 'package:agent_league/components/custom_button.dart';
import 'package:agent_league/components/custom_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

import '../theme/colors.dart';

class RealtorCard extends StatefulWidget {
  const RealtorCard({Key? key}) : super(key: key);

  @override
  State<RealtorCard> createState() => _RealtorCardState();
}

class _RealtorCardState extends State<RealtorCard> {
  List pages = [const RealtorPage(), const RealtorPage()];
  Color color = CustomColors.dark;

  @override
  void initState() {
    _updateState();
    super.initState();
  }

  void _updateState() {
    final style = SystemUiOverlayStyle(
      systemNavigationBarColor: CustomColors.dark,
      systemNavigationBarIconBrightness: Brightness.light,
    );
    SystemChrome.setSystemUIOverlayStyle(style);
  }

  // @override
  // void dispose() {
  //   var brightness = SchedulerBinding.instance!.window.platformBrightness;
  //   bool isDarkMode = brightness == Brightness.dark;
  //   print(isDarkMode);
  //   SystemUiOverlayStyle value =
  //       (!isDarkMode) ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light;
  //   SystemChrome.setSystemUIOverlayStyle(value);
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: color,
        body: SafeArea(
            child: Stack(children: [
          PageView.builder(
            itemCount: 2,
            onPageChanged: (int page) {
              setState(() {
                // color = colorList[page];
              });
            },
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return pages[index];
            },
          ),
        ])));
  }
}

class RealtorPage extends StatefulWidget {
  const RealtorPage({Key? key}) : super(key: key);

  @override
  State<RealtorPage> createState() => _RealtorPageState();
}

class _RealtorPageState extends State<RealtorPage> {
  @override
  void initState() {
    final style = SystemUiOverlayStyle(
      systemNavigationBarColor: CustomColors.dark,
      systemNavigationBarIconBrightness: Brightness.light,
    );
    SystemChrome.setSystemUIOverlayStyle(style);
    super.initState();
  }

  var textList = [
    '20% Construction & 80% space',
    'Total 750 flat in 3 towers',
    'Exclusive club house',
    'Just 2kms distance to ORR',
    'Golf track and playground'
  ];

  var iconMap = {
    'location': 'assets/location.png',
    'gallery': 'assets/img_preview.png',
    'tour': 'assets/compass.png',
    'documents': 'assets/documents.png',
    'eml': 'assets/credit_card.png'
  };

  @override
  Widget build(BuildContext context) {
    var iconFunctionalities = [
      () => Navigator.pushNamed(context, '/location'),
      () => Navigator.pushNamed(context, '/gallery'),
      () => Navigator.pushNamed(context, '/tour'),
      () => Navigator.pushNamed(context, '/documents'),
      () => Navigator.pushNamed(context, '/emi'),
    ];
    return Stack(children: [
      Column(children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.keyboard_backspace_sharp),
              ),
              IconButton(
                  onPressed: () {}, icon: const Icon(Icons.share_outlined)),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        LayoutBuilder(
          builder: (context, constraints) => Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(left: 30),
                width: constraints.maxWidth * 0.7,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset("assets/card.png"),
                      const SizedBox(height: 20),
                      const CustomTitle(text: 'Property Highlights'),
                      const SizedBox(height: 20),
                      for (final text in textList)
                        Column(children: [
                          TextWithIndicator(text: text),
                          const SizedBox(height: 10)
                        ]),
                    ]),
              ),
              SizedBox(
                width: constraints.maxWidth * 0.3,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      for (int i = 0; i < iconMap.length; i++)
                        GestureDetector(
                          onTap: iconFunctionalities[i],
                          child: IconWithText(
                              text: iconMap.keys.toList()[i],
                              image: iconMap.values.toList()[i]),
                        )
                    ]),
              ),
            ],
          ),
        )
      ]),
      Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30, bottom: 15),
          child: Row(children: [
            CustomButton(
                    text: 'trash',
                    onClick: () {},
                    height: 40,
                    width: 40,
                    isIcon: true,
                    rounded: true,
                    color: Colors.white)
                .use(),
            const SizedBox(width: 12),
            CustomButton(
                    text: 'edit',
                    onClick: () {},
                    height: 40,
                    width: 40,
                    isIcon: true,
                    rounded: true,
                    color: Colors.white)
                .use(),
            const SizedBox(width: 12),
            Image.asset('assets/property.png'),
            const Spacer(),
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, '/leads_box'),
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.orange)),
                child: Image.asset('assets/leadsBox.png'),
              ),
            ),
          ]),
        ),
      ),
    ]);
  }
}

class IconWithText extends StatelessWidget {
  final String text;
  final String image;

  const IconWithText({required this.text, required this.image, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        height: 45,
        width: 45,
        decoration: BoxDecoration(
            shape: BoxShape.circle, color: Colors.white.withOpacity(0.2)),
        child: Image.asset(image),
      ),
      const SizedBox(height: 5),
      Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
            fontWeight: FontWeight.w500, fontSize: 12, letterSpacing: -0.15),
      ),
      const SizedBox(height: 15),
    ]);
  }
}

class TextWithIndicator extends StatelessWidget {
  final String text;

  const TextWithIndicator({required this.text, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Icon(Icons.circle_sharp, size: 7, color: Colors.white.withOpacity(0.7)),
      const SizedBox(width: 10),
      Text(text,
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: Colors.white.withOpacity(0.7))),
    ]);
  }
}
