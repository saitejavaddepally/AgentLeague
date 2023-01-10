import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LeadScreenMethods {
  static final _sellPlots = FirebaseFirestore.instance.collection('sell_plots');
  static final String? _userId = FirebaseAuth.instance.currentUser?.uid;
  static final _leadsBox = FirebaseFirestore.instance.collection('leads_box');
  static Future<List<List<String>>> getAllProperty() async {
    List<String> propertyData = [];
    List<String> propertyId = [];

    final collRefStandlone = _sellPlots.doc(_userId).collection('standlone');
    final querySnapPlot = await collRefStandlone.get();
    for (int i = 0; i < querySnapPlot.docs.length; i++) {
      final id = querySnapPlot.docs[i].id;
      final data = querySnapPlot.docs[i].data();
      final propertyType = data['propertyType'];
      final propertySize = data['size'];
      final price = data['price'];

      propertyData.add("$propertyType - $propertySize - $price/${i + 1}");
      propertyId.add(id);
    }

    return [propertyData..insert(0, "All/0"), propertyId..insert(0, "")];
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
