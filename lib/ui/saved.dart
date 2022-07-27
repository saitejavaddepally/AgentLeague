import 'package:agent_league/theme/colors.dart';
import 'package:agent_league/ui/property_digitalization.dart';
import 'package:agent_league/ui/realtor_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../components/custom_sell_card.dart';
import '../helper/shared_preferences.dart';
import '../provider/firestore_data_provider.dart';

class Saved extends StatefulWidget {
  const Saved({Key? key}) : super(key: key);

  @override
  State<Saved> createState() => _SavedState();
}

class _SavedState extends State<Saved> {
  int counter = 0;
  List<String> profileImages = [];
  Map profileImagesSorted = {};
  String numberOfProperties = "Loading .. ";
  bool loading = false;
  List plotPagesInformationOriginal = [];
  List plotPagesInformation = [];

  @override
  void initState() {
    super.initState();
    getPlotInformation();
  }

  Future getPlotInformation() async {
    setState(() {
      loading = true;
    });
    String? userId = await SharedPreferencesHelper().getUserId();
    List numberOfProperties = await FirestoreDataProvider().getPlots();
    int number = int.parse(numberOfProperties.length.toString());

    for (var i = 0; i < number; i++) {
      String plot = numberOfProperties[i] as String;
      var plotNumber = plot.substring(5);
      print("the plot is $plotNumber");
      List detailsOfPages = await FirestoreDataProvider()
          .getPlotPagesInformation(int.parse(plotNumber));
      print(detailsOfPages);
      if (detailsOfPages.isEmpty || detailsOfPages[0]['isPaid'] == "true") {
        continue;
      }

      String profilePicture = await FirestoreDataProvider().getProfileImage(
          "sell_images/$userId/standlone/plot_$plotNumber/images/");
      profileImagesSorted.putIfAbsent(i, () => profilePicture);
      detailsOfPages.add({"plotNo": plotNumber});
      detailsOfPages.add({"picture": profilePicture});
      plotPagesInformationOriginal.add(detailsOfPages);
    }
    setState(() {
      plotPagesInformation = plotPagesInformationOriginal;
      this.numberOfProperties = plotPagesInformation.length.toString();
      loading = false;
    });

    return plotPagesInformation;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.dark,
        elevation: 0,
      ),
      backgroundColor: CustomColors.dark,
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.fromLTRB(24, 16, 24, 16),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 16),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: (!loading)
                        ? Text(
                            "$numberOfProperties properties are available",
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              letterSpacing: -0.15,
                            ),
                          )
                        : Container(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: const [
                                SpinKitCircle(
                                  color: Colors.white,
                                  size: 30,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Center(
                                    child: Text(
                                        "Please wait while we load saved properties...")),
                              ],
                            ))),
              ),
              for (var i = 0; i < (plotPagesInformation.length); i++)
                (!loading)
                    ? CustomSellCard(
                        imageUrl: plotPagesInformation[i][2]['picture'],
                        category: plotPagesInformation[i][0]
                            ['propertyCategory'],
                        propertyType: plotPagesInformation[i][0]
                            ['propertyType'],
                        size: plotPagesInformation[i][0]['size'],
                        location: plotPagesInformation[i][0]['location'],
                        price: plotPagesInformation[i][0]['price'],
                  propertyId: "PR_" + plotPagesInformation[i][0]['plotNumber'],

                  possession: plotPagesInformation[i][0]
                            ['possessionStatus'],
                        onClick: () async {
                          await SharedPreferencesHelper().saveCurrentPlot(
                              'plot_${plotPagesInformation[i][1]['plotNo']}');
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PropertyDigitalization(
                                        formData: {
                                          "picture": "hello",
                                          "propData": plotPagesInformation[i]
                                              [0],
                                          "media": {
                                            'picture': plotPagesInformation[i]
                                                [2]['picture']
                                          }
                                        },
                                      )));
                        },
                      )
                    : SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 100,
                        child: const Center(
                          child: Text("Loading your properties..."),
                        )),
            ],
          ),
        ),
      ),
    );
  }
}
