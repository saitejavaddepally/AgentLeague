import 'dart:developer';

import 'package:agent_league/helper/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import '../theme/colors.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:math';

class GalleryScreen extends StatefulWidget {
  final Map info;

  const GalleryScreen({Key? key, required this.info}) : super(key: key);

  @override
  _GalleryScreenState createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  bool loading = false;
  late String currentPlot;
  late String plotStoragePath;
  List res = [];

  final String images = "IMAGES";
  final String videos = "VIDEOS";
  final String documents = "DOCUMENTS";

  @override
  void initState() {
    super.initState();
  }

  Future<void> getImages() async {
    if (widget.info['isProject']) {
      res = widget.info['projectDetails']['images'];
    } else {
      int currentPlot = widget.info['currentPage'];
      res = widget.info['plotPagesInformation'][currentPlot][0]['images'];
    }
  }

  Future urlToFile(String imageUrl) async {
    var rng = Random();
    final directory = await getApplicationDocumentsDirectory();
    String tempPath =
        directory.path + '/' + (rng.nextInt(100)).toString() + '.png';
    print("temp path is $tempPath");
    File file = File(tempPath);
    http.Response response = await http.get(Uri.parse(imageUrl));
    await file.writeAsBytes(response.bodyBytes);
    return tempPath;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: CustomColors.dark,
          leading: IconButton(
            padding: const EdgeInsets.only(left: 16),
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          elevation: 0,
          actions: [
            Container(
                margin: const EdgeInsets.only(right: 24),
                child:
                    IconButton(onPressed: () {}, icon: const Icon(Icons.share)))
          ],
        ),
        body: FutureBuilder(
            future: getImages(),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const SpinKitThreeBounce(
                  size: 30,
                  color: Colors.white,
                );
              }
              if (snapshot.hasData) {
                res = snapshot.data as List;
              }
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      for (var i = 0; i < res.length; i += 1)
                        (res[i] != null)
                            ? FutureBuilder(
                                future: urlToFile(res[i]),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState !=
                                      ConnectionState.done) {
                                    return const SpinKitCircle(
                                      size: 30,
                                      color: Colors.white,
                                    );
                                  }
                                  return GestureDetector(
                                    onTap: () async {
                                      String imagePath =
                                          snapshot.data as String;
                                      await OpenFile.open(imagePath);
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 250,
                                      margin: const EdgeInsets.only(bottom: 20),
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(res[i]),
                                              fit: BoxFit.fitWidth),
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          color: Colors.white),

                                      // child: Image.network(res[i], height: 200, width: MediaQuery.of(context).size.width, fit: BoxFit.fitWidth, ),
                                    ),
                                  );
                                })
                            : const SizedBox(),
                    ],
                  ),
                ),
              );
            }));
  }
}
