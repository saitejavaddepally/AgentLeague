import 'dart:convert';
import 'dart:io';

import 'package:agent_league/Services/auth_methods.dart';
import 'package:agent_league/Services/upload_properties_to_firestore.dart';
import 'package:agent_league/components/custom_line_under_text.dart';
import 'package:agent_league/components/custom_title.dart';
import 'package:agent_league/helper/shared_preferences.dart';
import 'package:agent_league/provider/amenities_provider.dart';
import 'package:agent_league/provider/post_your_property_provider_one.dart';
import 'package:agent_league/provider/post_your_property_provider_two.dart';
import 'package:agent_league/route_generator.dart';
import 'package:agent_league/theme/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../components/custom_button.dart';
import '../helper/constants.dart';

class Amenties extends StatefulWidget {
  final Map<String, dynamic> formData;

  const Amenties({required this.formData, Key? key}) : super(key: key);

  @override
  State<Amenties> createState() => _AmentiesState();
}

class _AmentiesState extends State<Amenties> {
  late List<File?> _images;
  late List<File?> _docs;
  late List<File?> _videos;
  static const String _IMAGE = 'images';
  static const String _VIDEO = 'videos';
  static const String _DOCS = 'docs';
  String? currentPlot = '';
  String? currentUser = '';
  bool isLoading = false;
  late Map pageOneDataForFirestore ;
  late Map pageTwoDataForFirestore;

  @override
  void initState() {
    super.initState();
    print("Am I here? ");
    pageOneDataForFirestore = widget.formData['pageOneData'];
    pageTwoDataForFirestore = widget.formData['pageTwoData'];
    print(pageOneDataForFirestore);
    print(pageTwoDataForFirestore);
    configLoading();
  }

