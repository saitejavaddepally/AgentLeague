import 'package:agent_league/components/custom_title.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../theme/colors.dart';

class Layout extends StatefulWidget {
  final List docs;
  const Layout({required this.docs, Key? key}) : super(key: key);

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CustomColors.dark,
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.keyboard_backspace_rounded,
                      color: Colors.white)),
              GestureDetector(
                  onTap: () {}, child: Image.asset('assets/notific.png'))
            ]),
            const SizedBox(height: 30),
            if (widget.docs[0] == null)
              const CustomTitle(text: 'No layout available'),
            if (widget.docs[0] != null)
              Flexible(
                  child: ListView.builder(
                      itemCount: widget.docs.length,
                      itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.only(bottom: 30.0),
                            child: Neumorphic(
                              padding: const EdgeInsets.all(7),
                              style: NeumorphicStyle(
                                  shape: NeumorphicShape.flat,
                                  color: CustomColors.dark,
                                  boxShape: NeumorphicBoxShape.roundRect(
                                      BorderRadius.circular(12)),
                                  shadowLightColor: Colors.black),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: HexColor('1C1C1C'),
                                    borderRadius: BorderRadius.circular(12)),
                                child: ListTile(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SfPdfViewer.network(
                                                    widget.docs[index],
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
                                          color: CustomColors.orange),
                                    ),
                                    subtitle: const Text(
                                      'Layout',
                                      style: TextStyle(
                                          height: 1.3,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                          letterSpacing: -0.15,
                                          color: Colors.white),
                                    ),
                                    trailing: (isChecked)
                                        ? Image.asset('assets/checked.png')
                                        : Image.asset('assets/unchecked.png')),
                              ),
                            ),
                          )))
          ]),
        )));
  }
}
