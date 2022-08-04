import 'dart:developer';

import 'package:agent_league/Services/firestore_crud_operations.dart';
import 'package:agent_league/components/custom_button.dart';
import 'package:agent_league/components/custom_title.dart';
import 'package:agent_league/helper/shared_preferences.dart';
import 'package:agent_league/provider/firestore_data_provider.dart';
import 'package:agent_league/route_generator.dart';
import 'package:agent_league/ui/Home/bottom_navigation.dart';
import 'package:agent_league/ui/emi.dart';
import 'package:agent_league/ui/gallery.dart';
import 'package:agent_league/ui/location.dart';
import 'package:agent_league/ui/tour.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../theme/colors.dart';
import 'documents.dart';

String userId = "";
PageController? controller;
late List plotPagesInformation = [];

class RealtorCard extends StatefulWidget {
  final List plotPagesInformation;
  final int currentPage;

  // final int numberOfProperties;

  const RealtorCard({
    Key? key,
    required this.plotPagesInformation,
    required this.currentPage,
  }) : super(key: key);

  @override
  State<RealtorCard> createState() => _RealtorCardState();
}

class _RealtorCardState extends State<RealtorCard> {
  late List pages = [];
  Color color = CustomColors.dark;

  @override
  void initState() {
    setState(() {
      plotPagesInformation = widget.plotPagesInformation;
    });
    Future.delayed(const Duration(seconds: 0), () {
      SharedPreferencesHelper().getUserId().then((value) {
        setState(() {
          userId = value!;
        });
      });
    });
    // SharedPreferencesHelper().getCurrentPage().then((value) {
    //   setState(() {
    //     currentPage = int.parse(value!);
    //   });
    controller = PageController(initialPage: widget.currentPage);
    // });

    for (var i = 0; i < plotPagesInformation.length; i++) {
      setState(() {
        pages.add(RealtorPage(
          plotNumber: plotPagesInformation[i][0]['plotNumber'].toString(),
          profileImage: plotPagesInformation[i][0]['plotProfilePicture'],
          currentPage: i,
        ));
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (numberOfProperties != "0")
        ? Scaffold(
            backgroundColor: color,
            body: SafeArea(
                child: Stack(children: [
              PageView.builder(
                itemCount: plotPagesInformation.length,
                controller: controller,
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

class RealtorPage extends StatefulWidget {
  final String profileImage;
  final String plotNumber;
  final int currentPage;

  const RealtorPage(
      {Key? key,
      required this.profileImage,
      required this.currentPage,
      required this.plotNumber})
      : super(key: key);

  @override
  State<RealtorPage> createState() => _RealtorPageState();
}

class _RealtorPageState extends State<RealtorPage> {
  @override
  void initState() {
    // print("current page is " + widget.currentPage.toString());
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
      () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  LocationScreen(currentPage: widget.currentPage))),
      () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => GalleryScreen(info: {
                    "currentPage": widget.currentPage,
                    "plotPagesInformation": plotPagesInformation
                  }))),
      () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Tour(info: {
                    "currentPage": widget.currentPage,
                    "plotPagesInformation": plotPagesInformation
                  }))),
      () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Documents(info: {
                    "currentPage": widget.currentPage,
                    "plotPagesInformation": plotPagesInformation
                  }))),
      () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => EMI(info: {
                    "currentPage": widget.currentPage,
                    "plotPagesInformation": plotPagesInformation
                  }))),
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
                      Container(
                        width: 200,
                        height: 200,
                        // decoration:
                        //     BoxDecoration(border: Border.all()),
                        child: Image.network(
                          widget.profileImage,
                          fit: BoxFit.fill,
                        ),
                      ),
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
                    onClick: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text(
                                "Are you sure you want to delete this property"),
                            actions: [
                              TextButton(
                                onPressed: () async {
                                  var currPlot = widget.plotNumber;
                                  await EasyLoading.show(
                                    status: 'Deleting.. please wait',
                                    maskType: EasyLoadingMaskType.black,
                                  );
                                  await FirestoreDataProvider()
                                      .deletePlot(int.parse(currPlot));
                                  await EasyLoading.showSuccess("Deleted");
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => BottomBar(
                                              index: 0,
                                            )),
                                    (route) => false,
                                  );
                                },
                                child: const Text("Yes"),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("No"),
                              )
                            ],
                          );
                        },
                      );
                    },
                    height: 40,
                    width: 40,
                    isIcon: true,
                    rounded: true,
                    color: Colors.white)
                .use(),
            const SizedBox(width: 12),
            CustomButton(
                    text: 'edit',
                    onClick: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text(
                                "Are you sure to edit this property"),
                            actions: [
                              TextButton(
                                onPressed: () async {
                                  List<dynamic> images =
                                      List.generate(8, (index) => null);
                                  List<dynamic> videos =
                                      List.generate(4, (index) => null);
                                  List<dynamic> videoNames =
                                      List.generate(4, (index) => null);
                                  List<dynamic> docs =
                                      List.generate(4, (index) => null);
                                  List<dynamic> docNames =
                                      List.generate(4, (index) => null);

                                  await EasyLoading.show(
                                    status: 'Loading data....',
                                    maskType: EasyLoadingMaskType.black,
                                  );
                                  var currPlot = widget.plotNumber;
                                  List plotImages = plotPagesInformation[
                                          int.parse(currPlot.toString()) - 1][0]
                                      ['images'];
                                  for (var i = 0; i < plotImages.length; i++) {
                                    images[i] = plotImages[i];
                                  }
                                  List plotVideos = plotPagesInformation[
                                          int.parse(currPlot.toString()) - 1][0]
                                      ['videos'];
                                  for (var i = 0; i < plotVideos.length; i++) {
                                    videos[i] = plotVideos[i];
                                  }
                                  List plotVideoNames = plotPagesInformation[
                                          int.parse(currPlot.toString()) - 1][0]
                                      ['videoNames'];
                                  for (var i = 0;
                                      i < plotVideoNames.length;
                                      i++) {
                                    videoNames[i] = plotVideoNames[i];
                                  }
                                  List plotDocs = plotPagesInformation[
                                          int.parse(currPlot.toString()) - 1][0]
                                      ['docs'];
                                  for (var i = 0; i < plotDocs.length; i++) {
                                    docs[i] = plotDocs[i];
                                  }
                                  List plotDocNames = plotPagesInformation[
                                          int.parse(currPlot.toString()) - 1][0]
                                      ['docNames'];
                                  for (var i = 0;
                                      i < plotDocNames.length;
                                      i++) {
                                    docNames[i] = plotDocNames[i];
                                  }
                                  List data =
                                      plotPagesInformation[widget.currentPage];
                                  Map<String, dynamic> data1 = data[0];

                                  log("dxdiag" +
                                      videoNames.toString() +
                                      docNames.toString());

                                  await SharedPreferencesHelper()
                                      .savePaidCreditStatus(
                                          plotPagesInformation[int.parse(
                                                      currPlot.toString()) -
                                                  1][0]['isPaid'] ==
                                              'true');

                                  await EasyLoading.dismiss();
                                  Navigator.pop(context);
                                  Navigator.pushReplacementNamed(context,
                                      RouteName.postYourPropertyPageOne,
                                      arguments: data1
                                        ..addAll({
                                          'images': images,
                                          'previousDocNames': docNames,
                                          'previousVideoNames': videoNames,
                                          'videos': videos,
                                          'docs': docs,
                                          'plotNo': currPlot,
                                          'isEdited': true,
                                        }));
                                },
                                child: const Text("Yes"),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("No"),
                              )
                            ],
                          );
                        },
                      );
                    },
                    height: 40,
                    width: 40,
                    isIcon: true,
                    rounded: true,
                    color: Colors.white)
                .use(),
            const SizedBox(width: 12),
            GestureDetector(
                onTap: () {
                  var data = plotPagesInformation[widget.currentPage][0]
                      ['box_enabled'];
                  (data == 0)
                      ? showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: const Text(
                                    "Are you sure you want to upload this property to property box"),
                                actions: [
                                  TextButton(
                                      onPressed: () async {
                                        var currPlot = plotPagesInformation[
                                                    widget.currentPage][0]
                                                ['plotNumber']
                                            .toString();
                                        log("plot no is $currPlot");
                                        await EasyLoading.show(
                                            status: "Please wait...");
                                        Navigator.pop(context);

                                        await FirestoreCrudOperations()
                                            .updatePlotInformation(
                                                int.parse(currPlot), {
                                          "box_enabled": 1,
                                        });
                                        await EasyLoading.showSuccess(
                                            "Property Added to property box",
                                            duration:
                                                const Duration(seconds: 3));

                                        EasyLoading.dismiss();
                                        plotPagesInformation[widget.currentPage]
                                            [0]['box_enabled'] = 1;
                                      },
                                      child: const Text('Yes')),
                                  TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('No'))
                                ],
                              ))
                      : EasyLoading.showToast(
                          "Property Already Added to Property Box");
                },
                child: Image.asset('assets/property.png')),
            const Spacer(),
            GestureDetector(
              onTap: () {
                var currPlot = widget.plotNumber;
                final docId = plotPagesInformation[int.parse(currPlot) - 1][0]
                    ['documentId'];
                Navigator.pushNamed(context, RouteName.leadsBox,
                    arguments: docId);
              },
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
