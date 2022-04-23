import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  getCurrentUser() async {
    // ignore: await_only_futures
    return await _auth.currentUser;
  }

// sign in with phone
  late String smsOTP;
  late String verificationId;
  String errorMessage = '';
  void signInWithPhoneNumber(String mobileNumber) async{

  }
}
