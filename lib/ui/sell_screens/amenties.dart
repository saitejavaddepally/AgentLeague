import 'dart:io';
import 'package:agent_league/ui/Home/bottom_navigation.dart';
import 'package:agent_league/ui/sell_screens/property_digitalization.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:agent_league/Services/upload_properties_to_firestore.dart';
import 'package:agent_league/components/custom_line_under_text.dart';
import 'package:agent_league/components/custom_title.dart';
import 'package:agent_league/helper/shared_preferences.dart';
import 'package:agent_league/provider/amenities_provider.dart';
import 'package:agent_league/theme/colors.dart';
import 'package:agent_league/ui/project_screen/uploads_screen.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../Services/firestore_crud_operations.dart';
import '../../components/custom_button.dart';
import '../../helper/constants.dart';

class Amenties extends StatefulWidget {
  final List data;

  const Amenties({required this.data, Key? key}) : super(key: key);

  @override
  State<Amenties> createState() => _AmentiesState();
}

class _AmentiesState extends State<Amenties> {
  late List<dynamic> _images = [];
  late List<dynamic> _docs = [];
  late List<dynamic> _videos = [];
  late List<dynamic> _docNames;
  late List<dynamic> _videoNames;
  static const String _IMAGE = 'images';
  static const String _VIDEO = 'videos';
  static const String _DOCS = 'docs';
  String? currentPlot = '';
  String? currentUser = '';
  bool isLoading = false;
  bool isEdited = false;

