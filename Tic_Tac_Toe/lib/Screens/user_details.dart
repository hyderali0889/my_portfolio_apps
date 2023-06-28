import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:tik_tak_toe/Components/background.dart';
import 'package:tik_tak_toe/Screens/game_selection.dart';
import 'package:tik_tak_toe/Theme/main_colors.dart';

import '../Models/users.dart';
import '../main.dart';
import '../objectbox.g.dart';

class UserDetails extends StatefulWidget {
  const UserDetails({super.key});

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Box<User> userData = objectBox.store.box<User>();
    TextEditingController nameController = TextEditingController();

    return Scaffold(
      body: SafeArea(
        child: Background(
            isSec: true,
            widget: SizedBox(
              height: 300,
              width: size.width * 0.8,
              child: Column(
                children: [
                  TextField(
                    onSubmitted: (val) {
                      if (nameController.text.isEmpty) {
                        return;
                      }
                      User userDetails = User(
                          name: val.trim(),
                          gamesPlayedvsComputer: 0,
                          gamesPlayedvsPlayer: 0,
                          gamesWonvsComputer: 0,
                          gamesWonvsPlayer: 0,
                          consectiveWins: 0);
                      userData.put(userDetails);

                      Get.offAll( ()=>const GameSelection());


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
                    padding: const EdgeInsets.only(top: 50.0),
                    child: InkWell(
                      onTap: () {
                        if (nameController.text.isEmpty) {
                          return;
                        }
                        User userDetails = User(
                            name: nameController.text.trim(),
                            gamesPlayedvsComputer: 0,
                            gamesPlayedvsPlayer: 0,
                            gamesWonvsComputer: 0,
                            gamesWonvsPlayer: 0,
                            consectiveWins: 0);
                        userData.put(userDetails);
                                             Get.offAll( ()=>const GameSelection());

                      },
                      child: Container(
                        width: 350,
                        height: 60,
                        decoration: BoxDecoration(
                            color: Colors.purple.shade700,
                            borderRadius: BorderRadius.circular(14)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Proceed To Game",
                              style: TextStyle(
                                  color: MainColors.white, fontSize: 20),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: FaIcon(
                                FontAwesomeIcons.lightArrowRight,
                                color: MainColors.white,
                                size: 20,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
