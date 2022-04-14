import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> getCurrentUser() async {
    // ignore: await_only_futures
    return await _auth.currentUser;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
