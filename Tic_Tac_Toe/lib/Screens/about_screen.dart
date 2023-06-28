import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../Theme/main_colors.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: MainColors.lightBlue,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [MainColors.lightBlue, MainColors.darkBlue],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight)),
          height: size.height,
          width: size.width,
          child: Stack(
            children: [
              Positioned(
                  left: -150,
                  top: 40,
                  child: Opacity(
                    opacity: 0.4,
                    child: Image.asset(
                      'assets/imgs/back1.png',
                      width: 350,
                      height: 350,
                    ),
                  )),
              Positioned(
                  right: -150,
                  top: 150,
                  child: Opacity(
                    opacity: 0.4,
                    child: Image.asset(
                      'assets/imgs/back2.png',
                      width: 350,
                      height: 350,
                    ),
                  )),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: FaIcon(
                              FontAwesomeIcons.solidArrowLeft,
                              color: MainColors.white,
                            )),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            "About",
                            style: TextStyle(
                                color: MainColors.white,
                                fontSize: 25,
                                fontFamily: "Bold"),
                          ),
                        ),
                        Container()
                      ],
                    ),
                  ),
                  Container(
                    width: size.width * 0.8,
                    height: size.height * 0.7,
                    decoration: BoxDecoration(
                        border: Border.all(color: MainColors.white, width: 2),
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Game Developed By:",
                                  style: TextStyle(
                                      color: MainColors.white,
                                      fontSize: 20,
                                      fontFamily: "Bold"),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Text("Hayder Ali",
                                      style: TextStyle(
                                          color: MainColors.white,
                                          fontSize: 20,
                                          fontFamily: "Bold")),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 40.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Technologies Used :",
                                  style: TextStyle(
                                      color: MainColors.white,
                                      fontSize: 20,
                                      fontFamily: "Bold"),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: Text(
                                        "Flutter",
                                        style: TextStyle(
                                            color: MainColors.white,
                                            fontSize: 20,
                                            fontFamily: "Bold"),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10.0),
                                      child: Text(
                                        "Get X",
                                        style: TextStyle(
                                            color: MainColors.white,
                                            fontSize: 20,
                                            fontFamily: "Bold"),
                                      ),
                                    ),
                                    Text(
                                      "Font Awesome",
                                      style: TextStyle(
                                          color: MainColors.white,
                                          fontSize: 20,
                                          fontFamily: "Bold"),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10.0),
                                      child: Text(
                                        "Google Fonts",
                                        style: TextStyle(
                                            color: MainColors.white,
                                            fontSize: 20,
                                            fontFamily: "Bold"),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 40.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Available For :",
                                  style: TextStyle(
                                      color: MainColors.white,
                                      fontSize: 20,
                                      fontFamily: "Bold"),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: Text(
                                        "Android",
                                        style: TextStyle(
                                            color: MainColors.white,
                                            fontSize: 20,
                                            fontFamily: "Bold"),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10.0),
                                      child: Text(
                                        "Windows",
                                        style: TextStyle(
                                            color: MainColors.white,
                                            fontSize: 20,
                                            fontFamily: "Bold"),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
