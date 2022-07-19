import 'package:agent_league/components/custom_button.dart';
import 'package:agent_league/components/custom_title.dart';
import 'package:agent_league/helper/shared_preferences.dart';
import 'package:agent_league/provider/firestore_data_provider.dart';
import 'package:agent_league/route_generator.dart';
import 'package:agent_league/ui/Home/sell_screen.dart';
import 'package:agent_league/ui/emi.dart';
import 'package:agent_league/ui/gallery.dart';
import 'package:agent_league/ui/tour.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../theme/colors.dart';
import 'documents.dart';

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
  final List plotPagesInformation;

  const RealtorCard({Key? key, required this.plotPagesInformation})
      : super(key: key);

  @override
  State<RealtorCard> createState() => _RealtorCardState();
}

class _RealtorCardState extends State<RealtorCard> {
  late List pages = [];

  // var page = const RealtorPage();
  Color color = CustomColors.dark;
  String numberOfProperties = "0";

  @override
  void initState() {
    setState(() {
      plotPagesInformation = widget.plotPagesInformation;
    });
    print("information is $plotPagesInformation");
    Future.delayed(const Duration(seconds: 0), () {
      SharedPreferencesHelper().getUserId().then((value) {
        setState(() {
          userId = value!;
        });
      });
    });
    SharedPreferencesHelper().getCurrentPage().then((value) {
      setState(() {
        currentPage = int.parse(value!);
        currentPlotFromPreviousPage =
            plotPagesInformation[currentPage][0]['plotNumber'].toString();
      });
      SharedPreferencesHelper()
          .saveCurrentPage(currentPlotFromPreviousPage.toString());
      controller = PageController(initialPage: int.parse(value!));
    });
    Future.delayed(const Duration(seconds: 0), () {
      SharedPreferencesHelper().getNumProperties().then((value) {
        numberOfProperties = value.toString();
        return numberOfProperties;
      }).then((value) {
        for (var i = 0; i < int.parse(numberOfProperties); i++) {
          print(plotPagesInformation[i][0]['plotNumber'].toString());
          print(plotPagesInformation[i][0]['plotProfilePicture']);
          print(plotPagesInformation[i][0]['images']);
          print(plotPagesInformation[i][0]['videos']);
          setState(() {
            pages.add(RealtorPage(
              plotNumber: plotPagesInformation[i][0]['plotNumber'].toString(),
              profileImage: plotPagesInformation[i][0]['plotProfilePicture'],
            ));
          });
        }
      });
    });
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
                itemCount: int.parse(numberOfProperties),
                controller: controller,
                onPageChanged: (int page) async {
                  var currentPlotFromList =
                      plotPagesInformation[page][0]['plotNumber'];
                  SharedPreferencesHelper()
                      .saveCurrentPage(currentPlotFromList.toString());
                  setState(() {
                    currentPage = page;
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

class RealtorPage extends StatefulWidget {
  String profileImage;
  String plotNumber;

  RealtorPage({Key? key, required this.profileImage, required this.plotNumber})
      : super(key: key);

  @override
  State<RealtorPage> createState() => _RealtorPageState();
}

class _RealtorPageState extends State<RealtorPage> {
  @override
  void initState() {
    // controller?.addListener(() {
    //   var current = (controller?.page)!;
    //
    //   currentPage = current.toInt();
    //   profileImage =
    //       plotPagesInformation[currentPage + 1][0]['plotProfilePicture'];
    // });
    super.initState();
  }

  Future getProfileImages() async {
    var images = await SharedPreferencesHelper().getListOfCards();
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
      () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  GalleryScreen(images: plotPagesInformation))),
      () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Tour(videos: plotPagesInformation))),
      () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  Documents(documents: plotPagesInformation))),
      () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => EMI(price: plotPagesInformation))),
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
                      // FutureBuilder(
                      //     future: getProfileImages(),
                      //     builder: (context, snapshot) {
                      //       if (snapshot.hasData) {}
                      //       if (snapshot.connectionState !=
                      //           ConnectionState.done) {
                      //         return Container(
                      //           width: 200,
                      //           height: 200,
                      //           child: const SpinKitThreeBounce(
                      //             size: 30,
                      //             color: Colors.white,
                      //           ),
                      //         );
                      //       }
                      //
                      //       // List<String>? data = snapshot.data as List<String>?;

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
                                  print("delete plot $currPlot");
                                  await EasyLoading.show(
                                    status: 'Deleting.. please wait',
                                    maskType: EasyLoadingMaskType.black,
                                  );
                                  await FirestoreDataProvider()
                                      .deletePlot(int.parse(currPlot));
                                  await EasyLoading.showSuccess("Deleted");
                                  Navigator.pushNamedAndRemoveUntil(context,
                                      RouteName.bottomBar, (r) => false);
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
                                  List data = plotPagesInformation[currentPage];
                                  Map<String, dynamic> data1 = data[0];

                                  await SharedPreferencesHelper()
                                      .savePaidCreditStatus(
                                          plotPagesInformation[
                                              int.parse(currPlot.toString()) -
                                                  1][0]['isPaid'] == 'true');

                                  await EasyLoading.dismiss();
                                  Navigator.pop(context);
                                  print(currPlot);
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
