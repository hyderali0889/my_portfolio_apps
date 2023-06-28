import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:tik_tak_toe/Models/users.dart';
import 'package:tik_tak_toe/main.dart';
import 'package:tik_tak_toe/objectbox.g.dart';
import '../Theme/main_colors.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Box<User> userData = objectBox.store.box<User>();
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
                    padding: const EdgeInsets.all(8.0),
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
                            "Statistics",
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
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Container(
                      width: size.width * 0.8,
                      height: size.height * 0.5,
                      decoration: BoxDecoration(
                          border: Border.all(color: MainColors.white, width: 3),
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: ListView(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Games Played vs Computer : "),
                                Text(
                                    "${userData.get(1)!.gamesPlayedvsComputer}")
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 15.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Games Played vs Players : "),
                                  Text(
                                      "${userData.get(1)!.gamesPlayedvsPlayer}")
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Games Won vs Computer : "),
                                Text("${userData.get(1)!.gamesWonvsComputer}")
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 15.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Games Won vs Player : "),
                                  Text("${userData.get(1)!.gamesWonvsPlayer}")
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Most Consective Wins: "),
                                Text("${userData.get(1)!.consectiveWins}")
                              ],
                            ),
                          ],
                        ),
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
