import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Utils {
  static String formatTimestamp(Timestamp? timestamp) {
    if (timestamp != null) {
      var format = DateFormat('d-MM-y h:mm:a'); // <- use skeleton here
      return format.format(timestamp.toDate());
    }
    return "";
  }
}
