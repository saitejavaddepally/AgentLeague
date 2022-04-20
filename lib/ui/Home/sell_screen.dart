import 'package:agent_league/components/custom_container_text.dart';
import 'package:agent_league/components/custom_selector.dart';
import 'package:agent_league/components/neu_circular_button.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

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

  String _currentValue = "one";

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
                  color: Colors.lightGreen,
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
                    Container(
                        height: 100,
                        child: Row(
                          children: [
                            Expanded(flex: 1, child: Container()),
                            Expanded(
                                flex: 1,
                                child: Row(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(left: 58.7),
                                      child: CircularNeumorphicButton(
                                              imageName: 'img_2',
                                              padding: 0,
                                              size: 50,
                                              onTap: () {
                                                Navigator.pushNamed(
                                                    context, '/post_page_one');
                                              },
                                              isNeu: false,
                                              isTextUnder: true,
                                              text: 'Add')
                                          .use(),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(left: 7),
                                      child: CircularNeumorphicButton(
                                              imageName: 'save',
                                              size: 50,
                                              onTap: () {},
                                              isNeu: false,
                                              isTextUnder: true,
                                              text: 'Saved')
                                          .use(),
                                    ),
                                  ],
                                )),
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
                              hintText: 'Search by location, Name or ID',
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
                            "Choose Property",
                            style: TextStyle(fontSize: 22),
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
                                      imageName: element['img'].toString(),
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
                        Expanded(
                          flex: 2,
                          child: Container(
                            height: 50,
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 50,
                            child: CustomSelector(
                              dropDownItems: ['one', 'two', 'three'],
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
                      child: const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "25 properties are available",
                            style: TextStyle(fontSize: 22),
                          )),
                    ),
                    Neumorphic(
                      style: NeumorphicStyle(
                        shape: NeumorphicShape.flat,
                        boxShape: NeumorphicBoxShape.roundRect(
                            BorderRadius.circular(17)),
                        depth: 4,
                      ),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () =>
                                Navigator.pushNamed(context, '/realtor_card'),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                      height: 160,
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(17.0),
                                          topRight: Radius.circular(17.0),
                                          bottomLeft: Radius.zero,
                                          bottomRight: Radius.zero,
                                        ),
                                        color: Colors.white,
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              width: 100,
                                              height: 170,
                                              // decoration:
                                              //     BoxDecoration(border: Border.all()),
                                              child: Image.asset(
                                                  "assets/sell_image.png"),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Container(
                                                width: 100,
                                                height: 170,
                                                padding:
                                                    const EdgeInsets.all(8),
                                                // decoration:
                                                //     BoxDecoration(border: Border.all()),
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Column(
                                                    children: [
                                                      CustomContainerText(
                                                              text1: 'Category',
                                                              text2:
                                                                  'Residential')
                                                          .use(),
                                                      CustomContainerText(
                                                              text1: 'Type',
                                                              text2: 'Villa')
                                                          .use(),
                                                      CustomContainerText(
                                                              text1: 'Area',
                                                              text2:
                                                                  '300 sq.yds')
                                                          .use(),
                                                      CustomContainerText(
                                                              text1: 'Location',
                                                              text2:
                                                                  'Tarnaka, Hyd')
                                                          .use(),
                                                      CustomContainerText(
                                                              text1: 'Price',
                                                              text2:
                                                                  '30000000 INR')
                                                          .use(),
                                                      CustomContainerText(
                                                              text1:
                                                                  'Possession',
                                                              text2:
                                                                  'ready to move')
                                                          .use(),
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
                    ),
                  ],
                ),
              ),
            ),
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
