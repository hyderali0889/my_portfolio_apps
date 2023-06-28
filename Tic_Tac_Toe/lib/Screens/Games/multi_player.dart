import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:tik_tak_toe/Components/nothing_widget.dart';
import 'package:tik_tak_toe/Controllers/multi_game_controller.dart';

import '../../Components/main_components.dart';
import '../../Theme/main_colors.dart';
import '../game_selection.dart';

class MultiPlayer extends StatefulWidget {
  final String selectedSymbol;
  const MultiPlayer({super.key, required this.selectedSymbol});

  @override
  State<MultiPlayer> createState() => _MultiPlayerState();
}

class _MultiPlayerState extends State<MultiPlayer> {
  @override
  void initState() {
    super.initState();
    bool userPlaying = widget.selectedSymbol == "X" ? true : false;
    Get.put(MultiController());
    Get.find<MultiController>().changeUserPlaying(userPlaying);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    MultiController controller = Get.find<MultiController>();

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
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                MainComponents().upperRowButton(
                                    FontAwesomeIcons.solidPause, () {
                                  MainComponents().showADialog(
                                      context,
                                      Column(
                                        children: [
                                          MainComponents().mainButton(
                                              size, Colors.green.shade600, () {
                                            Get.back();
                                          }, FontAwesomeIcons.solidPlay,
                                              "Resume"),
                                          MainComponents().mainButton(
                                              size, Colors.red.shade600, () {
                                            MainComponents().confirmation(
                                                context,
                                                "Are you sure you wanna exit?",
                                                () {
                                              Get.offAll(const GameSelection());
                                            });
                                          }, FontAwesomeIcons.solidHome,
                                              "Go to Main Menu")
                                        ],
                                      ),
                                      size);
                                }),
                              ],
                            ),
                          ),
                          Obx(
                            () => Text(
                              controller.winner.value != ""
                                  ? "${controller.winner.value == widget.selectedSymbol ? 'You Won' : 'Opponent Won'}  "
                                  : controller.isGameCompleted.value
                                      ? "Game Drawn"
                                      : "${(controller.userPlaying.value && widget.selectedSymbol == "X" ? true : !controller.userPlaying.value && widget.selectedSymbol == "O" ? true : false) ? "Your" : "Opponent's"} Turn",
                              style: TextStyle(
                                  color: MainColors.white, fontSize: 25),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                      child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Obx(
                            () => Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                /*
                                888888 88 88""Yb .dP"Y8 888888     88""Yb  dP"Yb  Yb        dP
                                88__   88 88__dP `Ybo."   88       88__dP dP   Yb  Yb  db  dP
                                88""   88 88"Yb  o.`Y8b   88       88"Yb  Yb   dP   YbdPYbdP
                                88     88 88  Yb 8bodP'   88       88  Yb  YbodP     YP  YP
                                */
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    boxWidget(controller, 0, size),
                                    boxWidget(controller, 1, size),
                                    boxWidget(controller, 2, size),
                                  ],
                                ),

                                /*
                                .dP"Y8 888888  dP""b8  dP"Yb  88b 88 8888b.      88""Yb  dP"Yb  Yb        dP
                                `Ybo." 88__   dP   `" dP   Yb 88Yb88  8I  Yb     88__dP dP   Yb  Yb  db  dP
                                o.`Y8b 88""   Yb      Yb   dP 88 Y88  8I  dY     88"Yb  Yb   dP   YbdPYbdP
                                8bodP' 888888  YboodP  YbodP  88  Y8 8888Y"      88  Yb  YbodP     YP  YP
                                */
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    boxWidget(controller, 3, size),
                                    boxWidget(controller, 4, size),
                                    boxWidget(controller, 5, size),
                                  ],
                                ),

                                /*
                                888888 88  88 88 88""Yb 8888b.      88""Yb  dP"Yb  Yb        dP
                                  88   88  88 88 88__dP  8I  Yb     88__dP dP   Yb  Yb  db  dP
                                  88   888888 88 88"Yb   8I  dY     88"Yb  Yb   dP   YbdPYbdP
                                  88   88  88 88 88  Yb 8888Y"      88  Yb  YbodP     YP  YP
                                */
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    boxWidget(controller, 6, size),
                                    boxWidget(controller, 7, size),
                                    boxWidget(controller, 8, size),
                                  ],
                                ),
                              ],
                            ),
                          )))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget boxWidget(controller, int boxNum, size) {
    return InkWell(
      onTap: () {
        if (controller.boxes[boxNum] != "") {
          return;
        }

        controller.addToBox(boxNum, controller.userPlaying.value ? "X" : "O",
            context, size, widget.selectedSymbol);

        controller.changeUserPlaying(!controller.userPlaying.value);
      },
      child: Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
              border: Border(
                  bottom: boxNum == 6 || boxNum == 7 || boxNum == 8
                      ? const BorderSide(color: Colors.transparent, width: 0)
                      : const BorderSide(color: Colors.black, width: 2),
                  right: boxNum == 2 || boxNum == 5 || boxNum == 8
                      ? const BorderSide(color: Colors.transparent, width: 0)
                      : const BorderSide(color: Colors.black, width: 2))),
          child: controller.boxes[boxNum] == "X"
              ? Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.asset('assets/imgs/X.png'),
                )
              : Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: controller.boxes[boxNum] == "O"
                      ? Image.asset('assets/imgs/O.png')
                      : const NothingWidget(),
                )),
    );
  }
}
