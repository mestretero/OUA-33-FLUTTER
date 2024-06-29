// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:stacked_services/stacked_services.dart';

class AuthServices {
  static final auth = FirebaseAuth.instance;
  get user => auth.currentUser;

  getAuthStateChanges() {
    return FirebaseAuth.instance.authStateChanges();
  }

  register(
    BuildContext context,
    String name,
    String email,
    String pass,
  ) async {
    // context.loaderOverlay.show();
    try {
      final userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );
      await userCredential.user?.updateDisplayName(name);
      NavigationService().back();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showMsg(context, 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        showMsg(context, 'The account already exists for that email.');
      } else {
        showMsg(context, e.message.toString());
      }
    }
    // context.loaderOverlay.hide();
  }

  login(BuildContext context, String email, String pass) async {
    // context.loaderOverlay.show();
    try {
      await auth.signInWithEmailAndPassword(
        email: email,
        password: pass,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
        showMsg(context, 'Invalid Email & Password');
      } else {
        showMsg(context, e.message.toString());
      }
    }
    // context.loaderOverlay.hide();
  }

  logOut() {
    FirebaseAuth.instance.signOut();
  }

  signInAnonimously() async {
    await FirebaseAuth.instance.signInAnonymously();
  }

  static showMsg(context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
}
