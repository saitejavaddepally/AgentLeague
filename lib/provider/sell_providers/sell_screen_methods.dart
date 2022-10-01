import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:collection/collection.dart';

class SellScreenMethods {
  static final String? _userId = FirebaseAuth.instance.currentUser?.uid;
  static final _users = FirebaseFirestore.instance.collection('users');
  static final _sellPlots = FirebaseFirestore.instance.collection('sell_plots');

  static Future<num> plotCreditChecker() async {
    final docSnap = await _users.doc(_userId).get();

    return docSnap.data()?['freeCredit'] ?? 0;
  }

  static Future decrementFreeCredit() async {
    await _users.doc(_userId).update({'freeCredit': FieldValue.increment(-1)});
  }

  static Future updatePropertyBoxEnable(String id) async {
    await _sellPlots
        .doc(_userId)
        .collection('standlone')
        .doc(id)
        .update({'box_enabled': 1});
  }

  static Future decrementPropertyBoxFreeCredit() async {
    await _users
        .doc(_userId)
        .update({'freeCreditPropertyBox': FieldValue.increment(-1)});
  }

  static Future<num> getPropertyBoxFreeCredit() async {
    final docSnap = await _users.doc(_userId).get();
    return docSnap.data()?['freeCreditPropertyBox'] ?? 0;
  }

  static Future<Map<String, dynamic>?> getParticularPropertyDetail(
      String docId) async {
    final docSnap =
        await _sellPlots.doc(_userId).collection('standlone').doc(docId).get();
    final data = docSnap.data();
    data?.addAll({'id': docSnap.id});
    return data;
  }

  static Future<List<Map<String, dynamic>>> getAllUnpaidProperty() async {
    final querySnap = await _sellPlots
        .doc(_userId)
        .collection('standlone')
        .where('isPaid', isEqualTo: false)
        .get();

    return querySnap.docs.map((e) => e.data()).toList();
  }

  static Future<void> deleteProperty(String id) async {
    List<Reference> reference = [];
    await _sellPlots.doc(_userId).collection('standlone').doc(id).delete();
    final images = await FirebaseStorage.instance
        .ref('sell_plot/$_userId/standlone/$id/images/')
        .listAll();
    reference.addAll(images.items);

    final docs = await FirebaseStorage.instance
        .ref('sell_plot/$_userId/standlone/$id/docs/')
        .listAll();
    reference.addAll(docs.items);

    final videos = await FirebaseStorage.instance
        .ref('sell_plot/$_userId/standlone/$id/videos/')
        .listAll();
    reference.addAll(videos.items);

    Future.wait(reference.map((e) => e.delete()));
  }

  static Future<Map<String, dynamic>> getDataToEditProperty(String id) async {
    String path = 'sell_plot/$_userId/standlone/$id';
    List image = List.generate(8, (index) => null);
    final imageListResult =
        await FirebaseStorage.instance.ref('$path/images/').listAll();

    for (final item in imageListResult.items) {
      final int index = int.parse(item.name.split(' ')[1]);
      final url = await item.getDownloadURL();
      image[index - 1] = url;
    }

    List video = List.generate(4, (index) => null);
    final videoListResult =
        await FirebaseStorage.instance.ref('$path/videos/').listAll();

    for (final item in videoListResult.items) {
      final int index = int.parse(item.name.split(' ')[1]);
      final url = await item.getDownloadURL();
      video[index - 1] = url;
    }

    List docs = List.generate(4, (index) => null);
    final docsListResult =
        await FirebaseStorage.instance.ref('$path/docs/').listAll();

    for (final item in docsListResult.items) {
      final int index = int.parse(item.name.split(' ')[1]);
      final url = await item.getDownloadURL();
      docs[index - 1] = url;
    }
    final docSnap =
        await _sellPlots.doc(_userId).collection('standlone').doc(id).get();
    final data = docSnap.data()!;

    data['images'] = image;
    data['docs'] = docs;
    data['videos'] = video;
    data['id'] = id;
    return data;
  }

  static Future<List<Map<String, dynamic>>> getPropertyRange(
      List<num> ranges) async {
    final querySnap = await _sellPlots
        .doc(_userId)
        .collection('standlone')
        .where('price',
            isGreaterThanOrEqualTo: ranges[0], isLessThanOrEqualTo: ranges[1])
        .get();

    return querySnap.docs.map((e) => e.data()..addAll({'id': e.id})).toList();
  }
}
