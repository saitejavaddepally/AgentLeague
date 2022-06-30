import 'dart:async';

import 'package:agent_league/Services/upload_properties_to_firestore.dart';
import 'package:agent_league/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class Success extends StatefulWidget {
  final Map<String, dynamic> data;

  const Success({Key? key, required this.data}) : super(key: key);

  @override
  State<Success> createState() => _SuccessState();
}

class _SuccessState extends State<Success> {
  bool isLoading = false;
  var timer = 3;
  late Timer _timer;
  int _start = 3;

  @override
  void initState() {
    print("data is ${widget.data}");
    final _images = widget.data['media']['images'];
    final _videos = widget.data['media']['videos'];
    final _docs = widget.data['media']['docs'];
    final _videoNames = widget.data['media']['videoNames'];
    final _docNames = widget.data['media']['docNames'];

    uploadDataToFireStore(
        _images, _videos, _docs, _docNames, _videoNames, widget.data);
    super.initState();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
            Navigator.pushNamedAndRemoveUntil(
                context, RouteName.bottomBar, (route) => false);
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  Future<void> uploadDataToFireStore(
    List<dynamic> _images,
    List<dynamic> _videos,
    List<dynamic> _docs,
    List<dynamic> _docNames,
    List<dynamic> _videoNames,
    var data,
  ) async {
    setState(() {
      isLoading = true;
    });
    print("The data is $data");
    await UploadPropertiesToFirestore().uploadData(_images, _videos, _docs,
        _docNames, _videoNames, false, data['propData']);
    setState(() {
      isLoading = false;
    });
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          Navigator.pushNamedAndRemoveUntil(
              context, RouteName.bottomBar, (route) => false);
          return true;
        },
        child: Scaffold(
          body: (!isLoading)
              ? Center(
                  child: Text(
                    'Payment Successful you will be redirected in $_start seconds ',
                  ),
                )
              : const Center(child: CircularProgressIndicator()),
        ));
  }
}
