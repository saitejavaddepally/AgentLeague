import 'package:agent_league/components/custom_title.dart';
import 'package:agent_league/provider/property_upload_provider.dart';
import 'package:agent_league/provider/upload_provider.dart';
import 'package:agent_league/route_generator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/custom_button.dart';
import '../../components/custom_line_under_text.dart';
import '../../theme/colors.dart';
import '../Home/bottom_navigation.dart';

class UploadsScreen extends StatefulWidget {
  final Map projectInfo;
  const UploadsScreen({Key? key, required this.projectInfo}) : super(key: key);

  @override
  State<UploadsScreen> createState() => _UploadsScreenState();
}

class _UploadsScreenState extends State<UploadsScreen> {
  late List<dynamic> _images = [];
  late List<dynamic> _docs = [];
  late List<dynamic> _videos = [];
  @override
  void initState() {
    // TODO: implement
    print("The data is ${widget.projectInfo}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ImageUploadProvider()),
        ChangeNotifierProvider(create: (context) => VideoUploadProvider()),
        ChangeNotifierProvider(create: (context) => PdfUploadProvider()),
      ],
      child: Scaffold(
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 10.0, right: 25),
          child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            CustomButton(
              text: 'Back',
              onClick: () {},
              color: HexColor('082640'),
              width: 85,
              height: 40,
            ).use(),
            const SizedBox(width: 20),
            CustomButton(
              text: 'Next',
              onClick: () async {
                await PropertyUploadProvider()
                    .uploadProject(widget.projectInfo as Map<String, dynamic>,
                        _images, _videos, _docs)
                    .then((value) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BottomBar(
                              index: 0,
                            )),
                    (route) => false,
                  );
                });
              },
              color: HexColor('FD7E0E'),
              width: 82,
              height: 40,
            ).use(),
          ]),
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.only(top: 20, bottom: 15, left: 25, right: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.keyboard_backspace_rounded)),
                const SizedBox(height: 30),
                CustomLineUnderText(
                        text: 'Upload Images',
                        height: 3,
                        width: 95,
                        color: HexColor('FE7F0E'))
                    .use(),
                const SizedBox(height: 15),
                Consumer<ImageUploadProvider>(
                  builder: (context, value, child) => Column(
                    children: [
                      Row(
                        children: [
                          for (int i = 0; i < 4; i++)
                            Flexible(
                                child: PickerContainer(
                              image: (value.images[i] != null)
                                  ? Image.file(value.images[i]!)
                                  : Image.asset('assets/picker.png'),
                              imageName:
                                  (i == 0) ? 'Cover image' : 'Image ${i + 1}',
                              onTap: () {
                                value.pickImage(i);
                                _images = value.images;
                              },
                            ))
                        ],
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          for (int i = 4; i < 8; i++)
                            Flexible(
                                child: PickerContainer(
                              imageName: 'Image ${i + 1}',
                              image: (value.images[i] != null)
                                  ? Image.file(value.images[i]!)
                                  : Image.asset('assets/picker.png'),
                              onTap: () {
                                value.pickImage(i);
                              },
                            ))
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                const ExceedText(
                    text: '[Each image file should not exceed 1 mb]'),
                const SizedBox(height: 30),
                CustomLineUnderText(
                        text: 'Upload Videos',
                        height: 3,
                        width: 95,
                        color: HexColor('FE7F0E'))
                    .use(),
                const SizedBox(height: 15),
                Consumer<VideoUploadProvider>(
                  builder: (context, value, child) => Row(
                    children: [
                      for (int i = 0; i < 4; i++)
                        Flexible(
                            child: PickerContainer(
                          imageName:
                              (i == 0) ? 'Realtor video' : 'Video ${i + 1}',
                          image: (value.videos[i] != null)
                              ? Image.asset('assets/lead_box_image.png',
                                  fit: BoxFit.fill)
                              : Image.asset('assets/picker.png'),
                          onTap: () {
                            value.pickVideo(i);
                            _videos = value.videos;
                          },
                        )),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                const ExceedText(text: '[Each Video should not exceed 3 mb]'),
                const SizedBox(height: 30),
                CustomLineUnderText(
                        text: 'Upload Docs',
                        height: 3,
                        width: 85,
                        color: HexColor('FE7F0E'))
                    .use(),
                const SizedBox(height: 15),
                Consumer<PdfUploadProvider>(
                  builder: (context, value, child) => Row(
                    children: [
                      for (int i = 0; i < 4; i++)
                        Flexible(
                            child: PickerContainer(
                          imageName: (i == 0)
                              ? 'Logo'
                              : (i == 1)
                                  ? 'Broucher'
                                  : (i == 2)
                                      ? 'Layout'
                                      : 'Doc',
                          image: (value.docs[i] != null)
                              ? Image.asset('assets/lead_box_image.png',
                                  fit: BoxFit.fill)
                              : Image.asset('assets/picker.png'),
                          onTap: () {
                            value.pickPdf(i);
                            _docs = value.docs;
                          },
                        )),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                const ExceedText(text: '[Upload any pdf files of site 3 mb]'),
              ],
            ),
          ),
        )),
      ),
    );
  }
}

class PickerContainer extends StatelessWidget {
  final String imageName;
  final Widget image;
  final void Function()? onTap;
  const PickerContainer(
      {required this.imageName, required this.image, this.onTap, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          margin: const EdgeInsets.only(right: 20),
          height: 60,
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: HexColor('203B53'),
            borderRadius: BorderRadius.circular(4),
          ),
          child: image,
        ),
        const SizedBox(height: 10),
        Text(imageName,
            style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 10,
                letterSpacing: -0.15))
      ]),
    );
  }
}

class ExceedText extends StatelessWidget {
  final String text;
  const ExceedText({required this.text, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Text(
        text,
        style: const TextStyle(
            fontWeight: FontWeight.w500, fontSize: 14, letterSpacing: -0.15),
      ),
    );
  }
}
