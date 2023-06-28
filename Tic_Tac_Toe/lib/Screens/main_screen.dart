import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:tik_tak_toe/Components/background.dart';
import 'package:tik_tak_toe/Screens/user_details.dart';
import 'package:tik_tak_toe/Theme/main_colors.dart';

import '../Models/users.dart';
import '../main.dart';
import '../objectbox.g.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Box<User> userData = objectBox.store.box<User>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Background(
            isSec: false,
            widget: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 119.0),
                child: InkWell(
                  onTap: () {
                    Get.to(const UserDetails());
                  },
                  child: Container(
                    width: 350,
                    height: 60,
                    decoration: BoxDecoration(
                        color: Colors.red.shade400,
                        borderRadius: BorderRadius.circular(14)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Get Started",
                          style:
                              TextStyle(color: MainColors.white, fontSize: 20),
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
            )),
      ),
    );
  }
}
