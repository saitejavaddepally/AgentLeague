import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LeadScreenMethods {
  static final _sellPlots = FirebaseFirestore.instance.collection('sell_plots');
  static final String? _userId = FirebaseAuth.instance.currentUser?.uid;
  static final _leadsBox = FirebaseFirestore.instance.collection('leads_box');
  static Future<List<List<String>>> getAllProperty() async {
    List<String> _propertyData = [];
    List<String> _propertyId = [];

    final _collRefStandlone = _sellPlots.doc(_userId).collection('standlone');
    final _querySnapPlot = await _collRefStandlone.get();
    for (int i = 0; i < _querySnapPlot.docs.length; i++) {
      final _id = _querySnapPlot.docs[i].id;
      final _data = _querySnapPlot.docs[i].data();
      final _propertyType = _data['propertyType'];
      final _propertySize = _data['size'];
      final _price = _data['price'];

      _propertyData.add("$_propertyType - $_propertySize - $_price/${i + 1}");
      _propertyId.add(_id);
    }

    return [_propertyData..insert(0, "All/0"), _propertyId..insert(0, "")];
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllLeads(
      String date, String status) {
    return _leadsBox
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('standlone')
        .where('isDelete', isEqualTo: false)
        .where('status', isEqualTo: (status == 'all') ? null : status)
        .orderBy('timestamp',
            descending: (date == 'Recent First') ? true : false)
        .snapshots();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getParticularLead(
      String docId, String date, String status) {
    return _leadsBox
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('standlone')
        .where('propertyId', isEqualTo: docId)
        .where('isDelete', isEqualTo: false)
        .where('status', isEqualTo: (status == 'all') ? null : status)
        .orderBy('timestamp',
            descending: (date == 'Recent First') ? true : false)
        .snapshots();
  }

  static Future<void> deleteLead(String leadId) async {
    await _leadsBox
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('standlone')
        .doc(leadId)
        .update({'isDelete': true});
  }

  static Future<void> updateLeadNotes(String leadId, String notes) async {
    await _leadsBox
        .doc(_userId)
        .collection('standlone')
        .doc(leadId)
        .update({'notes': notes});
  }

  static Future<String> getLeadNotes(String leadId) async {
    final docSnap =
        await _leadsBox.doc(_userId).collection('standlone').doc(leadId).get();
    return docSnap.data()?['notes'] ?? '';
  }

  static Future<void> changeLeadStatus(String leadId, String status) async {
    await _leadsBox
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('standlone')
        .doc(leadId)
        .update({'status': status});
  }
}
