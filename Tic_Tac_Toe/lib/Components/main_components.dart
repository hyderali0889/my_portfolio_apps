import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:tik_tak_toe/Screens/Games/multi_player.dart';
import 'package:tik_tak_toe/Screens/Games/single_player.dart';
import 'package:tik_tak_toe/Screens/game_selection.dart';

import '../Models/users.dart';
import '../Theme/main_colors.dart';
import '../main.dart';
import '../objectbox.g.dart';

class MainComponents {
  showADialog(context, widget, size) {
    return showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: SizedBox(
          width: size.width * 0.72,
          height: size.height * 0.55,
          child: Stack(
            children: [
              Positioned(
                right: 10,
                top: 10,
                child: Container(
                  width: size.width * 0.7,
                  height: size.height * 0.53,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: MainColors.white, width: 3),
                      color: MainColors.darkBlue),
                  child: Padding(
                      padding: const EdgeInsets.all(25.0), child: widget),
                ),
              ),
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.red),
                  child: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: const Center(
                      child: FaIcon(
                        FontAwesomeIcons.lightTimes,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget mainButton(size, color, VoidCallback func, icon, title) {
    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 700),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: ((context, value, child) {
        return Opacity(
          opacity: value,
          child: Padding(
            padding: EdgeInsets.only(top: value * 15),
            child: TextButton(
                onPressed: func,
                child: Container(
                  width: size.width * 0.7,
                  decoration: BoxDecoration(
                      border: Border.all(color: MainColors.darkBlue, width: 3),
                      color: color,
                      borderRadius: BorderRadius.circular(14.0)),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 12.0),
                            child: FaIcon(
                              icon,
                              color: MainColors.white,
                            ),
                          ),
                          Text(
                            title,
                            style: TextStyle(
                                color: MainColors.white, fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
          ),
        );
      }),
    );
  }

  Widget upperRowButton(icon, VoidCallback fun) {
    return InkWell(
      onTap: fun,
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
            border: Border.all(color: MainColors.white, width: 1),
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.black54),
        child: Center(
          child: FaIcon(
            icon,
            color: MainColors.white,
            size: 17,
          ),
        ),
      ),
    );
  }

  confirmation(context, title, func) {
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            elevation: 12,
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: MainColors.white, width: 3),
                  borderRadius: BorderRadius.circular(14),
                  color: MainColors.darkBlue),
              width: 400,
              height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 2.0),
                    child: Center(
                      child: Text("Confirm Action",
                          style: TextStyle(
                              color: MainColors.white,
                              fontSize: 20,
                              fontFamily: "Bold")),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 25.0),
                    child: Text(title,
                        style: TextStyle(
                          color: MainColors.white,
                          fontSize: 15,
                        )),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: func,
                          child: Container(
                            width: 150,
                            decoration: BoxDecoration(
                                color: Colors.green.shade400,
                                borderRadius: BorderRadius.circular(14.0)),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Text(
                                  "Yes",
                                  style: TextStyle(
                                      color: MainColors.white, fontSize: 15),
                                ),
                              ),
                            ),
                          )),
                      TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: Container(
                            width: 150,
                            decoration: BoxDecoration(
                                color: Colors.red.shade400,
                                borderRadius: BorderRadius.circular(14.0)),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Text(
                                  "No",
                                  style: TextStyle(
                                      color: MainColors.white, fontSize: 15),
                                ),
                              ),
                            ),
                          )),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget achContainer(size, userData, color1, color2, title, subtitle) {
    return Container(
        width: size.width * 0.1,
        height: size.height * 0.18,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [color1, color2],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight),
          border: Border.all(color: MainColors.white, width: 0.5),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Text(title,
                  style: TextStyle(
                    color: MainColors.white,
                    fontSize: 15,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(subtitle,
                      style: TextStyle(
                        color: MainColors.white,
                        fontSize: 15,
                      )),
                  Text(userData,
                      style: TextStyle(
                        color: MainColors.white,
                        fontSize: 15,
                      )),
                ],
              ),
            ),
          ],
        ));
  }

  showAchDialog(context, widget, size) {
    return showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: SizedBox(
          width: size.width * 0.8,
          height: size.height * 0.84,
          child: Stack(
            children: [
              Positioned(
                right: 10,
                top: 10,
                child: Container(
                  width: size.width * 0.78,
                  height: size.height * 0.8,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: MainColors.white, width: 3),
                      color: MainColors.darkBlue),
                  child: Padding(
                      padding: const EdgeInsets.all(25.0), child: widget),
                ),
              ),
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.red),
                  child: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: const Center(
                      child: FaIcon(
                        FontAwesomeIcons.lightTimes,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showDrawDialog(context , size , singlePlayer){
     return showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: SizedBox(
          width: size.width * 0.8,
          height: size.height * 0.84,
          child: Stack(
            children: [
              Positioned(
                right: 10,
                top: 10,
                child: Container(
                  width: size.width * 0.78,
                  height: size.height * 0.8,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: MainColors.white, width: 3),
                      color: MainColors.darkBlue),
                  child: Padding(
                      padding: const EdgeInsets.all(25.0), child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          Text("Game Drawn" ,  style: TextStyle(
                              color: MainColors.white,
                              fontSize: 20,
                              fontFamily: "Bold")),

                               mainButton(size, Colors.blue.shade400, () {
                          singlePlayer
                              ? Get.offAll(() => const SinglePlayer(
                                    selectedSymbol: "X",
                                  ))
                              : Get.offAll(
                                  () => const MultiPlayer(selectedSymbol: "X"));
                        }, FontAwesomeIcons.lightTimes, "Play Again as X"),
                        mainButton(size, Colors.green.shade400, () {
                          singlePlayer
                              ? Get.offAll(() => const SinglePlayer(
                                    selectedSymbol: "O",
                                  ))
                              : Get.offAll(
                                  () => const MultiPlayer(selectedSymbol: "O"));
                        }, FontAwesomeIcons.lightCircle, "Play Again as O"),
                          mainButton(size, Colors.red.shade400, () {
                           Get.offAll(() => const GameSelection()
                             );
                        }, FontAwesomeIcons.lightHome, "Go Home"),


                         ],
                       )),
                ),
              ),
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.red),
                  child: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: const Center(
                      child: FaIcon(
                        FontAwesomeIcons.lightTimes,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
   }

  showWinDialog(context, winner, size, userWon, singlePlayer) {
    Box<User> userData = objectBox.store.box<User>();

    if (userWon && singlePlayer) {
      User data = User(
          id: 1,
          name: userData.get(1)!.name,
          consectiveWins: userData.get(1)!.consectiveWins + 1,
          gamesPlayedvsComputer: userData.get(1)!.gamesPlayedvsComputer + 1,
          gamesPlayedvsPlayer: userData.get(1)!.gamesPlayedvsPlayer,
          gamesWonvsComputer: userData.get(1)!.gamesWonvsComputer + 1,
          gamesWonvsPlayer: userData.get(1)!.gamesWonvsPlayer);

      userData.put(data);
    } else if (userWon == false && singlePlayer) {
      User data = User(
          id: 1,
          name: userData.get(1)!.name,
          consectiveWins: 0,
          gamesPlayedvsComputer: userData.get(1)!.gamesPlayedvsComputer + 1,
          gamesPlayedvsPlayer: userData.get(1)!.gamesPlayedvsPlayer,
          gamesWonvsComputer: userData.get(1)!.gamesWonvsComputer,
          gamesWonvsPlayer: userData.get(1)!.gamesWonvsPlayer);

      userData.put(data);
    }
    if (userWon && singlePlayer == false) {
      User data = User(
          id: 1,
          name: userData.get(1)!.name,
          consectiveWins: userData.get(1)!.consectiveWins + 1,
          gamesPlayedvsComputer: userData.get(1)!.gamesPlayedvsComputer,
          gamesPlayedvsPlayer: userData.get(1)!.gamesPlayedvsPlayer + 1,
          gamesWonvsComputer: userData.get(1)!.gamesWonvsComputer,
          gamesWonvsPlayer: userData.get(1)!.gamesWonvsPlayer + 1);

      userData.put(data);
    } else if (userWon == false && singlePlayer == false) {
      User data = User(
          id: 1,
          name: userData.get(1)!.name,
          consectiveWins: 0,
          gamesPlayedvsComputer: userData.get(1)!.gamesPlayedvsComputer,
          gamesPlayedvsPlayer: userData.get(1)!.gamesPlayedvsPlayer + 1,
          gamesWonvsComputer: userData.get(1)!.gamesWonvsComputer,
          gamesWonvsPlayer: userData.get(1)!.gamesWonvsPlayer);

      userData.put(data);
    }

    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: SizedBox(
          width: size.width * 0.72,
          height: size.height * 0.55,
          child: Stack(
            children: [
              Positioned(
                right: 10,
                top: 10,
                child: Container(
                  width: size.width * 0.7,
                  height: size.height * 0.53,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: MainColors.white, width: 3),
                      color: MainColors.darkBlue),
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          userWon
                              ? "You Won"
                              : singlePlayer
                                  ? "Computer Won"
                                  : "Opponent Won",
                          style: TextStyle(
                              color: MainColors.white,
                              fontSize: 20,
                              fontFamily: "Bold"),
                        ),
                        mainButton(size, Colors.blue.shade400, () {
                          singlePlayer
                              ? Get.offAll(() => const SinglePlayer(
                                    selectedSymbol: "X",
                                  ))
                              : Get.offAll(
                                  () => const MultiPlayer(selectedSymbol: "X"));
                        }, FontAwesomeIcons.lightTimes, "Play Again as X"),
                        mainButton(size, Colors.green.shade400, () {
                          singlePlayer
                              ? Get.offAll(() => const SinglePlayer(
                                    selectedSymbol: "O",
                                  ))
                              : Get.offAll(
                                  () => const MultiPlayer(selectedSymbol: "O"));
                        }, FontAwesomeIcons.lightCircle, "Play Again as O"),
                          mainButton(size, Colors.red.shade400, () {
                           Get.offAll(() => const GameSelection()
                             );
                        }, FontAwesomeIcons.lightHome, "Go Home"),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.red),
                  child: InkWell(
                    onTap: () {
                      Get.offAll(() => const GameSelection());
                    },
                    child: const Center(
                      child: FaIcon(
                        FontAwesomeIcons.lightTimes,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
