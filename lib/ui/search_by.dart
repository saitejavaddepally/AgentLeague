import 'package:agent_league/components/custom_label.dart';
import 'package:agent_league/components/custom_selector.dart';
import 'package:agent_league/components/custom_text_field.dart';
import 'package:agent_league/ui/Home/bottom_navigation.dart';
import 'package:agent_league/ui/Home/sell_screen.dart';
import 'package:agent_league/ui/realtor_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../components/custom_button.dart';
import '../components/custom_container_text.dart';
import '../components/custom_title.dart';
import '../helper/shared_preferences.dart';
import '../theme/colors.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class SeachBy extends StatefulWidget {
  List plotPagesInformation;

  SeachBy({Key? key, required this.plotPagesInformation}) : super(key: key);

  @override
  State<SeachBy> createState() => _SeachByState();
}

List plotPageInformation = [];

class _SeachByState extends State<SeachBy> {
  @override
  void initState() {
    setState(() {
      plotPageInformation = widget.plotPagesInformation;
    });
    print("plot pages information is $plotPageInformation");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: SafeArea(
          child: Column(children: [
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(left: 25, right: 25),
              child: Row(
                children: [
                  GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.keyboard_backspace_rounded)),
                  const SizedBox(width: 20),
                  const Flexible(child: CustomTitle(text: 'Search By'))
                ],
              ),
            ),
            const SizedBox(height: 15),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4)),
              height: 56,
              child: TabBar(
                unselectedLabelColor: Colors.white.withOpacity(0.54),
                indicatorSize: TabBarIndicatorSize.label,
                labelStyle:
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
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
                      "Price",
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Location",
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                ],
              ),
            ),
            const Expanded(
                child: TabBarView(children: [Price(), SearchLocation()]))
          ]),
        ),
      ),
    );
  }
}

