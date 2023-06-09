import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:taskly_new/screen/viewmodel.dart';

class AuthViewmodel extends Viewmodel {
  final credential = FirebaseAuth.instance;

  signUp(String email, String password) async {
    try {
      return credential.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      debugPrint(e.toString());
    }
  }

  login(String email, String password) async {
    try {
      return credential.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      debugPrint(e.toString());
    }
  }

  signOut() async {
    return credential.signOut();
  }
}
