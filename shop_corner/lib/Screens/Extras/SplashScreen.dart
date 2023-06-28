// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:shop_corner/Screens/Login_Section/SelectionScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1500), () {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const SelectionScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [HexColor("#667EEA"), HexColor("#64B6FF")],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Image.asset("assets/images/Logo.png"),
          const CircularProgressIndicator.adaptive(
            backgroundColor: Colors.white,
          ),
        ]),
      ),
    );
  }
}
