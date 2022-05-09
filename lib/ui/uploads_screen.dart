import 'package:agent_league/components/custom_title.dart';
import 'package:agent_league/provider/upload_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/custom_button.dart';
import '../theme/colors.dart';

class UploadsScreen extends StatefulWidget {
  const UploadsScreen({Key? key}) : super(key: key);

  @override
  State<UploadsScreen> createState() => _UploadsScreenState();
}

class _UploadsScreenState extends State<UploadsScreen> {
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
              onClick: () {},
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
                const CustomTitle(text: 'Upload Images'),
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
                              imageName: 'Image $i',
                              onTap: () {
                                value.pickImage(i);
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
                              imageName: 'Image $i',
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
                const CustomTitle(text: 'Upload Videos'),
                const SizedBox(height: 15),
                Consumer<VideoUploadProvider>(
                  builder: (context, value, child) => Row(
                    children: [
                      for (int i = 0; i < 4; i++)
                        Flexible(
                            child: PickerContainer(
                          imageName: 'Video$i',
                          image: (value.videos[i] != null)
                              ? Stack(children: [
                                  Image.asset('assets/lead_box_image.png',
                                      fit: BoxFit.fill),
                                  Center(
                                    child: Icon(Icons.play_arrow_rounded,
                                        size: 35,
                                        color: Colors.orange.withOpacity(0.7)),
                                  )
                                ])
                              : Image.asset('assets/picker.png'),
                          onTap: () {
                            value.pickVideo(i);
                          },
                        )),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                const ExceedText(text: '[Each Video should not exceed 3 mb]'),
                const SizedBox(height: 30),
                const CustomTitle(text: 'Upload Docs'),
                const SizedBox(height: 15),
                Consumer<PdfUploadProvider>(
                  builder: (context, value, child) => Row(
                    children: [
                      for (int i = 0; i < 4; i++)
                        Flexible(
                            child: PickerContainer(
                          imageName: 'Doc$i',
                          image: (value.docs[i] != null)
                              ? Stack(children: [
                                  Image.asset('assets/lead_box_image.png',
                                      fit: BoxFit.fill),
                                  Center(
                                    child: Icon(Icons.online_prediction_rounded,
                                        size: 35,
                                        color: Colors.orange.withOpacity(0.7)),
                                  )
                                ])
                              : Image.asset('assets/picker.png'),
                          onTap: () {
                            value.pickPdf(i);
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
          height: 50,
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
