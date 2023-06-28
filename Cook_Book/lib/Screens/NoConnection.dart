// ignore_for_file: file_names

import 'dart:io';
import 'package:cook_book/Screens/SplashScreen.dart';
import 'package:cook_book/Theme/Sizes.dart';
import 'package:flutter/material.dart';
import '../Theme/Colors.dart';
import '../Theme/Spacing.dart';
import "package:hovering/hovering.dart";
import '../components/AppBar.dart';
import '../Theme/Sizes.dart';

class NotConnected extends StatefulWidget {
  const NotConnected({Key? key}) : super(key: key);

  @override
  State<NotConnected> createState() => _NotConnectedState();
}

class _NotConnectedState extends State<NotConnected> {
  @override
  Widget build(BuildContext context) {
    checkAgain() {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: ((context) => const SplashScreen())));
    }

    return Scaffold(
      backgroundColor: Color.backgroundColor,
      body: Column(
        children: [
          Platform.isAndroid || Platform.isIOS
              ? Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).viewPadding.top))
              : TitleBar().mainAppBar(),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: Spacing.sm),
                  child: Image.asset('assets/images/NotConnected.png'),
                ),
                Center(
                    child: Text(
                  "Not Connected",
                  style: TextStyle(
                      color: Color.textColor, fontSize: Sizes.headings),
                )),
                Padding(
                    padding: EdgeInsets.only(top: Spacing.sm),
                    child: HoverButton(
                      height: Spacing.xl,
                      minWidth: Spacing.xl * 5,
                      onpressed: checkAgain,
                      hoverColor: Color.iconColor,
                      color: Color.foregroundColor,
                      child: Text(
                        "Try Again",
                        style: TextStyle(
                            color: Color.textColor, fontSize: Sizes.md),
                      ),
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
