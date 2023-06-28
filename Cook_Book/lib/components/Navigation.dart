// ignore_for_file: file_names

import 'dart:io';
import 'package:cook_book/Screens/AboutScreen.dart';
import 'package:cook_book/Screens/HomeSceen.dart';
import 'package:cook_book/Screens/SearchScreen.dart';
import 'package:cook_book/Theme/Colors.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'AppBar.dart';

class Navigation extends StatefulWidget {
  const Navigation({Key? key}) : super(key: key);

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int nav = 0;
  bool btn1 = false;
  bool btn2 = false;
  bool btn3 = false;
  var _selectedTab = 0;

  void _handleIndexChanged(int i) {
    setState(() {
      _selectedTab = i;
    });
  }

  List<Widget> linda = [
    const HomeScreen(),
    const SearchScreen(),
    const AboutScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body:
      //
      // ──────────────────────────────────────────────────────────────────── I ──────────
      //   :::::: A N D R O I D   W I D G E T : :  :   :    :     :        :          :
      // ──────────────────────────────────────────────────────────────────────────────
      //



      Platform.isAndroid || Platform.isIOS
          ? SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child:linda[_selectedTab])


              //
              // ──────────────────────────────────────────────────────────────────── I ──────────
              //   :::::: D E S K T O P   W I D G E T : :  :   :    :     :        :          :
              // ──────────────────────────────────────────────────────────────────────────────
              //


          : SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  TitleBar().mainAppBar(),
                  //
                  // ──────────────────────────────────────────────────────────────────────────── I ──────────
                  //   :::::: D E S K T O P   N A V I G A T I O N : :  :   :    :     :        :          :
                  // ──────────────────────────────────────────────────────────────────────────────────────
                  //


                  Expanded(
                      child: Row(
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height,
                          width: 50,
                          child: Container(
                            color: Color.foregroundColor,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 30.0),
                              child: Column(children: [


                                //
                                // ──────────────────────────────────────────────────────────────── I ──────────
                                //   :::::: M A I N   B T N   O N E : :  :   :    :     :        :          :
                                // ──────────────────────────────────────────────────────────────────────────
                                //

                                MouseRegion(
                                  onEnter: (e) {
                                    setState(() {
                                      btn1 = true;
                                    });
                                  },
                                  onExit: (e) {
                                    setState(() {
                                      btn1 = false;
                                    });
                                  },
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        nav = 0;
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Center(
                                        child: Icon(
                                          Icons.home_rounded,
                                          color: nav == 0
                                              ? Color.headingColor
                                              : !btn1
                                                  ? Color.backgroundColor
                                                  : Color.textColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

//
// ──────────────────────────────────────────────────────────── II ──────────
//   :::::: M A I N   B T N   2 : :  :   :    :     :        :          :
// ──────────────────────────────────────────────────────────────────────
//

                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 20.0),
                                  child: MouseRegion(
                                    onEnter: (e) {
                                      setState(() {
                                        btn2 = true;
                                      });
                                    },
                                    onExit: (e) {
                                      setState(() {
                                        btn2 = false;
                                      });
                                    },
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          nav = 1;
                                        });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Center(
                                          child: Icon(
                                            Icons.search,
                                            color: nav == 1
                                                ? Color.headingColor
                                                : !btn2
                                                    ? Color.backgroundColor
                                                    : Color.textColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
//
// ──────────────────────────────────────────────────────────── III ──────────
//   :::::: M A I N   B T N   3 : :  :   :    :     :        :          :
// ──────────────────────────────────────────────────────────────────────
//

                                MouseRegion(
                                  onEnter: (e) {
                                    setState(() {
                                      btn3 = true;
                                    });
                                  },
                                  onExit: (e) {
                                    setState(() {
                                      btn3 = false;
                                    });
                                  },
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        nav = 2;
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Center(
                                        child: Icon(
                                          Icons.person,
                                          color: nav == 2
                                              ? Color.headingColor
                                              : !btn3
                                                  ? Color.backgroundColor
                                                  : Color.textColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                            ),
                          )),

                         //
                         // ──────────────────────────────────────────────────────────────────────────────── I ──────────
                         //   :::::: D E S K T O P   M A I N   S C R E E N S : :  :   :    :     :        :          :
                         // ──────────────────────────────────────────────────────────────────────────────────────────
                         //


                      Expanded(child: linda[nav]),
                    ],
                  )),
                ],
              ),
            ),

            //
            // ──────────────────────────────────────────────────────────────────────────── I ──────────
            //   :::::: A N D R O I D   N A V I G A T I O N : :  :   :    :     :        :          :
            // ──────────────────────────────────────────────────────────────────────────────────────
            //


      bottomNavigationBar: Platform.isAndroid || Platform.isIOS ?  DotNavigationBar(
        borderRadius: 12.0,
        backgroundColor: Color.foregroundColor,
        currentIndex: _selectedTab,
        onTap: _handleIndexChanged,
        paddingR: const EdgeInsets.all(0.0),
        items: [
          /// Home
          DotNavigationBarItem(
            icon: const Icon(Icons.home),
            selectedColor: Color.headingColor,
          ),

          /// Search
          DotNavigationBarItem(
            icon: const Icon(Icons.search),
            selectedColor: Color.headingColor,
          ),

          /// Profile
          DotNavigationBarItem(
            icon: const Icon(Icons.person),
            selectedColor: Color.headingColor,
          ),
        ],
      ) : null,
    );
  }
}
