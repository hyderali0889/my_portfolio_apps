import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tik_tak_toe/Components/nothing_widget.dart';
import 'package:tik_tak_toe/Theme/main_colors.dart';

class Background extends StatelessWidget {
  final Widget widget;
  final bool isSec;
  const Background({super.key, required this.widget, required this.isSec});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: size.width,
            height: size.height,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [MainColors.lightBlue, MainColors.darkBlue],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight)),
          ),
          SizedBox(
            width: size.width,
            height: size.height,
            child: Column(
              children: [
                isSec
                    ? SizedBox(
                        height: 20,
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  Get.back();
                                },
                                icon: Icon(
                                  Icons.arrow_left,
                                  color: MainColors.white,
                                ))
                          ],
                        ),
                      )
                    : const NothingWidget(),
                Stack(
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
                            width: size.width,
                            height:
                                isSec ? size.height * 0.4 : size.height * 0.49,
                            child: Center(
                                child: Text(
                              "Tik-Tac-Toe",
                              style: TextStyle(
                                  fontFamily: "Bold",
                                  fontSize: 35,
                                  color: MainColors.white),
                            ))),
                        SizedBox(
                            height:
                                isSec ? size.height * 0.5 : size.height * 0.47,
                            child: widget)
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
