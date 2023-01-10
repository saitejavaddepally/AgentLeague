import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'package:webview_flutter/webview_flutter.dart';

// Import for Android features.
// Import for iOS features.

class Layout extends StatefulWidget {
  const Layout({Key? key}) : super(key: key);

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
      body: SafeArea(
          child: WebViewWidget(
        controller: WebViewController()
          ..enableZoom(true)
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..loadRequest(Uri.parse('https://plothub.azurewebsites.net')),
      )),
    );
  }
}
