import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Utils {
  static String formatTimestamp(Timestamp timestamp) {
    // return DateFormat().add_yMd().add_jm().format(timestamp.toDate());
    var format = DateFormat('d-MM-y h:mm:a'); // <- use skeleton here
    return format.format(timestamp.toDate());
  }
}
