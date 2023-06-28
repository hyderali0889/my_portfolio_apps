// ignore_for_file: file_names

import 'dart:io';

import 'package:cook_book/Theme/Sizes.dart';
import 'package:cook_book/Utils/GradientText.dart';
import 'package:flutter/material.dart';
import '../Theme/Colors.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.backgroundColor,
      body: Center(
          child: Container(
              height: MediaQuery.of(context).size.height * 0.9,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                  color: Color.foregroundColor,
                  borderRadius: BorderRadius.circular(14.0)),
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(
                                  color: Color.backgroundColor,
                                  borderRadius: BorderRadius.circular(14.0)),
                            ),
                            Image.asset(
                              'assets/images/main.png',
                              height: 120,
                              width: 120,
                            )
                          ],
                        ),
                        SizedBox(
                          width: Platform.isAndroid || Platform.isIOS
                              ? MediaQuery.of(context).size.width * 0.3
                              : MediaQuery.of(context).size.width * 0.5,
                          child: Center(
                            child: GradientText("Cook Book ",
                                style: TextStyle(
                                    fontSize:
                                        Platform.isAndroid || Platform.isIOS
                                            ? Sizes.lg
                                            : Sizes.mainHeadings),
                                gradient: LinearGradient(colors: [
                                  Color.simpleColor,
                                  Color.textColor,
                                  Color.headingColor
                                ])),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.5,
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 40.0),
                          child: Text(
                            "This app is made by Hayder Ali with ❤❤❤ and it contains a lot of recipes that will provide help to everyone in need of Cooking support "
                            "\n \n The main features of this app are  \n \n "
                            " 1. Simple Interface \n"
                            " 2. Interactive UI \n"
                            " 3. Big list of Countries and dishes \n"
                            " 4. Acurate Instructions \n"
                            " 5. Complete list of required Ingreidients \n"
                            " 6. Daily Recomendations \n"
                            " 7. Search by Name, Country , Ingredients or Recipe \n"
                            " 8. Very Few Ad Interactions \n",
                            style: TextStyle(
                                color: Color.simpleColor,
                                fontSize: Sizes.lg,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ))),
    );
  }
}
