import 'dart:convert';

import 'package:agent_league/components/custom_button.dart';
import 'package:agent_league/components/custom_title.dart';
import 'package:agent_league/helper/shared_preferences.dart';
import 'package:agent_league/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../provider/firestore_data_provider.dart';
import '../theme/colors.dart';

var currentPage = 0;
String userId = "";
String path = "";
String imageUrl = "";
bool loading = false;
PageController? controller;
late List profileImages = [];
bool isIncremented = false;
String profileImage = "";
late List plotPagesInformation = [];
late String currentPlotFromPreviousPage;

class RealtorCard extends StatefulWidget {
  List plotPagesInformation;

  RealtorCard({Key? key, required this.plotPagesInformation}) : super(key: key);

  @override
  State<RealtorCard> createState() => _RealtorCardState();
}

class _RealtorCardState extends State<RealtorCard> {
  late List pages = [];
  var page = const RealtorPage();
  Color color = CustomColors.dark;
  String numberOfProperties = "0";

  @override
  void initState() {
    setState(() {
      plotPagesInformation = widget.plotPagesInformation;
    });
    print("dude $plotPagesInformation");

    Future.delayed(const Duration(seconds: 0), () {
      SharedPreferencesHelper().getUserId().then((value) {
        setState(() {
          userId = value!;
        });
      });
    });
    SharedPreferencesHelper().getCurrentPage().then((value) {
      print("value is $value");

      setState(() {
        currentPage = int.parse(value!);
        currentPlotFromPreviousPage =
            plotPagesInformation[currentPage][1]['plotNo'].toString();
      });
      print("man $currentPlotFromPreviousPage");
      SharedPreferencesHelper()
          .saveCurrentPage(currentPlotFromPreviousPage.toString());
      print(profileImage);
      controller = PageController(initialPage: int.parse(value!));
    });
    print("User Id is  $userId");
    Future.delayed(const Duration(seconds: 0), () {
      SharedPreferencesHelper().getNumProperties().then((value) {
        numberOfProperties = value.toString();
        return numberOfProperties;
      }).then((value) {
        for (var i = 0; i < int.parse(numberOfProperties); i++) {
          setState(() {
            pages.add(const RealtorPage());
          });
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments;
    print("The arguments are : $arguments");
    return (numberOfProperties != "0")
        ? Scaffold(
            backgroundColor: color,
            body: SafeArea(
                child: Stack(children: [
              PageView.builder(
                itemCount: int.parse(numberOfProperties),
                controller: controller,
                onPageChanged: (int page) async {
                  print("I am here second? ");
                  var currentPlotFromList =
                      plotPagesInformation[page][1]['plotNo'];
                  SharedPreferencesHelper()
                      .saveCurrentPage(currentPlotFromList.toString());
                  setState(() {
                    currentPage = page;
                    path =
                        'sell_images/$userId/standlone/plot_${(currentPage) + 1}/images/';
                  });
                  SharedPreferencesHelper()
                      .getCurrentPage()
                      .then((value) => print("value is $value"));
                },
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return pages[index];
                },
              ),
            ])))
        : const Center(
            child: Text("No properties found"),
          );
  }
}

// const SpinKitThreeBounce(
// size: 30,
// color: Colors.white,
// );

class RealtorPage extends StatefulWidget {
  const RealtorPage({Key? key}) : super(key: key);

  @override
  State<RealtorPage> createState() => _RealtorPageState();
}

class _RealtorPageState extends State<RealtorPage> {
  @override
  void initState() {
    controller?.addListener(() {
      var current = (controller?.page)!;
      setState(() {
        currentPage = current.toInt();
        print("Now the current Page is : $currentPage");
      });
    });

    setState(() {
      profileImage =
          "sell_images/$userId/standlone/plot_${currentPage + 1}/images/";
    });

    print("Am I here? then");
    super.initState();
  }

  Future getProfileImages() async {
    var images = await SharedPreferencesHelper().getListOfCards();
    print("Images are: $images");
    return images;
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
      () => Navigator.pushNamed(context, '/location', arguments: currentPage),
      () {
        Navigator.pushNamed(context, RouteName.gallery);
      },
      () => Navigator.pushNamed(context, '/tour', arguments: currentPage),
      () => Navigator.pushNamed(context, '/documents', arguments: currentPage),
      () => Navigator.pushNamed(context, '/emi', arguments: currentPage),
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
                      FutureBuilder(
                          future: getProfileImages(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              print(snapshot.data);
                            }
                            if (snapshot.connectionState !=
                                ConnectionState.done) {
                              return Container(
                                width: 200,
                                height: 200,
                                child: const SpinKitThreeBounce(
                                  size: 30,
                                  color: Colors.white,
                                ),
                              );
                            }

                            // List<String>? data = snapshot.data as List<String>?;

                            return Container(
                              width: 200,
                              height: 200,
                              // decoration:
                              //     BoxDecoration(border: Border.all()),
                              child: Image.network(
                                plotPagesInformation[currentPage][2]['picture'],
                                fit: BoxFit.fill,
                              ),
                            );
                          }),
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
