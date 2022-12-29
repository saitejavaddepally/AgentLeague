import 'dart:io';

import 'package:agent_league/provider/sell_providers/sell_screen_methods.dart';
import 'package:agent_league/route_generator.dart';
import 'package:agent_league/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:timelines/timelines.dart';

import '../../provider/sell_providers/uploading_progress_provider.dart';

class UploadingProgress extends StatelessWidget {
  final Map<String, dynamic> previousData;
  final Map<String, dynamic>? dataToEdit;
  final bool isFreeListing;
  final List<File> image;
  final List<File> videos;
  final List<File> docs;
  final List<int> imagesIndex;
  final List<int> docsIndex;
  final List<int> videosIndex;
  UploadingProgress(
      {required this.previousData,
      required this.isFreeListing,
      required this.image,
      required this.docs,
      required this.videos,
      required this.imagesIndex,
      required this.docsIndex,
      required this.videosIndex,
      this.dataToEdit,
      Key? key})
      : super(key: key);

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
        create: (context) => UploadingProgressProvider(),
        builder: (context, child) {
          final _pr =
              Provider.of<UploadingProgressProvider>(context, listen: false);

          checkFunction(_pr, context);

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
                                                UploadingProgressProvider>(
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

  void checkFunction(UploadingProgressProvider _pr, BuildContext context) {
    if (dataToEdit != null) {
      final id = dataToEdit?['id'];
      _pr
          .editProject(previousData, image, videos, docs, imagesIndex,
              docsIndex, videosIndex, id)
          .then((value) async {
        if (dataToEdit?['isPaid'] == true) {
          EasyLoading.showSuccess('Property Edit Succesfully');
          Navigator.pushNamedAndRemoveUntil(
              context, RouteName.bottomBar, (route) => false,
              arguments: 1);
        } else {
          final data = await SellScreenMethods.getParticularPropertyDetail(id);
          Navigator.pushNamed(context, RouteName.propertyDigitalization,
              arguments: data!);
        }
      }).catchError((error) {
        Navigator.pushNamedAndRemoveUntil(
            context, RouteName.bottomBar, (route) => false,
            arguments: 1);
      });
    } else {
      _pr
          .addProject(previousData, image, videos, docs, isFreeListing,
              imagesIndex, docsIndex, videosIndex)
          .then((id) async {
        if (isFreeListing) {
          await SellScreenMethods.decrementFreeCredit();
          EasyLoading.showSuccess(
              'Property Uploaded Succesfully\nYou used your free credit');
          Navigator.pushNamedAndRemoveUntil(
              context, RouteName.bottomBar, (route) => false,
              arguments: 1);
        } else {
          final data = await SellScreenMethods.getParticularPropertyDetail(id);
          Navigator.pushNamed(context, RouteName.propertyDigitalization,
              arguments: data!);
        }
      }).catchError((error) {
        Navigator.pushNamedAndRemoveUntil(
            context, RouteName.bottomBar, (route) => false,
            arguments: 1);
      });
    }
  }
}
