import 'package:agent_league/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:timelines/timelines.dart';

import '../../Services/upload_properties_to_firestore.dart';

class UploadingProgress extends StatelessWidget {
  final List data;
  UploadingProgress({required this.data, Key? key}) : super(key: key);

  static final shadow = [
    BoxShadow(
        offset: const Offset(0, 0),
        blurRadius: 30,
        spreadRadius: 0,
        color: HexColor('000000').withOpacity(0.20))
  ];

  final _processes = ['Images', 'Docs', 'Videos', 'Completed'];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => UploadPropertiesToFirestore(),
        builder: (context, child) {
          final _pr =
              Provider.of<UploadPropertiesToFirestore>(context, listen: false);
          _pr
              .uploadData(
                  data[0], data[1], data[2], data[3], data[4], data[5], data[6])
              .then((value) => Navigator.pop(context));
          return Scaffold(
            body: SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 15),
                          decoration: BoxDecoration(
                              boxShadow: shadow,
                              color: HexColor('ECFAD1'),
                              borderRadius: BorderRadius.circular(12)),
                          child: Column(
                            children: [
                              Container(
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 15, top: 15),
                                  child: Column(
                                    children: [
                                      Text(
                                        'Your property is getting digitalized. Its going to be awesome!!',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                            color: HexColor('111111'),
                                            letterSpacing: -0.15),
                                      ),
                                      Image.asset('assets/progress.png'),
                                    ],
                                  )),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: shadow,
                                    borderRadius: BorderRadius.circular(12)),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 10),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 17.0),
                                        child: Text('Uploading',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12,
                                                color: HexColor('0E0E0E')
                                                    .withOpacity(0.6))),
                                      ),
                                      Row(children: [
                                        Flexible(
                                            child: Consumer<
                                                UploadPropertiesToFirestore>(
                                          builder: (context, value, child) =>
                                              Timeline.tileBuilder(
                                            shrinkWrap: true,
                                            builder:
                                                TimelineTileBuilder.connected(
                                                    indicatorBuilder:
                                                        (context, index) {
                                                      if (index <
                                                          value.processIndex) {
                                                        return Icon(
                                                            Icons
                                                                .check_circle_rounded,
                                                            size: 17,
                                                            color: HexColor(
                                                                'C12103'));
                                                      } else if (index ==
                                                          value.processIndex) {
                                                        return Icon(
                                                            Icons
                                                                .check_circle_outline_rounded,
                                                            size: 17,
                                                            color: HexColor(
                                                                'C12103'));
                                                      } else {
                                                        return Icon(
                                                            Icons
                                                                .check_circle_outline_rounded,
                                                            size: 17,
                                                            color: HexColor(
                                                                    '082640')
                                                                .withOpacity(
                                                                    0.25));
                                                      }
                                                    },
                                                    connectorBuilder:
                                                        (_, index, ___) {
                                                      return SizedBox(
                                                        height: 24,
                                                        child: SolidLineConnector(
                                                            color: (value
                                                                        .processIndex <=
                                                                    index)
                                                                ? HexColor(
                                                                        '082640')
                                                                    .withOpacity(
                                                                        0.25)
                                                                : HexColor(
                                                                    'C12103')),
                                                      );
                                                    },
                                                    contentsBuilder: (context,
                                                            index) =>
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(24.0),
                                                          child: Text(
                                                            _processes[index],
                                                            style:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .black),
                                                          ),
                                                        ),
                                                    itemCount:
                                                        _processes.length,
                                                    nodePositionBuilder:
                                                        (_, __) => 0.05),
                                          ),
                                        )),
                                      ]),
                                    ]),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                            "Your patience is appreciated. Don't press any other button now.",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: Colors.white.withOpacity(0.60),
                                letterSpacing: -0.15)),
                      ],
                    )),
              ),
            ),
          );
        });
  }
}