  void configLoading() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.spinningCircle
      ..loadingStyle = EasyLoadingStyle.dark
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..progressColor = Colors.yellow
      ..backgroundColor = Colors.green
      ..indicatorColor = Colors.yellow
      ..textColor = Colors.white
      ..maskColor = Colors.blue.withOpacity(0.5)
      ..userInteractions = true
      ..dismissOnTap = false;
  }

  Future uploadData() async {
    await EasyLoading.show(
      status: 'Uploading...please do not close app',
      maskType: EasyLoadingMaskType.black,
    );

    await UploadPropertiesToFirestore()
        .postPropertyPageOne(pageOneDataForFirestore as Map<String, dynamic>).then((value) async {
      await UploadPropertiesToFirestore()
          .postPropertyPageTwo(pageTwoDataForFirestore as Map<String, dynamic>).then((value) async {
        await uploadToFireStore(_images, _IMAGE).then((value) async {
          print(value);
          await uploadToFireStore(_videos, _VIDEO).then((value) async {
            print(value);
            await uploadToFireStore(_docs, _DOCS).then((value) async {
              print(value);
              CollectionReference ref = FirebaseFirestore.instance
                  .collection("sell_plots")
                  .doc(currentUser)
                  .collection("standlone")
                  .doc(currentPlot)
                  .collection("page_3");

              await ref.add({
                "path_to_storage":
                    "sell_images/$currentUser/standlone/$currentPlot/"
              });
            }).then((value) async {
              await EasyLoading.showSuccess('Success!');
            });
          });
        });
      });
    });
  }

  Future uploadToFireStore(List<File?> list, String type) async {
    await SharedPreferencesHelper()
        .getCurrentPlot()
        .then((value) => currentPlot = value);

    print(currentPlot);
    final _firebaseStorage = FirebaseStorage.instance;
    dynamic snapshot;
    for (var i = 0; i < list.length; i++) {
      if (list[i] != null) {
        await AuthMethods().getUserId().then((value) async {
          currentUser = value;

          snapshot = await _firebaseStorage
              .ref()
              .child(
                  'sell_images/$value/standlone/$currentPlot/$type/${type}_$i')
              .putFile(list[i]!);
        });
      }
    }
    return "Updated $type successfully";
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AmenitiesProvider()),
        ChangeNotifierProvider(create: (context) => PropertyPhotosProvider()),
        ChangeNotifierProvider(
            create: (context) => PropertyDocumentsProvider()),
        ChangeNotifierProvider(create: (context) => PropertyVideoProvider()),
      ],
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: ModalProgressHUD(
              inAsyncCall: isLoading,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, bottom: 20),
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.keyboard_backspace_sharp)),
                        const CustomTitle(text: 'Post Your Property')
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Column(
                      children: [
                        CustomLineUnderText(
                                text: 'Amenities',
                                height: 3,
                                width: 65,
                                color: HexColor('FE7F0E'))
                            .use(),
                        const SizedBox(height: 20),
                        Consumer<AmenitiesProvider>(
                          builder: (context, value, child) => Column(
                            children: [
                              Row(
                                children: [
                                  IconTextButton(
                                      image: 'assets/gyms.png',
                                      text: 'Gyms',
                                      onTap: () => value.toggleGyms(),
                                      isSelected: value.gyms),
                                  const SizedBox(width: 25),
                                  IconTextButton(
                                    image: 'assets/automation.png',
                                    text: 'Home Automation',
                                    onTap: () => value.toggleAutomation(),
                                    isSelected: value.automation,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 25),
                              Row(
                                children: [
                                  IconTextButton(
                                    image: 'assets/elevator.png',
                                    text: 'Elevator',
                                    onTap: () => value.toggleElevator(),
                                    isSelected: value.elevator,
                                  ),
                                  const SizedBox(width: 25),
                                  IconTextButton(
                                    image: 'assets/pipe.png',
                                    text: 'Piped Gas',
                                    onTap: () => value.togglePipedGas(),
                                    isSelected: value.pipedGas,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 25),
                              Row(
                                children: [
                                  IconTextButton(
                                    image: 'assets/balcony.png',
                                    text: 'Balcony',
                                    onTap: () => value.toggleBalcony(),
                                    isSelected: value.balcony,
                                  ),
                                  const SizedBox(width: 25),
                                  IconTextButton(
                                    image: 'assets/bore_water.png',
                                    text: 'Bore Water',
                                    onTap: () => value.toggleBoreWater(),
                                    isSelected: value.boreWater,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 25),
                              Row(
                                children: [
                                  IconTextButton(
                                    image: 'assets/servant.png',
                                    text: 'Servent',
                                    onTap: () => value.toggleServant(),
                                    isSelected: value.servant,
                                  ),
                                  const SizedBox(width: 25),
                                  IconTextButton(
                                      image: 'assets/backup.png',
                                      text: 'Backup Power',
                                      onTap: () => value.toggleBackup(),
                                      isSelected: value.backup),
                                ],
                              ),
                              const SizedBox(height: 25),
                              Row(
                                children: [
                                  IconTextButton(
                                    image: 'assets/gated.png',
                                    text: 'Gated',
                                    onTap: () => value.toggleGated(),
                                    isSelected: value.gated,
                                  ),
                                  const SizedBox(width: 25),
                                  IconTextButton(
                                    image: 'assets/municipal_water.png',
                                    text: 'Municipal Water',
                                    onTap: () => value.toggleMunicipalWater(),
                                    isSelected: value.municipalWater,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 35),
                        CustomLineUnderText(
                                text: 'Upload Property photos',
                                height: 3,
                                width: 150,
                                color: HexColor('FE7F0E'))
                            .use(),
                        const SizedBox(height: 20),
                        Consumer<PropertyPhotosProvider>(
                          builder: (context, value, child) => Column(
                            children: [
                              SizedBox(
                                height: 60,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 5,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(right: 20),
                                      child: GestureDetector(
                                        onTap: () {
                                          value.pickImage(index);
                                          _images = value.images;
                                          print(_images);
                                        },
                                        child: Container(
                                          height: 55,
                                          width: 55,
                                          decoration: BoxDecoration(
                                              color:
                                                  Colors.white.withOpacity(0.1),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: (value.images[index] != null)
                                              ? Image.file(value.images[index]!)
                                              : Image.asset(
                                                  'assets/picker.png'),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      value.reset();
                                    },
                                    child: Text('Reset',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                            letterSpacing: 0.2,
                                            color: HexColor('FE7F0E'))),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 35),
                        CustomLineUnderText(
                                text: 'Upload Property Documents',
                                height: 3,
                                width: 175,
                                color: HexColor('FE7F0E'))
                            .use(),
                        const SizedBox(height: 20),
                        Consumer<PropertyDocumentsProvider>(
                          builder: (context, value, child) => Column(
                            children: [
                              SizedBox(
                                height: 60,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 5,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(right: 20),
                                      child: GestureDetector(
                                        onTap: () {
                                          value.pickDocuments(index);
                                          _docs = value.docs;
                                          print(_docs);
                                        },
                                        child: Container(
                                          height: 55,
                                          width: 55,
                                          decoration: BoxDecoration(
                                              color:
                                                  Colors.white.withOpacity(0.1),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: (value.docs[index] != null)
                                              ? Image.file(value.docs[index]!)
                                              : Image.asset(
                                                  'assets/picker.png'),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      value.reset();
                                    },
                                    child: Text('Reset',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                            letterSpacing: 0.2,
                                            color: HexColor('FE7F0E'))),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 35),
                        CustomLineUnderText(
                                text: 'Upload Property video',
                                height: 3,
                                width: 140,
                                color: HexColor('FE7F0E'))
                            .use(),
                        const SizedBox(height: 20),
                        Consumer<PropertyVideoProvider>(
                          builder: (context, value, child) => Column(
                            children: [
                              SizedBox(
                                height: 60,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 5,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(right: 20),
                                      child: GestureDetector(
                                        onTap: () {
                                          value.pickVideo(index);
                                          _videos = value.videos;
                                          print(_videos);
                                        },
                                        child: Container(
                                          height: 55,
                                          width: 55,
                                          decoration: BoxDecoration(
                                              color:
                                                  Colors.white.withOpacity(0.1),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: (value.videos[index] != null)
                                              ? Stack(children: [
                                                  Image.asset(
                                                      'assets/lead_box_image.png',
                                                      fit: BoxFit.fill),
                                                  Center(
                                                    child: Icon(
                                                        Icons
                                                            .play_arrow_rounded,
                                                        size: 35,
                                                        color: Colors.orange
                                                            .withOpacity(0.7)),
                                                  )
                                                ])
                                              : Image.asset(
                                                  'assets/picker.png'),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      value.reset();
                                    },
                                    child: Text('Reset',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                            letterSpacing: 0.2,
                                            color: HexColor('FE7F0E'))),
                                  )
                                ],
                              ),
                              const SizedBox(height: 30),
                              CustomButton(
                                      text: 'Submit',
                                      onClick: () async {
                                        // await uploadToFireStore(
                                        //     _images, _IMAGE);
                                        // await uploadToFireStore(
                                        //     _videos, _VIDEO);
                                        // await uploadToFireStore(_docs, _DOCS);
                                        // CollectionReference ref =
                                        //     FirebaseFirestore.instance
                                        //         .collection("sell_plots")
                                        //         .doc(currentUser)
                                        //         .collection("standlone")
                                        //         .doc(currentPlot)
                                        //         .collection("page_3");
                                        await uploadData().then((value) {
                                          Navigator.pushNamedAndRemoveUntil(
                                              context,
                                              RouteName.bottomBar,
                                              (r) => false);
                                        });
                                      },
                                      width: 102,
                                      height: 40,
                                      color: HexColor('FD7E0E'))
                                  .use(),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class IconTextButton extends StatelessWidget {
  final String image;
  final String text;
  final bool isSelected;
  final void Function() onTap;

  const IconTextButton(
      {required this.image,
      required this.text,
      required this.onTap,
      this.isSelected = false,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 16),
        decoration: BoxDecoration(
            boxShadow: shadow1,
            borderRadius: BorderRadius.circular(30),
            gradient: (isSelected)
                ? LinearGradient(
                    colors: [HexColor('FD7E0E'), HexColor('C12103')],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter)
                : null,
            color: HexColor('082640')),
        child: Row(children: [
          Image.asset(image),
          const SizedBox(width: 10),
          Text(text,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14))
        ]),
      ),
    );
  }
}
