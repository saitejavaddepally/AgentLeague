import 'dart:collection';
import 'dart:io';

import 'package:flutter/foundation.dart';
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

class PropertyPhotosProvider extends ChangeNotifier {
  List<File?> _images = List.generate(5, (index) => null);

  UnmodifiableListView<File?> get images => UnmodifiableListView(_images);

  void pickImage(int index) async {
    final image = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (image == null) return;

    final imageTemporary = File(image.path);
    _images[index] = imageTemporary;
    notifyListeners();
  }

  void reset() {
    _images = List.generate(5, (index) => null);
    notifyListeners();
  }
}

class PropertyDocumentsProvider extends ChangeNotifier {
  List<File?> _images = List.generate(5, (index) => null);

  UnmodifiableListView<File?> get images => UnmodifiableListView(_images);

  void pickImage(int index) async {
    final image = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (image == null) return;

    final imageTemporary = File(image.path);
    _images[index] = imageTemporary;
    notifyListeners();
  }

  void reset() {
    _images = List.generate(5, (index) => null);
    notifyListeners();
  }
}

class PropertyVideoProvider extends ChangeNotifier {
  List<File?> _videos = List.generate(5, (index) => null);

  UnmodifiableListView<File?> get videos => UnmodifiableListView(_videos);

  void pickVideo(int index) async {
    final video = await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (video == null) return;

    final videoTemporary = File(video.path);
    _videos[index] = videoTemporary;
    notifyListeners();
  }

  void reset() {
    _videos = List.generate(5, (index) => null);
    notifyListeners();
  }
}
