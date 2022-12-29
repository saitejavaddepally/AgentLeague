import 'package:agent_league/components/custom_button.dart';
import 'package:agent_league/components/neu_circular_button.dart';
import 'package:agent_league/helper/string_manager.dart';
import 'package:agent_league/ui/Home/project.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../helper/constants.dart';
import '../../provider/property_upload_provider.dart';
import '../../route_generator.dart';
import '../../theme/colors.dart';
import 'package:readmore/readmore.dart';

import '../location.dart';

class ProjectExplorer extends StatefulWidget {
  final Map<String, dynamic> data;

  const ProjectExplorer({Key? key, required this.data}) : super(key: key);

  @override
  State<ProjectExplorer> createState() => _ProjectExplorerState();
}

class _ProjectExplorerState extends State<ProjectExplorer> {
  CarouselController buttonCarouselController = CarouselController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 15, right: 25, left: 25, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.keyboard_backspace_rounded)),
              const SizedBox(height: 15),
              Row(children: [
                Expanded(
                  child: CustomImage(
                    height: 220,
                    onTap: () {},
                    image: widget.data[StringManager.imagesKey][0],
                  ),
                ),
              ]),
              const SizedBox(height: 20),
              Row(
                textBaseline: TextBaseline.ideographic,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          height: 30,
                          width: 60,
                          child: CachedNetworkImage(
                              imageUrl: widget.data[StringManager.docsKey][0],
                              fit: BoxFit.fill),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4))),
                      const SizedBox(height: 5),
                      Text("${widget.data[StringManager.ventureName]}",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              color: Colors.white.withOpacity(0.7)))
                    ],
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                            text: TextSpan(
                                style: const TextStyle(
                                    fontSize: 14,
                                    letterSpacing: -0.14,
                                    fontWeight: FontWeight.w600),
                                children: [
                              const TextSpan(text: 'Price'),
                              TextSpan(
                                  text:
                                      ' : ${widget.data[StringManager.pricePerUnitText]} ${widget.data[StringManager.pricePerUnitDropDown]}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white.withOpacity(0.7)))
                            ])),
                        const SizedBox(height: 10),
                        RichText(
                            text: TextSpan(
                                style: const TextStyle(
                                    fontSize: 14,
                                    letterSpacing: -0.14,
                                    fontWeight: FontWeight.w600),
                                children: [
                              const TextSpan(text: 'Plot sale'),
                              TextSpan(
                                  text:
                                      ' : ${widget.data[StringManager.unitSizeOne]} - ${widget.data[StringManager.unitSizeTwo]} ${widget.data[StringManager.unitSizeDropDown]}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white.withOpacity(0.7)))
                            ]))
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              ReadMoreText(
                'Sunshine park is HMDA approved layout situated at yadadri on warangal highway spread across 25 acres woth all amenitess and ready to contact house move',
                trimLines: 2,
                style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    letterSpacing: -0.15,
                    height: 1.3),
                colorClickableText: HexColor('FB7B0E'),
                trimMode: TrimMode.Line,
                trimCollapsedText: 'more',
                trimExpandedText: 'less',
              ),
              const SizedBox(height: 25),
              Text(
                'Details',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    letterSpacing: -0.15,
                    color: HexColor('FB7B0E')),
              ),
              const SizedBox(height: 15),
              Container(
                height: 110,
                padding: const EdgeInsets.only(top: 25),
                decoration: BoxDecoration(
                  color: const Color(0xFF082640),
                  boxShadow: shadow1,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: CarouselSlider(
                  carouselController: buttonCarouselController,
                  options: CarouselOptions(
                    enableInfiniteScroll: false,
                    viewportFraction: 1,
                    autoPlay: false,
                    height: 110,
                  ),
                  items: [
                    Page(
                      controller: buttonCarouselController,
                      pageNumber: 1,
                      projectDetails: widget.data,
                      nameList: const ['location', 'Gallery', 'Tour', 'Layout'],
                    ),
                    Page(
                      controller: buttonCarouselController,
                      pageNumber: 2,
                      projectDetails: widget.data,
                      nameList: const ['Layout', 'emi', 'Realtor', 'Broucher'],
                    )
                  ].map((page) {
                    return page;
                  }).toList(),
                ),
              ),
              const SizedBox(height: 25),
              const CustomText(
                  text1: 'Amenities :',
                  text2: 'Club House, Parks, Temples, Schools, Tennis Court'),
              const SizedBox(height: 15),
              const CustomText(text1: 'Possession :', text2: 'Ready To Occupy'),
              const SizedBox(height: 60),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (!widget.data[StringManager.isExportKey])
                    CustomButton(
                            width: 123,
                            height: 41,
                            text: 'Export',
                            onClick: () async {
                              await EasyLoading.show(status: 'Please wait...');
                              await PropertyUploadProvider.updateProject(
                                  widget.data['docId']);
                              await EasyLoading.dismiss();
                              await EasyLoading.showSuccess('Export Complete',
                                  duration: const Duration(seconds: 1));
                              setState(() {
                                widget.data[StringManager.isExportKey] = true;
                              });
                            },
                            color: HexColor('082640'),
                            radius: 30)
                        .use(),
                  const SizedBox(width: 25),
                  CustomButton(
                          width: 123,
                          height: 41,
                          text: 'Subscribe',
                          onClick: () async {
                            final docId = widget.data['docId'];

                            EasyLoading.show(status: 'Please Wait...');
                            final res =
                                await PropertyUploadProvider.isSubscribedUser(
                                    docId);
                            if (res) {
                              await EasyLoading.showToast('Already Subscribed');
                            } else {
                              PropertyUploadProvider.subscribeUser(docId);
                              await EasyLoading.showSuccess(
                                  'Subscribed Successfully');
                            }
                          },
                          color: HexColor('fd7e0e'),
                          radius: 30)
                      .use()
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}