class SearchLocation extends StatelessWidget {
  const SearchLocation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 10.0, right: 25),
        child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          CustomButton(
            text: 'Reset',
            onClick: () {},
            color: HexColor('082640'),
            width: 89,
            height: 41,
          ).use(),
          const SizedBox(width: 20),
          CustomButton(
            text: 'Submit',
            onClick: () {
              print("Am I here? ");
              Navigator.pop(context);
            },
            color: HexColor('FD7E0E'),
            width: 102,
            height: 41,
          ).use(),
        ]),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15),
            const CustomLabel(text: 'Enter Location'),
            const SizedBox(height: 10),
            Row(
              children: [
                const Expanded(
                  flex: 3,
                  child: CustomTextField(
                    isDense: true,
                    borderradius: 4,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                      Flexible(
                        child: CustomSelector(
                                dropDownItems: [],
                                onChanged: (value) {},
                                isDense: true,
                                borderRadius: 4,
                                chosenValue: '')
                            .use(),
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 10, left: 7, right: 7),
                        decoration: BoxDecoration(
                            color: HexColor('FE7F0E'),
                            borderRadius: BorderRadius.circular(4)),
                        child: const Text('Km'),
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}



class Price extends StatefulWidget {
  const Price({Key? key}) : super(key: key);

  @override
  State<Price> createState() => _PriceState();
}

class _PriceState extends State<Price> {
  String? minimumValue;
  String? maximumValue;
  bool isSearched = false;
  late List info = [];
  late List searchResults = [];

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      info = plotPageInformation;
    });
    super.initState();
  }

  filterCards() {

    print(minimumValue);
    print(maximumValue);
    info = plotPageInformation
        .where((element) =>
            int.parse(element[0]['price']) > int.parse(minimumValue!) &&
            int.parse(element[0]['price']) < int.parse(maximumValue!))
        .toList();

    setState(() {
      info;
    });
    // searchResults.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 10.0, right: 25),
        child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          CustomButton(
            text: 'Reset',
            onClick: () {
              print(plotPageInformation);
              setState(() {});
            },
            color: HexColor('082640'),
            width: 89,
            height: 41,
          ).use(),
          const SizedBox(width: 20),
          CustomButton(
            text: 'Submit',
            onClick: () {
              filterCards();
              setState(() {
                isSearched = true;
              });
            },
            color: HexColor('FD7E0E'),
            width: 102,
            height: 41,
          ).use(),
        ]),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15),
            const CustomLabel(text: 'Minimum Price'),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Flexible(
                        child: CustomSelector(
                                dropDownItems: ['1', '100', '200', '300', '5000000'],
                                onChanged: (value) {
                                  setState(() {
                                    minimumValue = value;
                                  });
                                },
                                isDense: true,
                                borderRadius: 4,
                                chosenValue: minimumValue)
                            .use(),
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 10, left: 7, right: 7),
                        decoration: BoxDecoration(
                            color: HexColor('FE7F0E'),
                            borderRadius: BorderRadius.circular(4)),
                        child: const Text('Cr'),
                      )
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Row(
                    children: [
                      Flexible(
                        child: CustomSelector(
                                dropDownItems: ['100', '200'],
                                onChanged: (value) {},
                                isDense: true,
                                borderRadius: 4,
                                chosenValue: '100')
                            .use(),
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 10, left: 7, right: 7),
                        decoration: BoxDecoration(
                            color: HexColor('FE7F0E'),
                            borderRadius: BorderRadius.circular(4)),
                        child: const Text('Lakhs'),
                      )
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 15),
            const CustomLabel(text: 'Maximum Price'),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Flexible(
                        child: CustomSelector(
                                dropDownItems: ['100', '200', '300', '5000', '6000000'],
                                onChanged: (value) {
                                  setState(() {
                                    maximumValue = value.toString();
                                  });
                                },
                                isDense: true,
                                borderRadius: 4,
                                chosenValue: maximumValue)
                            .use(),
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 10, left: 7, right: 7),
                        decoration: BoxDecoration(
                            color: HexColor('FE7F0E'),
                            borderRadius: BorderRadius.circular(4)),
                        child: const Text('Cr'),
                      )
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Row(
                    children: [
                      Flexible(
                        child: CustomSelector(
                                dropDownItems: [],
                                onChanged: (value) {},
                                isDense: true,
                                borderRadius: 4,
                                chosenValue: '')
                            .use(),
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 10, left: 7, right: 7),
                        decoration: BoxDecoration(
                            color: HexColor('FE7F0E'),
                            borderRadius: BorderRadius.circular(4)),
                        child: const Text('Lakhs'),
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            (isSearched)
                ? Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: SingleChildScrollView(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        // height: 200,
                        child: Column(
                          children: [
                            for (var i = 0; i < (info.length); i++)
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Neumorphic(
                                  style: NeumorphicStyle(
                                    shape: NeumorphicShape.flat,
                                    boxShape: NeumorphicBoxShape.roundRect(
                                        BorderRadius.circular(17)),
                                    depth: 4,
                                  ),
                                  margin: const EdgeInsets.only(bottom: 10),
                                  child: Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () async {
                                          SharedPreferencesHelper()
                                              .saveCurrentPage(i.toString());
                                          SharedPreferencesHelper()
                                              .saveNumProperties(
                                                  info.length.toString());
                                          SharedPreferencesHelper()
                                              .saveListOfCards(info);
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      RealtorCard(
                                                          plotPagesInformation:
                                                              info)));
                                        },
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                  height: 180,
                                                  decoration: const BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(17.0),
                                                      topRight:
                                                          Radius.circular(17.0),
                                                      bottomLeft: Radius.zero,
                                                      bottomRight: Radius.zero,
                                                    ),
                                                    color: Colors.white,
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                            flex: 1,
                                                            child: Container(
                                                              width: 100,
                                                              height: 170,
                                                              // decoration:
                                                              //     BoxDecoration(border: Border.all()),
                                                              child: Image.network(
                                                                info[i][2]
                                                                    ['picture'],
                                                                fit: BoxFit.fill,
                                                              ),
                                                            )),
                                                        Expanded(
                                                          flex: 2,
                                                          child: Container(
                                                              width: 100,
                                                              height: 170,
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8),
                                                              // decoration:
                                                              //     BoxDecoration(border: Border.all()),
                                                              child: Align(
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                child: Column(
                                                                  children: [
                                                                    CustomContainerText(
                                                                            text1:
                                                                                'Category',
                                                                            text2: info[i][0]
                                                                                [
                                                                                'propertyCategory'])
                                                                        .use(),
                                                                    CustomContainerText(
                                                                            text1:
                                                                                'Type',
                                                                            text2: info[i][0]
                                                                                [
                                                                                'propertyType'])
                                                                        .use(),
                                                                    CustomContainerText(
                                                                            text1:
                                                                                'Area',
                                                                            text2: info[i][0]
                                                                                [
                                                                                'size'])
                                                                        .use(),
                                                                    CustomContainerText(
                                                                            text1:
                                                                                'Location',
                                                                            text2: info[i][0]
                                                                                [
                                                                                'location'])
                                                                        .use(),
                                                                    CustomContainerText(
                                                                            text1:
                                                                                'Price',
                                                                            text2: info[i][0]
                                                                                [
                                                                                'price'])
                                                                        .use(),
                                                                    CustomContainerText(
                                                                            text1:
                                                                                'Possession',
                                                                            text2: info[i][0]
                                                                                [
                                                                                'possessionStatus'])
                                                                        .use(),
                                                                  ],
                                                                ),
                                                              )),
                                                        ),
                                                      ],
                                                    ),
                                                  )),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  )
                : Text("Please enter values"),
          ],
        ),
      ),
    );
  }
}
