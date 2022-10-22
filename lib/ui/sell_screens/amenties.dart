import 'dart:io';
import 'package:agent_league/components/custom_line_under_text.dart';
import 'package:agent_league/components/custom_title.dart';
import 'package:agent_league/provider/sell_providers/amenities_provider.dart';
import 'package:agent_league/route_generator.dart';
import 'package:agent_league/theme/colors.dart';
import 'package:agent_league/ui/project_screen/uploads_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import '../../components/custom_button.dart';
import '../../helper/constants.dart';
import 'dart:collection';

class Amenties extends StatefulWidget {
  final Map<String, dynamic> previousPageData;
  final Map<String, dynamic>? dataToEdit;
  final bool isFreeListing;

  const Amenties(
      {required this.previousPageData,
      required this.isFreeListing,
      this.dataToEdit,
      Key? key})
      : super(key: key);

  @override
  State<Amenties> createState() => _AmentiesState();
}

class _AmentiesState extends State<Amenties> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (context) =>
                  PropertyPhotosProvider(widget.dataToEdit?['images'])),
          ChangeNotifierProvider(
              create: (context) =>
                  PropertyDocumentsProvider(widget.dataToEdit?['docs'])),
          ChangeNotifierProvider(
              create: (context) =>
                  PropertyVideoProvider(widget.dataToEdit?['videos'])),
        ],
        builder: (context, child) {
          final _imageProvider =
              Provider.of<PropertyPhotosProvider>(context, listen: false);
          final _docProvider =
              Provider.of<PropertyDocumentsProvider>(context, listen: false);
          final _videoProvider =
              Provider.of<PropertyVideoProvider>(context, listen: false);

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
                                                      Navigator.pop(context);
                                                    },
                                                    color: CustomColors.dark)
                                                .use(),
                                            const SizedBox(width: 15),
                                            CustomButton(
                                                    text: 'Next',
                                                    onClick: () {
                                                      final images =
                                                          _imageProvider
                                                                  .getImage()[
                                                              'images'];

                                                      final docs = _docProvider
                                                          .getDocs()['docs'];

                                                      final videos =
                                                          _videoProvider
                                                                  .getVideos()[
                                                              'videos'];
                                                      checkAndUploadProperty(
                                                          images!,
                                                          docs!,
                                                          videos!);
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

  void checkAndUploadProperty(
      List<dynamic> images, List<dynamic> docs, List<dynamic> videos) {
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
        fileVideos.add(videos[i] as File);
        fileVideosIndex.add(i);
      }
    }

    if (images[0] != null && docs[0] != null && videos[0] != null) {
      Navigator.pushNamed(context, RouteName.uploadingProgress, arguments: [
        widget.previousPageData,
        widget.dataToEdit,
        widget.isFreeListing,
        fileImages,
        fileDocs,
        fileVideos,
        fileImagesIndex,
        fileDocsIndex,
        fileVideosIndex
      ]);
    } else {
      EasyLoading.showToast('First Item in each block should be uploaded');
    }
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
