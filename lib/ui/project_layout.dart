import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ProjectLayout extends StatefulWidget {
  const ProjectLayout({Key? key}) : super(key: key);

  @override
  State<ProjectLayout> createState() => _ProjectLayoutState();
}

class _ProjectLayoutState extends State<ProjectLayout> {
  final _controller = PdfViewerController();
  final plots = ['Hi', 'Hello', 'How are you', 'Abcdef'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(children: [
          Expanded(
            child: Row(
              children: [
                Flexible(
                    flex: 1,
                    child: ListView.builder(
                      itemCount: plots.length,
                      itemBuilder: (context, index) => ListTile(
                        onTap: () {
                          _controller.searchText(
                            plots[index],
                          );
                        },
                        title: Text(plots[index]),
                      ),
                    )),
                Flexible(
                    flex: 3,
                    child: SfPdfViewer.asset('assets/pdf/plot_asset.pdf',
                        controller: _controller, initialZoomLevel: 1.5))
              ],
            ),
          ),
        ]),
      )),
    );
  }
}
