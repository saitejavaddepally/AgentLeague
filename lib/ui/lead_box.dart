import 'package:agent_league/components/custom_container_text.dart';
import 'package:agent_league/components/custom_selector.dart';
import 'package:agent_league/theme/colors.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class LeadBox extends StatefulWidget {
  const LeadBox({Key? key}) : super(key: key);

  @override
  _LeadBoxState createState() => _LeadBoxState();
}

class _LeadBoxState extends State<LeadBox> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: CustomColors.dark,
          leading: IconButton(
            padding: const EdgeInsets.only(left: 16),
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
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
        ),
        body: TabBarView(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(24, 16, 24, 16),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          flex: 1,
                          child: Container(
                              //child: CustomSelector().use(),
                              ))
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // const Expanded(
                        //   flex: 1,
                        //   child: SizedBox(
                        //     width: 100,
                        //     height: 70,
                        //     // decoration: BoxDecoration(border: Border.all()),
                        //     child: Align(
                        //       alignment: Alignment.centerLeft,
                        //       child: Text(
                        //         "Date : ",
                        //         style: TextStyle(fontSize: 13),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        Expanded(
                          flex: 1,
                          child: SizedBox(
                            width: 100,
                            height: 70,
                            // decoration: BoxDecoration(border: Border.all()),
                            child: Container(
                              margin: const EdgeInsets.fromLTRB(2, 8, 2, 8),
                              // child: CustomSelector(
                              //         color: Colors.white,
                              //         textColor: Colors.black,
                              //         dim: false,
                              //         hint: 'Date')
                              //     .use(),
                            ),
                          ),
                        ),
                        // const Expanded(
                        //   flex: 2,
                        //   child: SizedBox(
                        //     width: 100,
                        //     height: 70,
                        //     // decoration: BoxDecoration(border: Border.all()),
                        //     child: Align(
                        //       alignment: Alignment.centerRight,
                        //       child: Text("Status : "),
                        //     ),
                        //   ),
                        // ),
                        Expanded(
                          flex: 1,
                          child: SizedBox(
                            width: 100,
                            height: 70,
                            // decoration: BoxDecoration(border: Border.all()),
                            child: Container(
                              margin: const EdgeInsets.fromLTRB(2, 8, 2, 8),
                              // child: CustomSelector(
                              //         color: Colors.white,
                              //         textColor: Colors.black,
                              //         dim: false,
                              //         hint: 'Status')
                              //     .use(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 16),
                    child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "165 leads are interested",
                          style: TextStyle(fontSize: 22),
                        )),
                  ),
                  Container(
                    child: Neumorphic(
                      style: NeumorphicStyle(
                        shape: NeumorphicShape.flat,
                        boxShape: NeumorphicBoxShape.roundRect(
                            BorderRadius.circular(17)),
                        depth: 4,
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                    height: 220,
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
                                          child: Container(
                                            margin: const EdgeInsets.all(8),
                                            padding: const EdgeInsets.all(8),
                                            // decoration:
                                            //     BoxDecoration(border: Border.all()),
                                            child: Image.asset(
                                                "assets/lead_box_image.png"),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                              padding: const EdgeInsets.all(8),
                                              margin: const EdgeInsets.fromLTRB(
                                                  0, 18, 0, 18),
                                              // decoration:
                                              //     BoxDecoration(border: Border.all()),
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Column(
                                                  children: [
                                                    CustomContainerText(
                                                            text1: 'Name',
                                                            text2: 'Venkat')
                                                        .use(),
                                                    CustomContainerText(
                                                            text1: 'Contact',
                                                            text2: '7416698106')
                                                        .use(),
                                                    CustomContainerText(
                                                            text1: 'Location',
                                                            text2: 'LB Nagar')
                                                        .use(),
                                                    CustomContainerText(
                                                            text1: 'Profession',
                                                            text2: 'Business')
                                                        .use(),
                                                    CustomContainerText(
                                                            text1:
                                                                'Buying time ',
                                                            text2: '1 month')
                                                        .use(),
                                                    CustomContainerText(
                                                            text1:
                                                                'Property ID',
                                                            text2: 'PR1214')
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
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                    height: 50,
                                    padding:
                                        const EdgeInsets.fromLTRB(12, 0, 12, 0),
                                    decoration: BoxDecoration(
                                      color: HexColor('#203b53'),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.zero,
                                        topRight: Radius.zero,
                                        bottomLeft: Radius.circular(17.0),
                                        bottomRight: Radius.circular(17.0),
                                      ),
                                      // border: Border.all()
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 3,
                                          child: Container(
                                            width: 100,
                                            height: 40,
                                            // decoration:
                                            //     BoxDecoration(border: Border.all()),
                                            child: const Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  "Notes",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20),
                                                )),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Container(
                                            height: 40,
                                            //
                                            // decoration:
                                            //     BoxDecoration(border: Border.all()),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(3.0),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: CircleButton(
                                                        onTap: () {},
                                                        iconData: Image.asset(
                                                          'assets/chat.png',
                                                        )),
                                                  ),
                                                  Expanded(
                                                    child: CircleButton(
                                                        onTap: () => {},
                                                        iconData: Image.asset(
                                                          'assets/call.png',
                                                        )),
                                                  ),
                                                  Expanded(
                                                    child: CircleButton(
                                                        onTap: () => {},
                                                        iconData: Image.asset(
                                                          'assets/social.png',
                                                        )),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
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
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: iconData,
      ),
    );
  }
}
