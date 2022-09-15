import 'package:agent_league/components/custom_selector.dart';
import 'package:agent_league/components/neu_circular_button.dart';
import 'package:agent_league/helper/shared_preferences.dart';
import 'package:agent_league/provider/firestore_data_provider.dart';
import 'package:agent_league/provider/property_upload_provider.dart';
import 'package:agent_league/route_generator.dart';
import 'package:agent_league/ui/Home/project.dart';
import 'package:agent_league/ui/sell_screens/realtor_card.dart';
import 'package:agent_league/ui/search_by.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import '../../components/custom_sell_card.dart';
import '../../components/custom_title.dart';
import '../../theme/colors.dart';
import '../saved.dart';

class SellScreen extends StatefulWidget {
  const SellScreen({Key? key}) : super(key: key);

  @override
  _SellScreenState createState() => _SellScreenState();
}

class _SellScreenState extends State<SellScreen> {
  var data1 = {
    {'img': 'sell_1', 'name': 'Lands'},
    {'img': 'sell_2', 'name': 'Offices'},
    {'img': 'sell_3', 'name': 'Plots'},
    {'img': 'sell_4', 'name': 'Flats'},
  };
  var data2 = {
    {'img': 'sell_5', 'name': 'Shops'},
    {'img': 'sell_6', 'name': 'Villas'},
    {'img': 'sell_7', 'name': 'Godowns'},
    {'img': 'sell_8', 'name': 'Rental'},
  };

  int counter = 0;
  List<String> profileImages = [];
  Map profileImagesSorted = {};
  String? _currentValue;
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
    List numberOfProperties = await FirestoreDataProvider().getPlots();
    int number = int.parse(numberOfProperties.length.toString());

    for (var i = 0; i < number; i++) {
      String plot = numberOfProperties[i] as String;
      var plotNumber = plot.substring(5);
      List detailsOfPages = await FirestoreDataProvider()
          .getPlotPagesInformation(int.parse(plotNumber));

      if (detailsOfPages.isEmpty || detailsOfPages[0]['isPaid'] == "false") {
        continue;
      }

      // String profilePicture = detailsOfPages[0]['plotProfilePicture'];
      // profileImagesSorted.putIfAbsent(i, () => profilePicture);
      // detailsOfPages.add({"plotNo": plotNumber});
      // detailsOfPages.add({"picture": profilePicture});

      plotPagesInformationOriginal.add(detailsOfPages);
    }
    setState(() {
      plotPagesInformation = plotPagesInformationOriginal;
      this.numberOfProperties = plotPagesInformation.length.toString();
      loading = false;
    });

