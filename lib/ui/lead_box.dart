import 'package:agent_league/theme/colors.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

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
                  indicator: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: HexColor("FE7F0E"),
                        width: 4,
                      ),
                    ),
                    // borderRadius: BorderRadius.circular(12.0)
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
            Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        flex: 1,
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(24, 16, 24, 16),
                          child: CustomSelector().use(),
                        ))
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Expanded(
                        flex: 1,
                        child: SizedBox(
                          width: 100,
                          height: 70,
                          // decoration: BoxDecoration(border: Border.all()),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Date : ",
                              style: TextStyle(fontSize: 13),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: SizedBox(
                          width: 100,
                          height: 70,
                          // decoration: BoxDecoration(border: Border.all()),
                          child: Container(
                            margin: const EdgeInsets.fromLTRB(2, 8, 2, 8),
                            child: CustomSelector(color: Colors.white).use(),
                          ),
                        ),
                      ),
                      const Expanded(
                        flex: 2,
                        child: SizedBox(
                          width: 100,
                          height: 70,
                          // decoration: BoxDecoration(border: Border.all()),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text("Status : "),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: SizedBox(
                          width: 100,
                          height: 70,
                          // decoration: BoxDecoration(border: Border.all()),
                          child: Container(
                            margin: const EdgeInsets.fromLTRB(2, 8, 2, 8),
                            child: CustomSelector(color: Colors.white).use(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(24, 24, 24, 12),
                  child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "165 leads are interested",
                        style: TextStyle(fontSize: 22),
                      )),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(24, 12, 24, 0),
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
                              flex: 1,
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
                                        flex: 2,
                                        child: Container(
                                          width: 100,
                                          height: 170,
                                          // decoration:
                                          //     BoxDecoration(border: Border.all()),
                                          child: Image.asset(
                                              "assets/lead_box_image.png"),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                            width: 100,
                                            height: 180,
                                            padding: const EdgeInsets.all(8),
                                            // decoration:
                                            //     BoxDecoration(border: Border.all()),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Column(
                                                children: const [
                                                  Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                          "Name: Venkat",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 13))),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                          "Contact : 7416698106",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 13))),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                          "Location : LB Nagar",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 13))),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                          "Profession : Business",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 13))),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                          "Buying time : 1 month",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 13))),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                          "Property ID : PR1214",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 13))),
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
                                  margin:
                                      const EdgeInsets.fromLTRB(12, 0, 12, 0),
                                  padding:
                                      const EdgeInsets.fromLTRB(12, 0, 12, 0),
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
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
                                        flex: 1,
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
                                        flex: 1,
                                        child: Container(
                                          height: 40,
                                          padding:
                                              const EdgeInsets.only(left: 22),
                                          // decoration:
                                          //     BoxDecoration(border: Border.all()),
                                          child: Row(
                                            children: [
                                              Positioned(
                                                child: CircleButton(
                                                    onTap: () {},
                                                    iconData: Image.asset(
                                                      'assets/chat.png',
                                                    )),
                                                top: 10.0,
                                                left: 130.0,
                                              ),
                                              Positioned(
                                                child: CircleButton(
                                                    onTap: () => {},
                                                    iconData: Image.asset(
                                                      'assets/call.png',
                                                    )),
                                                top: 10.0,
                                                left: 130.0,
                                              ),
                                              Positioned(
                                                child: CircleButton(
                                                    onTap: () => {},
                                                    iconData: Image.asset(
                                                      'assets/social.png',
                                                    )),
                                                top: 10.0,
                                                left: 130.0,
                                              ),
                                            ],
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
            const Icon(Icons.directions_transit),
            // Icon(Icons.directions_transit),
          ],
        ),
      ),
    );
  }
}

class CustomSelector {
  final List<String> _dropDownItems = ['abc', 'def'];
  String? _chosenValue;
  late Color color;

  CustomSelector({this.color = const Color(0xFF213C53)});

  use() {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: DropdownButtonHideUnderline(
        child: ButtonTheme(
          alignedDropdown: true,
          child: DropdownButton<String>(
              icon: const Icon(Icons.keyboard_arrow_down_outlined,
                  color: Colors.red),
              dropdownColor: const Color(0xFF213C53),
              borderRadius: BorderRadius.circular(31),
              items: _dropDownItems
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              value: _chosenValue,
              hint: Text("All",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.3))),
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: Colors.white.withOpacity(0.3)),
              onChanged: (String? value) {}),
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

    return InkResponse(
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
