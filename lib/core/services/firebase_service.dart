import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  init() {
    signInAnonimously();
  }

  signInAnonimously() async {
    await FirebaseAuth.instance.signInAnonymously();
  }
}
