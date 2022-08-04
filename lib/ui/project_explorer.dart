import 'package:agent_league/components/custom_button.dart';
import 'package:agent_league/components/neu_circular_button.dart';
import 'package:agent_league/ui/Home/project.dart';
import 'package:agent_league/ui/gallery.dart';
import 'package:agent_league/ui/tour.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../helper/constants.dart';
import '../theme/colors.dart';
import 'package:readmore/readmore.dart';

import 'emi.dart';

class ProjectExplorer extends StatefulWidget {
  final Map projectDetails;

  const ProjectExplorer({Key? key, required this.projectDetails})
      : super(key: key);

  @override
  State<ProjectExplorer> createState() => _ProjectExplorerState();
}

class _ProjectExplorerState extends State<ProjectExplorer> {
  CarouselController buttonCarouselController = CarouselController();

  late Map data;

  @override
  void initState() {
    data = widget.projectDetails;
    print(data);
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
                    image: data['images'][0],
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
                          decoration: BoxDecoration(
                              color: HexColor('F14B4B'),
                              borderRadius: BorderRadius.circular(4))),
                      const SizedBox(height: 5),
                      Text('Venture Name',
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
                                  text: ' : 5500 - 6000 Sq.yd',
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
                                  text: ' : 1100 - 2600 Sq.yd',
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
                    boxShadow: shadow1,
                    borderRadius: BorderRadius.circular(12),
                    color: HexColor('082640')),
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
                      projectDetails: data,
                      nameList: const ['location', 'Gallery', 'Tour', 'Layout'],
                    ),
                    Page(
                      controller: buttonCarouselController,
                      pageNumber: 2,
                      projectDetails: data,
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
                  CustomButton(
                          width: 123,
                          height: 41,
                          text: 'Export',
                          onClick: () {},
                          color: HexColor('082640'),
                          radius: 30)
                      .use(),
                  const SizedBox(width: 25),
                  CustomButton(
                          width: 123,
                          height: 41,
                          text: 'Subscribe',
                          onClick: () {},
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
  final Map projectDetails;

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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return GalleryScreen(info: {
                        "projectDetails": projectDetails,
                        "isProject": true
                      });
                    }));
                  }
                  else if (i.toString() == "Tour") {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                          return Tour(info: {
                            "projectDetails": projectDetails,
                            "isProject": true
                          });
                        }));
                  }

                  else if (i.toString() == "emi") {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                          return EMI(info: {
                            "projectDetails": projectDetails,
                            "isProject": true
                          });
                        }));
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
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  letterSpacing: -0.15,
                  color: Colors.white.withOpacity(0.8))),
        )
      ],
    );
  }
}