  @override
  void initState() {
    if (widget.data[1] != null) {
      _images = widget.data[1]['images'];
      _videos = widget.data[1]['videos'];
      _videoNames = widget.data[1]['previousVideoNames'];
      _docs = widget.data[1]['docs'];
      _docNames = widget.data[1]['previousDocNames'];
      isEdited = widget.data[1]['isEdited'];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (context) =>
                  PropertyPhotosProvider(widget.data[1]?['images'])),
          ChangeNotifierProvider(
              create: (context) => PropertyDocumentsProvider(
                  widget.data[1]?['docs'],
                  widget.data[1]?['previousDocNames'])),
          ChangeNotifierProvider(
              create: (context) => PropertyVideoProvider(
                  widget.data[1]?['videos'],
                  widget.data[1]?['previousVideoNames'])),
        ],
        builder: (context, child) {
          final _photoProvider =
              Provider.of<PropertyPhotosProvider>(context, listen: false);
          return (!isLoading)
              ? Scaffold(
                  body: SafeArea(
                    child: SingleChildScrollView(
                      child: ModalProgressHUD(
                        inAsyncCall: isLoading,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, bottom: 20),
                              child: Row(
                                children: [
                                  IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                          Icons.keyboard_backspace_sharp)),
                                  const CustomTitle(text: 'Post Your Property')
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30.0),
                              child: Column(
                                children: [
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
                                        Row(
                                          children: [
                                            for (int i = 0; i < 4; i++)
                                              Flexible(
                                                  child: PickerContainer(
                                                image: (value.images[i] !=
                                                            null &&
                                                        value.images[i] is File)
                                                    ? Image.file(
                                                        value.images[i]!)
                                                    : ((value.images[i] !=
                                                                null &&
                                                            value.images[i]
                                                                is String))
                                                        ? Image.network(
                                                            value.images[i]!)
                                                        : Image.asset(
                                                            'assets/picker.png'),
                                                imageName: 'Image ${i + 1}',
                                                onTap: () {
                                                  value.pickImage(i);
                                                  _images = value.images;
                                                  print(
                                                      "values are ${value.images}");
                                                },
                                              ))
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          children: [
                                            for (int i = 4; i < 8; i++)
                                              Flexible(
                                                  child: PickerContainer(
                                                image: (value.images[i] !=
                                                            null &&
                                                        value.images[i] is File)
                                                    ? Image.file(
                                                        value.images[i]!)
                                                    : ((value.images[i] !=
                                                                null &&
                                                            value.images[i]
                                                                is String))
                                                        ? Image.network(
                                                            value.images[i]!)
                                                        : Image.asset(
                                                            'assets/picker.png'),
                                                imageName: 'Image ${i + 1}',
                                                onTap: () {
                                                  value.pickImage(i);

                                                  _images = value.images;

                                                  print(
                                                      "values are ${value.images}");
                                                },
                                              ))
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                value.reset();
                                              },
                                              child: Text('Reset',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 14,
                                                      letterSpacing: 0.2,
                                                      color:
                                                          HexColor('FE7F0E'))),
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
                                        Row(
                                          children: [
                                            for (int i = 0; i < 4; i++)
                                              Flexible(
                                                  child: PickerContainer(
                                                image: (value.docs[i] != null)
                                                    ? Image.asset(
                                                        'assets/lead_box_image.png',
                                                        fit: BoxFit.fill)
                                                    : Image.asset(
                                                        'assets/picker.png'),
                                                imageName: 'Doc ${i + 1}',
                                                onTap: () {
                                                  value.pickDocuments(i);

                                                  _docs = value.docs;
                                                  _docNames = value.docNames;

                                                  print("docs are " +
                                                      _docs.toString() +
                                                      _docNames.toString());
                                                },
                                              ))
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                value.reset();
                                              },
                                              child: Text('Reset',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 14,
                                                      letterSpacing: 0.2,
                                                      color:
                                                          HexColor('FE7F0E'))),
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
                                        Row(
                                          children: [
                                            for (int i = 0; i < 4; i++)
                                              Flexible(
                                                  child: PickerContainer(
                                                image: (value.videos[i] != null)
                                                    ? Image.asset(
                                                        'assets/lead_box_image.png',
                                                        fit: BoxFit.fill)
                                                    : Image.asset(
                                                        'assets/picker.png'),
                                                imageName: 'Video ${i + 1}',
                                                onTap: () {
                                                  value.pickVideo(i);
                                                  setState(() {
                                                    _videos = value.videos;
                                                    _videoNames =
                                                        value.videoNames;
                                                  });
                                                },
                                              ))
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                value.reset();
                                              },
                                              child: Text('Reset',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 14,
                                                      letterSpacing: 0.2,
                                                      color:
                                                          HexColor('FE7F0E'))),
                                            )
                                          ],
                                        ),
                                        const SizedBox(height: 30),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            CustomButton(
                                                    text: 'Back',
                                                    width: 102,
                                                    height: 40,
                                                    onClick: () {
                                                      print('back');
                                                      Navigator.pop(context);
                                                    },
                                                    color: CustomColors.dark)
                                                .use(),
                                            const SizedBox(width: 15),
                                            CustomButton(
                                                    text: 'Next',
                                                    onClick: () async {
                                                      EasyLoading.show();
                                                      String credits =
                                                          await UploadPropertiesToFirestore()
                                                              .plotCreditChecker();
                                                      bool? ifPaid =
                                                          await SharedPreferencesHelper()
                                                              .getPaidCreditStatus();
                                                      EasyLoading.dismiss();

                                                      print(credits);
                                                      int freeCreditCurrent =
                                                          int.parse(credits);
                                                      if (freeCreditCurrent !=
                                                              0 &&
                                                          !ifPaid!) {
                                                        await EasyLoading.show(
                                                            status: '0%');
                                                        await UploadPropertiesToFirestore()
                                                            .uploadData(
                                                                _images,
                                                                _videos,
                                                                _docs,
                                                                _docNames,
                                                                _videoNames,
                                                                isEdited,
                                                                widget.data[0]);
                                                        await UploadPropertiesToFirestore()
                                                            .updateFreeCredit(
                                                                freeCreditCurrent -
                                                                    1);
                                                        SharedPreferencesHelper()
                                                            .getCurrentPlot()
                                                            .then(
                                                                (value) async {
                                                          String number = value
                                                              .toString()
                                                              .substring(5);
                                                          await FirestoreCrudOperations()
                                                              .updatePlotInformation(
                                                                  int.parse(
                                                                      number),
                                                                  {
                                                                "isPaid": "true"
                                                              });
                                                        });
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                const SnackBar(
                                                                    content: Text(
                                                                        '"You have used your free credit.."')));

                                                        Navigator
                                                            .pushAndRemoveUntil(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      BottomBar(
                                                                        index:
                                                                            0,
                                                                      )),
                                                          (route) => false,
                                                        );
                                                        await EasyLoading
                                                            .showSuccess(
                                                                'Thank you');
                                                        return;
                                                      }

                                                      await EasyLoading.show(
                                                          status:
                                                              'Please wait..');

                                                      if (isEdited) {
                                                        String? userId;
                                                        await SharedPreferencesHelper()
                                                            .getUserId()
                                                            .then(
                                                                (value) async {
                                                          userId = value;
                                                          await SharedPreferencesHelper()
                                                              .getCurrentPlot()
                                                              .then(
                                                                  (value) async {
                                                            int number =
                                                                int.parse(value
                                                                    .toString()
                                                                    .substring(
                                                                        5));
                                                            await FirestoreCrudOperations()
                                                                .updatePlotInformation(
                                                                    number, {
                                                              "images":
                                                                  FieldValue
                                                                      .delete(),
                                                              "videos":
                                                                  FieldValue
                                                                      .delete(),
                                                              "docs": FieldValue
                                                                  .delete(),
                                                              "docNames":
                                                                  FieldValue
                                                                      .delete(),
                                                              "videoNames":
                                                                  FieldValue
                                                                      .delete(),
                                                            });
                                                          });
                                                        });
                                                      }

                                                      await UploadPropertiesToFirestore()
                                                          .uploadData(
                                                              _images,
                                                              _videos,
                                                              _docs,
                                                              _docNames,
                                                              _videoNames,
                                                              isEdited,
                                                              widget.data[0]);
                                                      await EasyLoading.showSuccess(
                                                          'Saved your property!');
                                                      Navigator
                                                          .pushAndRemoveUntil(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                PropertyDigitalization(
                                                                  formData: {
                                                                    "propData":
                                                                        widget.data[
                                                                            0],
                                                                    "media": {
                                                                      "picture":
                                                                          _images[
                                                                              0]
                                                                    }
                                                                  },
                                                                )),
                                                        (route) => false,
                                                      );
                                                    },
                                                    width: 102,
                                                    height: 40,
                                                    color: HexColor('FD7E0E'))
                                                .use(),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                );
        });
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
