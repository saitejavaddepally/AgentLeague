import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:http/http.dart' as http;
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
import 'package:agent_league/ui/uploads_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../components/custom_button.dart';
import '../helper/constants.dart';

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

  Future<File> urlToFile(String imageUrl) async {
    var rng = Random();
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    File file = File(tempPath + (rng.nextInt(100)).toString() + '.png');
    http.Response response = await http.get(Uri.parse(imageUrl));
    await file.writeAsBytes(response.bodyBytes);
    return file;
  }

  Future uploadData() async {
    await EasyLoading.show(
      status: 'Uploading...please wait',
      maskType: EasyLoadingMaskType.black,
    );

    Map<String, dynamic> dataToBeUploaded = widget.data[0];
    dataToBeUploaded.addAll({"timestamp": DateTime.now().toString()});
    await UploadPropertiesToFirestore().postPropertyPageOne(dataToBeUploaded);
    print("I am done Here? ");
    print("images are $_images");
    print("docs are $_docs");
    print("videos are $_videos");

    await uploadToFireStore(_images, _IMAGE);

    await uploadToFireStore(_videos, _VIDEO);

    await uploadToFireStore(_docs, _DOCS);

    await EasyLoading.dismiss();
  }

  Future uploadToFireStore(List<dynamic> list, String type) async {
    await SharedPreferencesHelper()
        .getCurrentPlot()
        .then((value) => currentPlot = value);

    final _firebaseStorage = FirebaseStorage.instance;
    dynamic snapshot;
    for (var i = 0; i < list.length; i++) {
      if (list[i] != null) {
        await AuthMethods().getUserId().then((value) async {
          currentUser = value;
          var temp = list[i];
          print(list[i].runtimeType.toString());
          if (list[i].runtimeType.toString() == 'String') {
            print("converting into file...");
            temp = await urlToFile(list[i]);
            print("converted!");
          }
          print("Uploading to firestore...");
          snapshot = await _firebaseStorage
              .ref()
              .child(
                  'sell_images/$value/standlone/$currentPlot/$type/${(type == 'images') ? type + "_$i" : (type == 'docs') ? _docNames[i] : _videoNames[i]}')
              .putFile(temp! as File);
        });
      }
    }
    return "Updated $type successfully";
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (context) =>
                  PropertyPhotosProvider(widget.data[1]?['images'])),
          ChangeNotifierProvider(
              create: (context) =>
                  PropertyDocumentsProvider(widget.data[1]?['docs'])),
          ChangeNotifierProvider(
              create: (context) =>
                  PropertyVideoProvider(widget.data[1]?['videos'])),
        ],
        builder: (context, child) {
          final _photoProvider =
              Provider.of<PropertyPhotosProvider>(context, listen: false);
          return Scaffold(
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
                                icon:
                                    const Icon(Icons.keyboard_backspace_sharp)),
                            const CustomTitle(text: 'Post Your Property')
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
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
                                          image: (value.images[i] != null &&
                                                  value.images[i] is File)
                                              ? Image.file(value.images[i]!)
                                              : ((value.images[i] != null &&
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
                                            print("values are ${value.images}");
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
                                          image: (value.images[i] != null &&
                                                  value.images[i] is File)
                                              ? Image.file(value.images[i]!)
                                              : ((value.images[i] != null &&
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

                                            print("values are ${value.images}");
                                          },
                                        ))
                                    ],
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
                                          },
                                        ))
                                    ],
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
                                              _videoNames = value.videoNames;
                                            });
                                          },
                                        ))
                                    ],
                                  ),
                                  // SizedBox(
                                  //   height: 60,
                                  //   child: ListView.builder(
                                  //     scrollDirection: Axis.horizontal,
                                  //     itemCount: 5,
                                  //     shrinkWrap: true,
                                  //     itemBuilder: (context, index) {
                                  //       return Padding(
                                  //         padding: const EdgeInsets.only(right: 20),
                                  //         child: GestureDetector(
                                  //           onTap: () {
                                  //             value.pickVideo(index);
                                  //             _videos = value.videos;
                                  //             print(_videos);
                                  //           },
                                  //           child: Container(
                                  //             height: 55,
                                  //             width: 55,
                                  //             decoration: BoxDecoration(
                                  //                 color:
                                  //                     Colors.white.withOpacity(0.1),
                                  //                 borderRadius:
                                  //                     BorderRadius.circular(10)),
                                  //             child: (value.videos[index] != null)
                                  //                 ? Stack(children: [
                                  //                     Image.asset(
                                  //                         'assets/lead_box_image.png',
                                  //                         fit: BoxFit.fill),
                                  //                     Center(
                                  //                       child: Icon(
                                  //                           Icons
                                  //                               .play_arrow_rounded,
                                  //                           size: 35,
                                  //                           color: Colors.orange
                                  //                               .withOpacity(0.7)),
                                  //                     )
                                  //                   ])
                                  //                 : Image.asset(
                                  //                     'assets/picker.png'),
                                  //           ),
                                  //         ),
                                  //       );
                                  //     },
                                  //   ),
                                  // ),
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
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                                // await uploadData().then((value) {
                                                //   Navigator.pushNamedAndRemoveUntil(
                                                //       context,
                                                //       RouteName.bottomBar,
                                                //       (r) => false);
                                                // });
                                                await uploadData();
                                                Navigator.pushReplacementNamed(
                                                  context,
                                                  (!isEdited)
                                                      ? RouteName
                                                          .propertyDigitalization
                                                      : RouteName.bottomBar,
                                                  arguments: widget.data[0]
                                                    ..addAll({
                                                      'picture': _images[0]
                                                    }),
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