    return plotPagesInformation;
  }

  filterPlotsBasedOnTypes(String type) {
    List filteredList = plotPagesInformationOriginal
        .where((element) => element[0]['propertyType'] == type)
        .toList();
    setState(() {
      plotPagesInformation = filteredList;
      numberOfProperties = plotPagesInformation.length.toString();
    });
  }

  sortPlotsBasedOnTypes(String type) {
    //price low to high
    if (type == "Price High - Low ") {
      plotPagesInformation.sort((a, b) =>
          int.parse(b[0]['price']).compareTo(int.parse(a[0]['price'])));
      setState(() {
        plotPagesInformation;
      });
    }
    // price high to low
    else if (type == "Price Low - High") {
      plotPagesInformation.sort((a, b) =>
          int.parse(a[0]['price']).compareTo(int.parse(b[0]['price'])));
      setState(() {
        // plotPagesInformation = plotPagesInformation.reversed.toList();
      });
    } else if (type == "Date - Recent First") {
      plotPagesInformation.sort((a, b) => DateTime.parse(a[0]['timestamp'])
          .compareTo(DateTime.parse(b[0]['timestamp'])));
      setState(() {
        // plotPagesInformation = plotPagesInformation.reversed.toList();
      });
    } else {
      plotPagesInformation.sort((a, b) => DateTime.parse(b[0]['timestamp'])
          .compareTo(DateTime.parse(a[0]['timestamp'])));
      setState(() {
        // plotPagesInformation = plotPagesInformation.reversed.toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: CustomColors.dark,
            elevation: 0,
            flexibleSpace: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TabBar(
                  unselectedLabelColor: HexColor("#b48484"),
                  indicatorSize: TabBarIndicatorSize.label,
                  labelStyle: const TextStyle(fontSize: 27),
                  indicator: MaterialIndicator(
                    height: 4,
                    bottomLeftRadius: 5,
                    bottomRightRadius: 5,
                    horizontalPadding: 5,
                    color: HexColor('FE7F0E'),
                  ),
                  tabs: const [
                    Tab(
                      child: Text(
                        "Standlone",
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Ventures",
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          body: TabBarView(
            children: [
              SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.fromLTRB(24, 16, 24, 16),
                  child: Column(
                    children: [
                      SizedBox(
                          height: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                child: CircularNeumorphicButton(
                                        imageName: 'img_2',
                                        padding: 0,
                                        color: HexColor('082640'),
                                        size: 50,
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, RouteName.listing);
                                        },
                                        isNeu: true,
                                        isTextUnder: true,
                                        text: 'Add')
                                    .use(),
                              ),
                              const SizedBox(width: 20),
                              Container(
                                child: CircularNeumorphicButton(
                                        imageName: 'save',
                                        size: 50,
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const Saved()));
                                        },
                                        color: HexColor('082640'),
                                        isNeu: true,
                                        isTextUnder: true,
                                        text: 'Saved')
                                    .use(),
                              ),
                            ],
                          )),
                      Container(
                        width: double.infinity,
                        height: 40,
                        decoration: BoxDecoration(
                            color: HexColor('#213c53'),
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Center(
                          child: TextField(
                            readOnly: true,
                            onTap: (loading)
                                ? () {}
                                : () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SeachBy(
                                            plotPagesInformation:
                                                plotPagesInformation))),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.all(8),
                                hintText: (loading)
                                    ? 'Loading your properties.. Please wait...'
                                    : 'Search by location, Name or ID',
                                suffixIcon: Image.asset(
                                    'assets/search_settings_icon.png')),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 16),
                        child: const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Choose property category",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                letterSpacing: -0.15,
                              ),
                            )),
                      ),
                      Row(
                        children: [
                          for (var element in data1)
                            Expanded(
                              child: SizedBox(
                                height: 100,
                                child: CircularNeumorphicButton(
                                        imageName: element['img'].toString(),
                                        size: 55,
                                        onTap: () {
                                          String name =
                                              element['name'].toString();
                                          var length = name.length;
                                          filterPlotsBasedOnTypes(
                                              name.substring(0, length - 1));
                                        },
                                        isTextUnder: true,
                                        text: element['name'].toString())
                                    .use(),
                              ),
                            ),
                        ],
                      ),
                      Row(
                        children: [
                          for (var element in data2)
                            Expanded(
                              child: SizedBox(
                                height: 100,
                                child: CircularNeumorphicButton(
                                        imageName: element['img'].toString(),
                                        size: 55,
                                        onTap: () {
                                          String name =
                                              element['name'].toString();
                                          var length = name.length;
                                          filterPlotsBasedOnTypes(
                                              name.substring(0, length - 1));
                                        },
                                        isTextUnder: true,
                                        text: element['name'].toString())
                                    .use(),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Row(
                        children: [
                          const Spacer(),
                          const SizedBox(width: 40),
                          const Text('Sort by',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  letterSpacing: -0.15)),
                          const SizedBox(width: 10),
                          Flexible(
                            child: SizedBox(
                              height: 40,
                              child: CustomSelector(
                                dropDownItems: [
                                  'Price Low - High',
                                  'Price High - Low ',
                                  'Date - Recent First',
                                  'Date - Recent Last'
                                ],
                                borderRadius: 10,
                                onChanged: (value) {
                                  setState(() {
                                    _currentValue = value;
                                  });
                                  sortPlotsBasedOnTypes(value);
                                },
                                chosenValue: _currentValue,
                                color: Colors.white,
                                textColor: Colors.black,
                              ).use(),
                            ),
                          ),
                        ],
                      ),
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
                                                "Please wait while we load your properties...")),
                                      ],
                                    ))),
                      ),
                      for (int i = 0; i < (plotPagesInformation.length); i++)
                        (!loading)
                            ? CustomSellCard(
                                imageUrl: plotPagesInformation[i][0]
                                    ['plotProfilePicture'],
                                category: plotPagesInformation[i][0]
                                    ['propertyCategory'],
                                propertyType: plotPagesInformation[i][0]
                                    ['propertyType'],
                                size: plotPagesInformation[i][0]['size'],
                                location: plotPagesInformation[i][0]
                                    ['location'],
                                price: plotPagesInformation[i][0]['price']
                                    .toString(),
                                possession: plotPagesInformation[i][0]
                                    ['possessionStatus'],
                                propertyId: "PR_" +
                                    plotPagesInformation[i][0]['plotNumber']
                                        .toString(),
                                onClick: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => RealtorCard(
                                                plotPagesInformation:
                                                    plotPagesInformation,
                                                currentPage: i,
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
              const Ventures(),
              // Icon(Icons.directions_transit),
            ],
          ),
        ));
  }
}

class Ventures extends StatefulWidget {
  const Ventures({Key? key}) : super(key: key);

  @override
  State<Ventures> createState() => _VenturesState();
}

class _VenturesState extends State<Ventures> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(children: [
            FutureBuilder<List<Map<String, dynamic>>>(
              initialData: const [],
              future: PropertyUploadProvider.getExportedProjects(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.isNotEmpty) {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data?.length ?? 0,
                        itemBuilder: (context, index) {
                          final currentItem = snapshot.data![index];

                          return Container(
                            margin: const EdgeInsets.only(bottom: 20),
                            child: Row(children: [
                              Expanded(
                                child: CustomImage(
                                  height: 220,
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, RouteName.projectExplorer,
                                        arguments: currentItem);
                                  },
                                  image: currentItem['images'][0],
                                ),
                              ),
                            ]),
                          );
                        },
                      ),
                    );
                  } else {
                    return const Center(
                        child: CustomTitle(text: 'No projects Available'));
                  }
                } else if (snapshot.hasError) {
                  return const Center(
                      child: CustomTitle(text: 'Somethng Went Wrong'));
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            )
          ]),
        ),
      ),
    );
  }
}

class CircleButton extends StatelessWidget {
  final GestureTapCallback onTap;
  final Image iconData;

  const CircleButton({Key? key, required this.onTap, required this.iconData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double size = 40.0;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        margin: const EdgeInsets.all(3),
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: iconData,
      ),
    );
  }
}
