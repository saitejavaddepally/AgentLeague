import 'package:agent_league/components/custom_container_text.dart';
import 'package:agent_league/components/custom_label.dart';
import 'package:agent_league/components/custom_selector.dart';
import 'package:agent_league/provider/firestore_data_provider.dart';
import 'package:agent_league/theme/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
        body: const TabBarView(
          children: [
            Standlone(),
            Icon(Icons.directions_transit),
            // Icon(Icons.directions_transit),
          ],
        ),
      ),
    );
  }
}

class Standlone extends StatelessWidget {
  const Standlone({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomSelector(
                    dropDownItems: ['All'],
                    onChanged: (value) {},
                    chosenValue: null,
                    borderRadius: 10)
                .use(),
            const SizedBox(height: 15),
            Row(children: [
              Expanded(
                child: Row(
                  children: [
                    const Text('Date : '),
                    Flexible(
                        child: CustomSelector(
                                borderRadius: 10,
                                dropDownItems: ['abc', 'def'],
                                color: Colors.white,
                                textColor: Colors.black,
                                onChanged: (value) {},
                                chosenValue: null)
                            .use())
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Row(
                  children: [
                    const Text('Status : '),
                    Flexible(
                      child: CustomSelector(
                              borderRadius: 10,
                              color: Colors.white,
                              textColor: Colors.black,
                              dropDownItems: [],
                              onChanged: (value) {},
                              chosenValue: null)
                          .use(),
                    ),
                  ],
                ),
              ),
            ]),
            const SizedBox(height: 20),
            Expanded(
              child: FutureBuilder<
                      List<QueryDocumentSnapshot<Map<String, dynamic>>>>(
                  future: FirestoreDataProvider().getAllLeads(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              "${snapshot.data?.length ?? 0} leads are interested",
                              style: const TextStyle(fontSize: 22)),
                          const SizedBox(height: 15),
                          Expanded(
                            child: ListView.builder(
                                itemCount: snapshot.data?.length ?? 0,
                                itemBuilder: (context, index) {
                                  final currentItem =
                                      snapshot.data?[index].data();
                                  final name = currentItem?['name'];
                                  final contact = currentItem?['mobile'];
                                  final location = currentItem?['location'];
                                  final buyingTime =
                                      currentItem?['buying_time'];
                                  final profile = currentItem?['profile'];
                                  return Neumorphic(
                                    margin: const EdgeInsets.only(bottom: 20),
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
                                                  decoration:
                                                      const BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(17.0),
                                                      topRight:
                                                          Radius.circular(17.0),
                                                    ),
                                                    color: Colors.white,
                                                  ),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    // textBaseline: TextBaseline
                                                    //     .ideographic,
                                                    children: [
                                                      Expanded(
                                                        flex: 2,
                                                        child: Container(
                                                          margin:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 8,
                                                                  left: 8,
                                                                  bottom: 8),
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            child:
                                                                Image.network(
                                                                    profile,
                                                                    height: 120,
                                                                    fit: BoxFit
                                                                        .fill),
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 3,
                                                        child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8),
                                                            margin:
                                                                const EdgeInsets
                                                                        .fromLTRB(
                                                                    0,
                                                                    18,
                                                                    0,
                                                                    18),
                                                            child: Align(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              child: Column(
                                                                children: [
                                                                  CustomContainerText(
                                                                          text1:
                                                                              'Name',
                                                                          text2:
                                                                              name)
                                                                      .use(),
                                                                  CustomContainerText(
                                                                          text1:
                                                                              'Contact',
                                                                          text2:
                                                                              contact)
                                                                      .use(),
                                                                  CustomContainerText(
                                                                          text1:
                                                                              'Location',
                                                                          text2:
                                                                              location)
                                                                      .use(),
                                                                  CustomContainerText(
                                                                          text1:
                                                                              'Buying time ',
                                                                          text2:
                                                                              buyingTime)
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
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          12, 6, 12, 6),
                                                  decoration: BoxDecoration(
                                                    color: HexColor('#203b53'),
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(17.0),
                                                      bottomRight:
                                                          Radius.circular(17.0),
                                                    ),
                                                    // border: Border.all()
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      const Expanded(
                                                        flex: 3,
                                                        child: Text(
                                                          "Notes",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 20),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 2,
                                                        child: SizedBox(
                                                          height: 40,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(3.0),
                                                            child: Row(
                                                              children: [
                                                                Expanded(
                                                                  child:
                                                                      CircleButton(
                                                                          onTap:
                                                                              () {},
                                                                          iconData:
                                                                              Image.asset(
                                                                            'assets/chat.png',
                                                                          )),
                                                                ),
                                                                Expanded(
                                                                  child:
                                                                      CircleButton(
                                                                          onTap: () =>
                                                                              {},
                                                                          iconData:
                                                                              Image.asset(
                                                                            'assets/call.png',
                                                                          )),
                                                                ),
                                                                Expanded(
                                                                  child:
                                                                      CircleButton(
                                                                          onTap: () =>
                                                                              {},
                                                                          iconData:
                                                                              Image.asset(
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
                                  );
                                }),
                          ),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return const Center(
                          child: CustomLabel(text: 'Something Went Wrong'));
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  }),
            ),
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
