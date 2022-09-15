import 'package:agent_league/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:timelines/timelines.dart';

class UploadingProgress extends StatelessWidget {
  UploadingProgress({Key? key}) : super(key: key);

  static final shadow = [
    BoxShadow(
        offset: const Offset(0, 0),
        blurRadius: 30,
        spreadRadius: 0,
        color: HexColor('000000').withOpacity(0.20))
  ];

  final _processes = ['Images', 'Docs', 'Videos', 'Completed'];
  final _processIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
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
                        child: Row(children: [
                          Flexible(
                              child: Timeline.tileBuilder(
                            shrinkWrap: true,
                            builder: TimelineTileBuilder.connected(
                                indicatorBuilder: (context, index) {
                                  if (index < _processIndex) {
                                    return Icon(Icons.check_circle_rounded,
                                        size: 17, color: HexColor('C12103'));
                                  } else if (index == _processIndex) {
                                    return Icon(
                                        Icons.check_circle_outline_rounded,
                                        size: 17,
                                        color: HexColor('C12103'));
                                  } else {
                                    return Icon(
                                        Icons.check_circle_outline_rounded,
                                        size: 17,
                                        color: HexColor('082640')
                                            .withOpacity(0.25));
                                  }
                                },
                                connectorBuilder: (_, index, ___) {
                                  return SizedBox(
                                    height: 24,
                                    child: SolidLineConnector(
                                        color: (_processIndex <= index)
                                            ? HexColor('082640')
                                                .withOpacity(0.25)
                                            : HexColor('C12103')),
                                  );
                                },
                                contentsBuilder: (context, index) => Padding(
                                      padding: const EdgeInsets.all(24.0),
                                      child: Text(
                                        _processes[index],
                                        style: const TextStyle(
                                            color: Colors.black),
                                      ),
                                    ),
                                itemCount: _processes.length,
                                nodePositionBuilder: (_, __) => 0.05),
                          )),
                        ]),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                    'Your patience is appreciated. Don’t press any other button now.',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: Colors.white.withOpacity(0.60),
                        letterSpacing: -0.15)),
              ],
            )),
      ),
    );
  }
}
