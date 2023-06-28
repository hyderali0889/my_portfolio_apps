import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:timer_snackbar/timer_snackbar.dart';

class FirebaseFunctions {
  var instance = FirebaseAuth.instance;

  signUp(String name, String email, String password, context) async {
    try {
    var result = await instance.createUserWithEmailAndPassword(
          email: email, password: password);
      if (result.user != null) {
        result.user?.updateDisplayName(name);
      }
    } catch (e) {
      timerSnackbar(
          backgroundColor: Colors.red,
          buttonLabel: "",
          context: context,
          contentText: "Please Check your Credentials",
          second: 2,
          afterTimeExecute: () {});
    }
  }

  signIn(String email, String password, context) async {
    try {
      await instance.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      timerSnackbar(
          backgroundColor: Colors.red,
          buttonLabel: "",
          context: context,
          contentText: "Please Check your Credentials",
          second: 2,
          afterTimeExecute: () {});
    }
  }

  signOut() async {
    await instance.signOut();
  }
}
