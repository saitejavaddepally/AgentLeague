import 'package:agent_league/components/custom_container_text.dart';
import 'package:agent_league/components/custom_label.dart';
import 'package:agent_league/components/custom_selector.dart';
import 'package:agent_league/provider/firestore_data_provider.dart';
import 'package:agent_league/theme/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

import '../route_generator.dart';

class LeadBox extends StatefulWidget {
  final String? docId;
  const LeadBox({required this.docId, Key? key}) : super(key: key);

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
            Standlone(docId: widget.docId),
            const Icon(Icons.directions_transit),
            // Icon(Icons.directions_transit),
          ],
        ),
      ),
    );
  }
}

class Standlone extends StatefulWidget {
  final String? docId;

  const Standlone({required this.docId, Key? key}) : super(key: key);

  @override
  State<Standlone> createState() => _StandloneState();
}

class _StandloneState extends State<Standlone> {
  String? _chosenValue;
  String? docId;
  final List<String> _dateDropDown = ['Recent First', 'Recent Last'];
  String _dateChosenValue = 'Recent First';
  final List<String> _statusDropDown = [
    'All',
    'New customer',
    'Deal in progress',
    'Deal successful',
    'Not interested'
  ];
  String _statusChosenValue = 'All';

  @override
  void initState() {
    docId = widget.docId;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder<List<List<String>>>(
                future: FirestoreDataProvider().getAllProperty(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<String> dropDownItems = snapshot.data![0];
                    if (docId == null) {
                      _chosenValue = 'All/0';
                    } else {
                      final index = snapshot.data?[1]
                          .indexWhere((element) => element == docId);
                      _chosenValue = snapshot.data?[0][index!];
                    }
                    return DropdownButtonHideUnderline(
                      child: ButtonTheme(
                        alignedDropdown: true,
                        child: DropdownButtonFormField<String>(
                            icon: const Icon(Icons.keyboard_arrow_down_outlined,
                                color: Colors.red),
                            dropdownColor: const Color(0xFF213C53),
                            decoration: InputDecoration(
                              isDense: true,
                              fillColor: const Color(0xFF213C53),
                              filled: true,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 7, horizontal: 5),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none),
                            ),
                            items: dropDownItems
                                .map((String e) => DropdownMenuItem<String>(
                                    value: e,
                                    child: FittedBox(
                                        child: Text(e.split('/')[0]))))
                                .toList(),
                            validator: (value) =>
                                value == null ? 'Field Required' : null,
                            value: _chosenValue,
                            isExpanded: true,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                            onChanged: (value) {
                              setState(() {
                                _chosenValue = value;
                                final index = value?.split('/')[1];
                                final id = snapshot.data?[1][int.parse(index!)];
                                if (id!.isNotEmpty) {
                                  docId = id;
                                } else {
                                  docId = null;
                                }
                              });
                            }),
                      ),
                    );
                  }
                  return const SizedBox();
                }),
            const SizedBox(height: 15),
            Row(children: [
              Expanded(
                child: Row(
                  children: [
                    const Text('Date : '),
                    Flexible(
                        child: CustomSelector(
                      isDense: true,
                      borderRadius: 10,
                      dropDownItems: _dateDropDown,
                      color: Colors.white,
                      textColor: Colors.black,
                      onChanged: (value) {
                        setState(() {
                          _dateChosenValue = value;
                        });
                      },
                      chosenValue: _dateChosenValue,
                    ).use())
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
                              isDense: true,
                              borderRadius: 10,
                              color: Colors.white,
                              textColor: Colors.black,
                              dropDownItems: _statusDropDown,
                              onChanged: (value) {
                                setState(() {
                                  _statusChosenValue = value;
                                });
                              },
                              chosenValue: _statusChosenValue)
                          .use(),
                    ),
                  ],
                ),
              ),
            ]),
            const SizedBox(height: 20),
            Expanded(
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: (docId == null)
                      ? FirestoreDataProvider.getAllLeads(
                          _dateChosenValue, _statusChosenValue.toLowerCase())
                      : FirestoreDataProvider.getParticularLead(docId!,
                          _dateChosenValue, _statusChosenValue.toLowerCase()),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              "${snapshot.data?.docs.length ?? 0} leads are interested",
                              style: const TextStyle(fontSize: 22)),
                          const SizedBox(height: 15),
                          Expanded(
                            child: ListView.builder(
                                itemCount: snapshot.data?.docs.length,
                                itemBuilder: (context, index) {
                                  final currentItem =
                                      snapshot.data?.docs[index].data();
                                  final name = currentItem?['name'];
                                  final contact = currentItem?['mobile'];
                                  final location = currentItem?['location'];
                                  final buyingTime =
                                      currentItem?['buying_time'];
                                  final leadUid =
                                      currentItem?['interestedUserUid'];
                                  final leadName = currentItem?['name'];
                                  final status = currentItem?['status'];
                                  final leadId = snapshot.data?.docs[index].id;
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
                                                            child:
                                                                FutureBuilder<
                                                                    String>(
                                                              initialData: '',
                                                              future: FirestoreDataProvider()
                                                                  .getUserProfilePicture(
                                                                      leadUid),
                                                              builder: (context,
                                                                      snapshot) =>
                                                                  ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                child: (snapshot
                                                                        .data!
                                                                        .isEmpty)
                                                                    ? Image.asset(
                                                                        'assets/profile.png',
                                                                        height:
                                                                            120,
                                                                        fit: BoxFit
                                                                            .fill)
                                                                    : Image
                                                                        .network(
                                                                        snapshot
                                                                            .data!,
                                                                        height:
                                                                            120,
                                                                        fit: BoxFit
                                                                            .fill,
                                                                      ),
                                                              ),
                                                            ),
                                                          )),
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
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(children: [
                                                        CircleButton(
                                                            onTap: () async =>
                                                                await showDeleteDialog(
                                                                    context,
                                                                    leadId!),
                                                            iconData: Image.asset(
                                                                'assets/trash.png')),
                                                        const SizedBox(
                                                            width: 7),
                                                        CircleButton(
                                                            onTap: () => {
                                                                  Navigator.pushNamed(
                                                                      context,
                                                                      RouteName
                                                                          .leadNotes,
                                                                      arguments:
                                                                          leadId)
                                                                },
                                                            iconData:
                                                                Image.asset(
                                                              'assets/social.png',
                                                            )),
                                                        const SizedBox(
                                                            width: 7),
                                                        CircleButton(
                                                          onTap: () => {
                                                            Navigator.pushNamed(
                                                                context,
                                                                RouteName
                                                                    .leadStatus,
                                                                arguments: [
                                                                  leadId,
                                                                  status
                                                                ])
                                                          },
                                                          color: (status ==
                                                                  'new customer')
                                                              ? Colors.yellow
                                                              : (status ==
                                                                      'deal in progress')
                                                                  ? Colors
                                                                      .orange
                                                                  : (status ==
                                                                          'deal successful')
                                                                      ? Colors
                                                                          .green
                                                                      : Colors
                                                                          .red,
                                                        ),
                                                      ]),
                                                      Row(
                                                        children: [
                                                          CircleButton(
                                                              onTap: () {
                                                                Navigator.pushNamed(
                                                                    context,
                                                                    RouteName
                                                                        .chatDetail,
                                                                    arguments: [
                                                                      leadUid,
                                                                      leadName
                                                                    ]);
                                                              },
                                                              iconData:
                                                                  Image.asset(
                                                                'assets/chat.png',
                                                              )),
                                                          const SizedBox(
                                                              width: 7),
                                                          CircleButton(
                                                              onTap: () => {},
                                                              iconData:
                                                                  Image.asset(
                                                                'assets/call.png',
                                                              )),
                                                        ],
                                                      )
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

  Future<void> showDeleteDialog(BuildContext context, String leadId) async {
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Are you sure to delete this lead?'),
              actions: [
                TextButton(
                    onPressed: () async {
                      EasyLoading.show(status: 'Please Wait...');
                      await FirestoreDataProvider.deleteLead(leadId);
                      await EasyLoading.showSuccess('Lead Successfully Deleted',
                          duration: const Duration(seconds: 2));
                      Navigator.pop(context);
                    },
                    child: const Text('Yes')),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('No')),
              ],
            ));
  }
}

class CircleButton extends StatelessWidget {
  final GestureTapCallback onTap;
  final Image? iconData;
  final Color color;

  const CircleButton(
      {Key? key, required this.onTap, this.iconData, this.color = Colors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double size = 30.0;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
        child: iconData,
      ),
    );
  }
}
