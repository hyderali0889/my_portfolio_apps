import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tik_tak_toe/Screens/Games/single_player.dart';

import '../Theme/main_colors.dart';
import 'Games/multi_player.dart';

class SignSelection extends StatelessWidget {
  final bool singleGame;

  const SignSelection({super.key, required this.singleGame});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
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
                    height: size.height * 0.4,
                    child: Center(
                      child: Text(
                        "Select Your Symbol",
                        style: TextStyle(
                            color: MainColors.white,
                            fontSize: 32,
                            fontFamily: 'Bold'),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                                onPressed: () {
                                  if (singleGame) {
                                    Get.offAll(() => const SinglePlayer(
                                        selectedSymbol: "X"));
                                  } else {
                                      Get.offAll(() => const MultiPlayer(
                                        selectedSymbol: "X"));
                                  }
                                },
                                child: Container(
                                  width: size.width * 0.4,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.circular(14.0)),
                                  child: Center(
                                    child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Image.asset(
                                          'assets/imgs/X.png',
                                          height: 150,
                                          width: 150,
                                        )),
                                  ),
                                )),
                            TextButton(
                                onPressed: () {
                                  if (singleGame) {
                                     Get.offAll(() => const SinglePlayer(
                                        selectedSymbol: "O"));
                                  } else {
                                      Get.offAll(() => const MultiPlayer(
                                        selectedSymbol: "O"));
                                  }
                                },
                                child: Container(
                                  width: size.width * 0.4,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.circular(14.0)),
                                  child: Center(
                                    child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Image.asset(
                                          'assets/imgs/O.png',
                                          height: 150,
                                          width: 150,
                                        )),
                                  ),
                                )),
                          ],
                        ),
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
}
