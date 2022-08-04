import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../helper/constants.dart';
import '../helper/shared_preferences.dart';
import '../provider/firestore_data_provider.dart';
import '../theme/colors.dart';

class Documents extends StatefulWidget {
  final Map info;

  const Documents({Key? key, required this.info}) : super(key: key);

  @override
  State<Documents> createState() => _DocumentsState();
}

class _DocumentsState extends State<Documents> {
  bool isChecked = false;
  late List res;

  Future<List> getDocuments() async {
    int currentPlot = widget.info['currentPage'];
    List docs = widget.info['plotPagesInformation'][currentPlot][0]['docs'];
    List docNames = widget.info['plotPagesInformation'][currentPlot][0]['docNames'];


    return [
      {"docs": docs},
      {"docNames": docNames}
    ];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getDocuments(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          res = snapshot.data as List;
        }
        if (snapshot.connectionState != ConnectionState.done) {
          return const SpinKitThreeBounce(
            size: 30,
            color: Colors.white,
          );
        }
        print("documents are $res");
        return Scaffold(
            body: SafeArea(
                child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.keyboard_backspace_rounded)),
              GestureDetector(
                  onTap: () {}, child: Image.asset('assets/notific.png'))
            ]),
            const SizedBox(height: 30),
            Flexible(
                child: ListView.builder(
                    itemCount: res[0]['docs'].length,
                    itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.only(bottom: 30.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: shadow2,
                                borderRadius: BorderRadius.circular(12)),
                            child: (res[0]['docs'][index] != null || res[0]['docs'][index] != "null")
                                ? ListTile(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SfPdfViewer.network(
                                                    res[0]['docs'][index],
                                                    canShowPaginationDialog:
                                                        true,
                                                    canShowScrollHead: true,
                                                    canShowPasswordDialog: true,
                                                    canShowScrollStatus: true,
                                                    enableDoubleTapZooming:
                                                        true,
                                                    onDocumentLoadFailed:
                                                        (details) {
                                                      print(details.error);
                                                    },
                                                  )));
                                    },
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 15),
                                    horizontalTitleGap: 10,
                                    leading: Image.asset(
                                        'assets/document_image.png'),
                                    title: Text(
                                      'verified',
                                      style: TextStyle(
                                          height: 1.5,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12,
                                          letterSpacing: -0.15,
                                          color: HexColor('FE7F0E')),
                                    ),
                                    subtitle: Text(
                                      res[1]['docNames'][index],
                                      style: TextStyle(
                                          height: 1.3,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                          letterSpacing: -0.15,
                                          color: HexColor('1B1B1B')),
                                    ),
                                    trailing: (isChecked)
                                        ? Image.asset('assets/checked.png')
                                        : Image.asset('assets/unchecked.png'))
                                : const SizedBox(),
                          ),
                        )))
          ]),
        )));
      },
    );
  }
}
