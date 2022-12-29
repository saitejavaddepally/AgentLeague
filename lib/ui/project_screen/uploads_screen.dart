import 'dart:collection';
import 'dart:developer';
import 'dart:io';

import 'package:agent_league/helper/file_compressor.dart';
import 'package:agent_league/provider/property_upload_provider.dart';
import 'package:agent_league/provider/upload_provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import '../../components/custom_button.dart';
import '../../components/custom_line_under_text.dart';
import '../../helper/string_manager.dart';
import '../../route_generator.dart';
import '../../theme/colors.dart';

class UploadsScreen extends StatefulWidget {
  final Map<String, dynamic> projectInfo;
  const UploadsScreen({Key? key, required this.projectInfo}) : super(key: key);

  @override
  State<UploadsScreen> createState() => _UploadsScreenState();
}

class _UploadsScreenState extends State<UploadsScreen> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> uploadProject(
      {required UnmodifiableListView<File?> images,
      required UnmodifiableListView<File?> videos,
      required UnmodifiableListView<File?> docs}) async {
    if (images[0] == null ||
        images[1] == null ||
        images[2] == null ||
        images[3] == null) {
      EasyLoading.showToast("First 4 images required to upload");
      return;
    }

    if (docs[0] == null || docs[1] == null) {
      EasyLoading.showToast("First 2 docs required to upload");
      return;
    }
    if (videos[0] == null) {
      EasyLoading.showToast("Atleast 1 video required to upload");
      return;
    }

    await EasyLoading.show(status: "Uploading Project Please Wait...");

    List<File> fileImages = [];
    List<int> fileImagesIndex = [];

    for (int i = 0; i < images.length; i++) {
      if (images[i] != null && images[i] is File) {
        fileImages.add(images[i] as File);
        fileImagesIndex.add(i);
      }
    }

    List<File> fileDocs = [];
    List<int> fileDocsIndex = [];

    for (int i = 0; i < docs.length; i++) {
      if (docs[i] != null && docs[i] is File) {
        fileDocs.add(docs[i] as File);
        fileDocsIndex.add(i);
      }
    }

    List<File> fileVideos = [];
    List<int> fileVideosIndex = [];

    for (int i = 0; i < videos.length; i++) {
      if (videos[i] != null && videos[i] is File) {
        final compressFile = await FileCompressor().compressVideo(videos[i]!);
        fileVideos.add(compressFile!);
        fileVideosIndex.add(i);
      }
    }

    try {
      await PropertyUploadProvider.addProject(
          data: widget.projectInfo,
          images: fileImages,
          imageIndex: fileImagesIndex,
          docs: fileDocs,
          docsIndex: fileDocsIndex,
          videos: fileVideos,
          videosIndex: fileVideosIndex);

      EasyLoading.showSuccess("Project Uploaded Succesafully",
          duration: const Duration(seconds: 3));
      Navigator.pushNamedAndRemoveUntil(
          context, RouteName.bottomBar, (route) => false,
          arguments: 3);
    } catch (e) {
      log(e.toString());
      EasyLoading.showToast(StringManager.somethingWentWrong);
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ImageUploadProvider()),
        ChangeNotifierProvider(create: (context) => VideoUploadProvider()),
        ChangeNotifierProvider(create: (context) => PdfUploadProvider()),
      ],
      child: Builder(builder: (context) {
        final imageProvider =
            Provider.of<ImageUploadProvider>(context, listen: false);
        final videoProvider =
            Provider.of<VideoUploadProvider>(context, listen: false);
        final docProvider =
            Provider.of<PdfUploadProvider>(context, listen: false);
        return Scaffold(
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
                  await uploadProject(
                      images: imageProvider.images,
                      videos: videoProvider.videos,
                      docs: docProvider.docs);
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
              padding: const EdgeInsets.only(
                  top: 20, bottom: 15, left: 25, right: 5),
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
                                    : 'Doc ${i - 1}',
                            image: (value.docs[i] != null)
                                ? Image.asset('assets/lead_box_image.png',
                                    fit: BoxFit.fill)
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
        );
      }),
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
