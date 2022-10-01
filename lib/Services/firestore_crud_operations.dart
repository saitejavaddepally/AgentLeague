import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreCrudOperations {
//  getPlotInformation() {}

//  postPlotInformation() {}

  // Future<void> updatePlotInformation(
  //     int plotNo, Map<String, dynamic> data) async {
  //   String? userId = await SharedPreferencesHelper().getUserId();
  //   CollectionReference ref;
  //   ref = FirebaseFirestore.instance
  //       .collection("sell_plots")
  //       .doc(userId)
  //       .collection("standlone")
  //       .doc('plot_$plotNo')
  //       .collection('pages_info');
  //   QuerySnapshot plotDocuments = await ref.get();
  //   final allData = plotDocuments.docs.map((doc) => doc.id).toList();
  //   await ref.doc(allData[0]).update(data);
  // }

  // deletePlotInformation() {}

  Future<void> updateProjectInformation(
      String projectId, Map<String, dynamic> data) async {
    DocumentReference ref;
    ref = FirebaseFirestore.instance.collection("projects").doc(projectId);
    await ref.update(data);
  }
}
