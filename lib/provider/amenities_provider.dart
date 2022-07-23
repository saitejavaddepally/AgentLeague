import 'dart:collection';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_document_picker/flutter_document_picker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';

class AmenitiesProvider extends ChangeNotifier {
  bool _gyms = false;
  bool _automation = false;
  bool _elevator = false;
  bool _pipedGas = false;
  bool _balcony = false;
  bool _boreWater = false;
  bool _servant = false;
  bool _backup = false;
  bool _gated = false;
  bool _municipalWater = false;

  bool get gyms => _gyms;

  get automation => _automation;

  get elevator => _elevator;

  get pipedGas => _pipedGas;

  get balcony => _balcony;

  get boreWater => _boreWater;

  get servant => _servant;

  get backup => _backup;

  get gated => _gated;

  get municipalWater => _municipalWater;

  void toggleGyms() {
    _gyms = !_gyms;
    notifyListeners();
  }

  void toggleAutomation() {
    _automation = !_automation;
    notifyListeners();
  }

  void toggleElevator() {
    _elevator = !_elevator;
    notifyListeners();
  }

  void togglePipedGas() {
    _pipedGas = !_pipedGas;
    notifyListeners();
  }

  void toggleBalcony() {
    _balcony = !_balcony;
    notifyListeners();
  }

  void toggleBoreWater() {
    _boreWater = !_boreWater;
    notifyListeners();
  }

  void toggleServant() {
    _servant = !_servant;
    notifyListeners();
  }

  void toggleBackup() {
    _backup = !_backup;
    notifyListeners();
  }

  void toggleGated() {
    _gated = !_gated;
    notifyListeners();
  }

  void toggleMunicipalWater() {
    _municipalWater = !_municipalWater;
    notifyListeners();
  }
}

getFileSize(File file) {
  final bytes = file.readAsBytesSync().lengthInBytes;
  final kb = bytes / 1024;
  final mb = kb / 1024;

  return mb;
}

class PropertyPhotosProvider extends ChangeNotifier {
  PropertyPhotosProvider(List? images) {
    if (images != null) {
      _images = images;
    }
  }

  List<dynamic> _images = List.generate(8, (index) => null);

  UnmodifiableListView<dynamic> get images => UnmodifiableListView(_images);

  void pickImage(int index) async {
    final image = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (image == null) return;

    final imageTemporary = File(image.path);

    print("size is " + getFileSize(imageTemporary).toString());
    if (getFileSize(imageTemporary) < .5) {
      _images[index] = imageTemporary;
    } else {
      EasyLoading.showInfo("Image size is greater than 500 kb",
          duration: const Duration(seconds: 2));
    }

    notifyListeners();
  }

  void reset() {
    _images = List.generate(8, (index) => null);
    notifyListeners();
  }
}

class PropertyDocumentsProvider extends ChangeNotifier {
  PropertyDocumentsProvider(List? data, List? dataNames) {
    if (data != null && dataNames != null) {
      _docs = data;
      _docNames = dataNames;
    }
  }

  List<dynamic> _docs = List.generate(4, (index) => null);
  List<dynamic> _docNames = List.generate(4, (index) => null);

  UnmodifiableListView<dynamic> get docs => UnmodifiableListView(_docs);

  UnmodifiableListView<dynamic> get docNames => UnmodifiableListView(_docNames);

  void pickDocuments(int index) async {
    final path = await FlutterDocumentPicker.openDocument();

    if (path == null) return;
    final docTemp = File(path);
    if (getFileSize(docTemp) < 1) {
      List splitPath = docTemp.path.split('/');
      _docNames[index] = splitPath[splitPath.length - 1];
      _docs[index] = docTemp;
    } else {
      EasyLoading.showInfo("Doc size is greater than 1 mb",
          duration: const Duration(seconds: 2));
    }

    notifyListeners();
  }

  void reset() {
    _docs = List.generate(4, (index) => null);
    notifyListeners();
  }
}

class PropertyVideoProvider extends ChangeNotifier {
  PropertyVideoProvider(List? data, List? dataNames) {
    if (data != null && dataNames != null) {
      _videos = data;
      _videoNames = dataNames;
    }
  }

  List<dynamic> _videos = List.generate(4, (index) => null);
  List<dynamic> _videoNames = List.generate(4, (index) => null);

  UnmodifiableListView<dynamic> get videos => UnmodifiableListView(_videos);

  UnmodifiableListView<dynamic> get videoNames =>
      UnmodifiableListView(_videoNames);

  void pickVideo(int index) async {
    final video = await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (video == null) return;

    final videoTemporary = File(video.path);

    if (getFileSize(videoTemporary) < 2) {
      List splitPath = videoTemporary.path.split('/');
      _videoNames[index] = splitPath[splitPath.length - 1];
      _videos[index] = videoTemporary;
    } else {
      EasyLoading.showInfo("Video size is greater than 2 mb",
          duration: const Duration(seconds: 2));
    }

    notifyListeners();
  }

  void reset() {
    _videos = List.generate(4, (index) => null);
    notifyListeners();
  }
}
