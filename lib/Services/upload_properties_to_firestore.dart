import 'package:cloud_firestore/cloud_firestore.dart';

import '../helper/shared_preferences.dart';
import 'auth_methods.dart';

class UploadPropertiesToFirestore {
  Future getPlotStatus() async {
    String? userId = await SharedPreferencesHelper().getUserId();
    await AuthMethods().getUserId().then((value) async {
      CollectionReference ref = FirebaseFirestore.instance
          .collection("sell_plots")
          .doc(value)
          .collection("standlone");

      await ref.get().then((event) {
        if (event.docs.isEmpty) {
          SharedPreferencesHelper().saveCurrentPlot('plot_1');
        } else {
          int length = event.docs.length;
          print("length is $length");
          final List<DocumentSnapshot> documents = event.docs;
          var id = documents[length - 1].id.substring(5);
          int autoId = int.parse(id) + 1;
          SharedPreferencesHelper().saveCurrentPlot('plot_$autoId');
        }
      });
    });

    await SharedPreferencesHelper()
        .getCurrentPlot()
        .then((value) => print("value is $value"));
  }

  Future postPropertyPageOne(Map<String, dynamic> data) async {
    String? userId = await SharedPreferencesHelper().getUserId();

    SharedPreferencesHelper().getCurrentPlot().then((value) async {
      print("Current value is $value");
      CollectionReference ref;
      ref = FirebaseFirestore.instance
          .collection("sell_plots")
          .doc(userId)
          .collection("standlone");

      ref.doc(value).set({"data": 1});
      await ref.doc(value).collection("pages_info").add(data);
      print("I am Done here");
    });
  }
  //
  // Future postPropertyPageTwo(Map<String, dynamic> data) async {
  //   String? userId = await SharedPreferencesHelper().getUserId();
  //
  //   await SharedPreferencesHelper().getCurrentPlot().then((value) async {
  //     print("Posting property $value");
  //     FirebaseFirestore.instance
  //         .collection("sell_plots")
  //         .doc(userId)
  //         .collection("standlone")
  //         .doc(value)
  //         .collection("page_2")
  //         .add(data);
  //   });
  // }
}
