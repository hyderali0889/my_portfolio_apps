import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:tik_tak_toe/Screens/about_screen.dart';
import 'package:tik_tak_toe/Screens/sign_selection.dart';
import 'package:tik_tak_toe/Screens/stats_screen.dart';
import 'package:tik_tak_toe/Theme/main_colors.dart';

import '../Components/main_components.dart';
import '../Models/users.dart';
import '../main.dart';
import '../objectbox.g.dart';

class GameSelection extends StatefulWidget {
  const GameSelection({super.key});

  @override
  State<GameSelection> createState() => _GameSelectionState();
}

class _GameSelectionState extends State<GameSelection> {
  Box<User> userData = objectBox.store.box<User>();
  TextEditingController nameController = TextEditingController();

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
                  SizedBox(
                    height: size.height * 0.3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MainComponents().upperRowButton(
                                  FontAwesomeIcons.lightCog, () {
                                MainComponents().showADialog(
                                    context,
                                    settings(size, context, nameController,
                                        userData),
                                    size);
                              }),
                              Row(
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: MainComponents().upperRowButton(
                                          FontAwesomeIcons.lightChartBar, () {
                                        Get.to(() => const StatsScreen());
                                      })),
                                  MainComponents().upperRowButton(
                                      FontAwesomeIcons.lightShield, () {
                                    MainComponents().showAchDialog(context,
                                        achievments(userData, size), size);
                                  })
                                ],
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              "Welcome \n ${userData.get(1)!.name.toUpperCase()}",
                              style: TextStyle(
                                  color: MainColors.white,
                                  fontSize: 32,
                                  fontFamily: 'Bold'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MainComponents().mainButton(size, Colors.red.shade600,
                            () {
                          Get.offAll(
                              () => const SignSelection(singleGame: true));
                        }, FontAwesomeIcons.lightGamepad, "Single Player Game"),
                        MainComponents().mainButton(size, Colors.green.shade600,
                            () {
                          Get.offAll(
                              () => const SignSelection(singleGame: false));
                        }, FontAwesomeIcons.lightGameBoard,
                            "Multi Player Game"),
                        MainComponents().mainButton(size, Colors.blue.shade600,
                            () {
                          Get.to(() => const StatsScreen());
                        }, FontAwesomeIcons.lightChartBar, "Statistics"),
                        MainComponents()
                            .mainButton(size, Colors.purple.shade600, () {
                          Get.to(() => const AboutScreen());
                        }, FontAwesomeIcons.lightWalking, "About")
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget settings(size, context, nameController, userData) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Center(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Settings",
              style: TextStyle(
                  color: MainColors.white, fontSize: 20, fontFamily: "Bold")),
        )),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MainComponents().mainButton(size, Colors.brown.shade600, () {
                Get.back();
                MainComponents().showADialog(
                    context, updateName(size, nameController, userData), size);
              }, FontAwesomeIcons.lightSignature, "Update Name"),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child:
                    MainComponents().mainButton(size, Colors.grey.shade600, () {
                  MainComponents().confirmation(
                      context, "Are you sure you wanna reset the Stats", () {
                    User userDetails = User(
                        id: 1,
                        name: userData.get(1).name,
                        gamesPlayedvsComputer: 0,
                        gamesPlayedvsPlayer: 0,
                        gamesWonvsComputer: 0,
                        gamesWonvsPlayer: 0,
                        consectiveWins: 0);

                    userData.put(userDetails);
                    Get.back();
                    Get.back();
                  });
                }, FontAwesomeIcons.lightBracketsCurly, "Reset Statstics"),
              ),
              MainComponents().mainButton(size, Colors.purple.shade600, () {
                Get.back();
                Get.to(() => const AboutScreen());
              }, FontAwesomeIcons.lightWreath, "Credits"),
            ],
          ),
        ),
      ],
    );
  }

  Widget updateName(size, nameController, userData) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Center(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Update Name",
              style: TextStyle(
                  color: MainColors.white, fontSize: 20, fontFamily: "Bold")),
        )),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                onSubmitted: (val) {
                  if (nameController.text.isEmpty) {
                    return;
                  }
                  User userDetails = User(
                      id: 1,
                      name: val.trim(),
                      gamesPlayedvsComputer: 0,
                      gamesPlayedvsPlayer: 0,
                      gamesWonvsComputer: 0,
                      gamesWonvsPlayer: 0,
                      consectiveWins: 0);
                  userData.put(userDetails);
                  Get.offAll(() => const GameSelection());
                },
                controller: nameController,
                decoration: InputDecoration(
                  hintText: "Please Enter Name",
                  hintStyle: const TextStyle(
                    color: Colors.white54,
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14.0),
                      borderSide:
                          const BorderSide(color: Colors.black, width: 2)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14.0),
                      borderSide:
                          const BorderSide(color: Colors.black, width: 2)),
                ),
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child:
                    MainComponents().mainButton(size, Colors.red.shade600, () {
                  if (nameController.text.isEmpty) {
                    return;
                  }

                  User userDetails = User(
                      id: 1,
                      name: nameController.text.trim(),
                      gamesPlayedvsComputer: 0,
                      gamesPlayedvsPlayer: 0,
                      gamesWonvsComputer: 0,
                      gamesWonvsPlayer: 0,
                      consectiveWins: 0);
                  userData.put(userDetails);
                  Get.offAll(() => const GameSelection());
                }, FontAwesomeIcons.lightSignature, "Update Name"),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget achievments(userData, size) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 25.0),
          child: Center(
            child: Text("Achievments",
                style: TextStyle(
                    color: MainColors.white, fontSize: 20, fontFamily: "Bold")),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 25.0),
          child: Text("Single Player",
              style: TextStyle(
                  color: MainColors.white, fontSize: 18, fontFamily: "Bold")),
        ),
        MainComponents().achContainer(
            size,
            "${userData.get(1).gamesWonvsComputer} / 3 Games Won",
            Colors.red.shade600,
            Colors.purple.shade600,
            "Beginner",
            "Win 3 Games \nAgainst Computer"),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: MainComponents().achContainer(
              size,
              "${userData.get(1).gamesWonvsComputer} / 6 Games Won",
              Colors.green.shade600,
              Colors.indigo.shade600,
              "Starter",
              "Win 6 Games \nAgainst Computer"),
        ),
        MainComponents().achContainer(
            size,
            "${userData.get(1).gamesWonvsComputer} / 9 Games Won",
            Colors.red.shade600,
            Colors.pink.shade600,
            "Expert",
            "Win 9 Games \nAgainst Computer"),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: MainComponents().achContainer(
              size,
              "${userData.get(1).gamesWonvsComputer} / 3 Games Won",
              Colors.teal.shade600,
              Colors.orange.shade600,
              "Fast Winner",
              "Win 3 \nConsective Games"),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 25.0),
          child: Text("Multi Player",
              style: TextStyle(
                  color: MainColors.white, fontSize: 18, fontFamily: "Bold")),
        ),
        MainComponents().achContainer(
            size,
            "${userData.get(1).gamesWonvsPlayer} / 3 Games Won",
            Colors.cyan.shade600,
            Colors.black54,
            "Beginner",
            "Win 3 Games \nAgainst Person"),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: MainComponents().achContainer(
              size,
              "${userData.get(1).gamesWonvsPlayer} / 6 Games Won",
              Colors.pink.shade600,
              Colors.orange.shade600,
              "Starter",
              "Win 6 Games \nAgainst Person"),
        ),
        MainComponents().achContainer(
            size,
            "${userData.get(1).gamesWonvsPlayer} / 9 Games Won",
            Colors.deepOrange.shade600,
            Colors.lightBlue.shade600,
            "Expert",
            "Win 9 Games \nAgainst Person"),
      ],
    );
  }
}
