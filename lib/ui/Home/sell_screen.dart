import 'package:agent_league/components/custom_container_text.dart';
import 'package:agent_league/components/custom_selector.dart';
import 'package:agent_league/components/neu_circular_button.dart';
import 'package:agent_league/helper/shared_preferences.dart';
import 'package:agent_league/provider/firestore_data_provider.dart';
import 'package:agent_league/ui/realtor_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import '../../Services/auth_methods.dart';
import '../../theme/colors.dart';

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
  String _currentValue = "one";
  String numberOfProperties = "No";
  bool loading = false;

  @override
  void initState() {
    setState(() {
      loading = true;
    });

    super.initState();
  }

  Future getPlotInformation(int index, String type) async {
    String? userId = await SharedPreferencesHelper().getUserId();
    List detailsOfPages =
        await FirestoreDataProvider().getPlotPagesInformation(index, type);
    if (detailsOfPages != []) {
      String profilePicture = await FirestoreDataProvider()
          .getProfileImage("sell_images/$userId/standlone/plot_$index/images/");
      profileImagesSorted.putIfAbsent(index, () => profilePicture);
      detailsOfPages.add({"picture": profilePicture});
      print(detailsOfPages);
    }
    return detailsOfPages;
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
            FutureBuilder(
                future: FirestoreDataProvider().getPlots(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData) {
                    List plots = snapshot.data;
                    numberOfProperties = plots.length.toString();
                    SharedPreferencesHelper()
                        .saveNumProperties(numberOfProperties);
                    return SingleChildScrollView(
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
                                                    context, '/post_page_one');
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
                                              onTap: () {},
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
                                  onChanged: (value) {},
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: const EdgeInsets.all(8),
                                      hintText:
                                          'Search by location, Name or ID',
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
                                              imageName:
                                                  element['img'].toString(),
                                              size: 55,
                                              onTap: () {},
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
                                              imageName:
                                                  element['img'].toString(),
                                              size: 55,
                                              onTap: () {},
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
                                      dropDownItems: ['one', 'two', 'three'],
                                      borderRadius: 10,
                                      onChanged: (value) {
                                        setState(() {
                                          _currentValue = value;
                                        });
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
                                  child: Text(
                                    "$numberOfProperties properties are available",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      letterSpacing: -0.15,
                                    ),
                                  )),
                            ),
                            for (var i = 1;
                                i <= int.parse(numberOfProperties);
                                i++)
                              FutureBuilder(
                                  future: getPlotInformation(i, "Farm"),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState !=
                                        ConnectionState.done) {
                                      return const SpinKitThreeBounce(
                                        size: 30,
                                        color: Colors.white,
                                      );
                                    }
                                    var category = "";
                                    var type = "";
                                    var area = "";
                                    var location = "";
                                    var price = "";
                                    var possession = "";
                                    var index = i;
                                    var profileImage = "";

                                    if (snapshot.hasData &&
                                        snapshot.data as List != []) {
                                      List data = snapshot.data as List;
                                      category = data[0]['propertyCategory'];
                                      type = data[0]['propertyType'];
                                      area = data[1]['carpet_area'];
                                      location = data[0]['location'];
                                      price = data[0]['price'];
                                      possession = data[0]['possessionStatus'];
                                      profileImage = data[3]['picture'];
                                    }
                                    return (snapshot.data as List != [])
                                        ? Neumorphic(
                                            style: NeumorphicStyle(
                                              shape: NeumorphicShape.flat,
                                              boxShape:
                                                  NeumorphicBoxShape.roundRect(
                                                      BorderRadius.circular(
                                                          17)),
                                              depth: 4,
                                            ),
                                            margin: const EdgeInsets.only(
                                                bottom: 10),
                                            child: Column(
                                              children: [
                                                GestureDetector(
                                                  onTap: () async {
                                                    print(profileImagesSorted);
                                                    final keysAsc =
                                                        profileImagesSorted.keys
                                                            .toList()
                                                          ..sort((a, b) =>
                                                              a.compareTo(b));
                                                    print(
                                                        "Keys are : $keysAsc");
                                                    for (final key in keysAsc) {
                                                      profileImages.add(
                                                          profileImagesSorted[
                                                              key]);
                                                    }
                                                    print(
                                                        "Profile Images are: ");
                                                    print(profileImages);
                                                    await SharedPreferencesHelper()
                                                        .saveCurrentPage(
                                                            (index - 1)
                                                                .toString());
                                                    await SharedPreferencesHelper()
                                                        .saveListOfCardImages(
                                                            profileImages);
                                                    print(
                                                        'Profile images is $profileImages');
                                                    Navigator.pushNamed(context,
                                                        '/realtor_card');
                                                  },
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        flex: 1,
                                                        child: Container(
                                                            height: 160,
                                                            decoration:
                                                                const BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        17.0),
                                                                topRight: Radius
                                                                    .circular(
                                                                        17.0),
                                                                bottomLeft:
                                                                    Radius.zero,
                                                                bottomRight:
                                                                    Radius.zero,
                                                              ),
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            child: Row(
                                                              children: [
                                                                Expanded(
                                                                    flex: 1,
                                                                    child:
                                                                        Container(
                                                                      width:
                                                                          100,
                                                                      height:
                                                                          170,
                                                                      // decoration:
                                                                      //     BoxDecoration(border: Border.all()),
                                                                      child: Image
                                                                          .network(
                                                                        profileImage,
                                                                        fit: BoxFit
                                                                            .fill,
                                                                      ),
                                                                    )),
                                                                Expanded(
                                                                  flex: 2,
                                                                  child: Container(
                                                                      width: 100,
                                                                      height: 170,
                                                                      padding: const EdgeInsets.all(8),
                                                                      // decoration:
                                                                      //     BoxDecoration(border: Border.all()),
                                                                      child: Align(
                                                                        alignment:
                                                                            Alignment.centerLeft,
                                                                        child:
                                                                            Column(
                                                                          children: [
                                                                            CustomContainerText(text1: 'Category', text2: category).use(),
                                                                            CustomContainerText(text1: 'Type', text2: type).use(),
                                                                            CustomContainerText(text1: 'Area', text2: area).use(),
                                                                            CustomContainerText(text1: 'Location', text2: location).use(),
                                                                            CustomContainerText(text1: 'Price', text2: price).use(),
                                                                            CustomContainerText(text1: 'Possession', text2: possession).use(),
                                                                          ],
                                                                        ),
                                                                      )),
                                                                ),
                                                              ],
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        : const SizedBox();
                                  }),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return const SpinKitThreeBounce(
                      size: 30,
                      color: Colors.white,
                    );
                  }
                }),
            const Icon(Icons.directions_transit),
            // Icon(Icons.directions_transit),
          ],
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