class Page extends StatelessWidget {
  final CarouselController controller;
  final int pageNumber;
  final Map<String, dynamic> projectDetails;

  final List nameList;

  const Page(
      {required this.controller,
      required this.pageNumber,
      required this.nameList,
      required this.projectDetails,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (pageNumber == 2)
          Row(children: [
            const SizedBox(width: 10),
            GestureDetector(
                onTap: () {
                  controller.previousPage();
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Icon(Icons.arrow_back_ios_new_rounded,
                      size: 25, color: HexColor('FD7E0E')),
                )),
          ]),
        for (String i in nameList)
          Flexible(
            child: CircularNeumorphicButton(
                color: HexColor('#213c53'),
                isNeu: false,
                imageName: i,
                width: 24,
                text: i,
                isTextUnder: true,
                onTap: () {
                  if (i.toString() == "Gallery") {
                    Navigator.pushNamed(context, RouteName.gallery,
                        arguments: projectDetails[StringManager.imagesKey]);
                  } else if (i.toString() == "Tour") {
                    Navigator.pushNamed(context, RouteName.tour,
                        arguments: projectDetails[StringManager.videosKey]);
                  } else if (i.toString() == "emi") {
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) {
                    //   return EMI(info: {
                    //     "projectDetails": projectDetails,
                    //     "isProject": true
                    //   });
                    // }));
                  } else if (i.toString() == 'location') {
                    double latitude = projectDetails[StringManager.latitudeKey];
                    double longitude =
                        projectDetails[StringManager.longitudeKey];

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LocationScreen(
                                latitude: latitude, longitude: longitude)));
                  } else if (i.toString() == 'Layout') {
                    Navigator.pushNamed(context, RouteName.layout);
                  } else if (i.toString() == 'Realtor') {
                    Navigator.pushNamed(context, RouteName.realtorVideo,
                        arguments: [
                          projectDetails[StringManager.videosKey][0]
                        ]);
                  } else if (i.toString() == 'Broucher') {
                    Navigator.pushNamed(context, RouteName.broucher,
                        arguments: [projectDetails[StringManager.docsKey][1]]);
                  }
                }).use(),
          ),
        if (pageNumber == 1)
          Row(children: [
            GestureDetector(
                onTap: () {
                  controller.nextPage();
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Icon(Icons.arrow_forward_ios_rounded,
                      size: 25, color: HexColor('FD7E0E')),
                )),
            const SizedBox(width: 10),
          ]),
      ],
    );
  }
}

class CustomText extends StatelessWidget {
  final String text1;
  final String text2;

  const CustomText({required this.text1, required this.text2, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      textBaseline: TextBaseline.alphabetic,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      children: [
        Text(
          text1,
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              letterSpacing: -0.15,
              color: HexColor('FB7B0E')),
        ),
        const SizedBox(width: 10),
        Flexible(
          child: Text(text2,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                letterSpacing: -0.15,
              )),
        )
      ],
    );
  }
}
