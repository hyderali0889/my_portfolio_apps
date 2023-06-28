// ignore_for_file: file_names, use_build_context_synchronously

import 'dart:async';
import 'dart:io';
import 'package:cook_book/Screens/NoConnection.dart';
import 'package:cook_book/Theme/Sizes.dart';
import 'package:cook_book/Utils/ApiCall.dart';
import 'package:cook_book/Utils/GradientText.dart';
import 'package:flutter/material.dart';
import '../Theme/Colors.dart';
import '../components/AppBar.dart';

import '../components/Navigation.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  List<String> connectedTexts = [
    " Checking your Internet Connection ",
    " This is taking a very long time, \n Please check you Internet connection and try again. "
  ];

  int currentid = 0;
  late Timer t;

  @override
  void initState() {
    super.initState();
    checkConnection();
    changeText();
  }

  changeText() {
    if (mounted) {
      t = Timer(const Duration(seconds: 5), () {
        setState(() {
          currentid = 1;
        });
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    t.cancel();
  }

  checkConnection() async {
    bool isConnected = await FetchApi().checkNetwork();

    if (isConnected == true) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Navigation()));
    } else {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const NotConnected()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.backgroundColor,
      body: Column(
        children: [
          Platform.isAndroid || Platform.isIOS
              ? Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).viewPadding.top))
              : TitleBar().mainAppBar(),
          Container(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
            child: Center(
                child: GradientText(
              "CookBook",
              style: TextStyle(
                fontSize: Sizes.mainHeadings,
              ),
              gradient: LinearGradient(colors: [
                Color.textColor,
                Color.foregroundColor,
              ]),
            )),
          ),
          Expanded(
            child: Center(
              child: Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.1),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset("assets/gifs/loader.gif"),
                    Text(
                      connectedTexts[currentid],
                      style:
                          TextStyle(color: Color.textColor, fontSize: Sizes.lg),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
