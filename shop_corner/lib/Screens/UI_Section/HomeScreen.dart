// ignore_for_file: file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shop_corner/Screens/Login_Section/SelectionScreen.dart';
import 'package:shop_corner/Utils/firebase_functions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(onPressed: ()=> signOut(), child: const Text("Sign Out"))
          ],
        ),
      ),
    );
  }

  //
  signOut() async {
    await FirebaseFunctions().signOut();
    if (FirebaseAuth.instance.currentUser == null) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const SelectionScreen()),
          (route) => false);
    }
  }
}
