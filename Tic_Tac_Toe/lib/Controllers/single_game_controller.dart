import 'dart:math';

import 'package:get/get.dart';
import 'package:tik_tak_toe/Components/main_components.dart';

class SingleController extends GetxController {
  RxBool userPlaying = false.obs;
  RxBool isGameCompleted = false.obs;
  RxString winner = ''.obs;

  RxList boxes = ["", "", "", "", "", "", "", "", ""].obs;

  changeUserPlaying(bool newUserVal) {
    userPlaying.value = newUserVal;
  }

  addToBox(int mum, String value, context, size, selectedSymbol) {
    boxes[mum] = value;

    checkIfGameFinished(context, size, selectedSymbol);
  }

  void computerPlay(selectedSymbol, context, size) {
    int rand = Random().nextInt(9);
    if (boxes[rand] == "") {
      addToBox(
          rand, userPlaying.value ? "X" : "O", context, size, selectedSymbol);
      changeUserPlaying(!userPlaying.value);
    } else {
      int rand2 = Random().nextInt(9);
      if (boxes[rand2] == "") {
        addToBox(rand2, userPlaying.value ? "X" : "O", context, size,
            selectedSymbol);
        changeUserPlaying(!userPlaying.value);
      } else {
        int rand3 = Random().nextInt(9);
        if (boxes[rand3] == "") {
          addToBox(rand3, userPlaying.value ? "X" : "O", context, size,
              selectedSymbol);
          changeUserPlaying(!userPlaying.value);
        } else {
          int rand4 = Random().nextInt(9);
          if (boxes[rand4] == "") {
            addToBox(rand4, userPlaying.value ? "X" : "O", context, size,
                selectedSymbol);
            changeUserPlaying(!userPlaying.value);
          } else {
            int rand5 = Random().nextInt(9);
            if (boxes[rand5] == "") {
              addToBox(rand5, userPlaying.value ? "X" : "O", context, size,
                  selectedSymbol);
              changeUserPlaying(!userPlaying.value);
            } else {
              int rand6 = Random().nextInt(9);
              if (boxes[rand6] == "") {
                addToBox(rand6, userPlaying.value ? "X" : "O", context, size,
                    selectedSymbol);
                changeUserPlaying(!userPlaying.value);
              } else {
                int rand7 = Random().nextInt(9);
                if (boxes[rand7] == "") {
                  addToBox(rand7, userPlaying.value ? "X" : "O", context, size,
                      selectedSymbol);
                  changeUserPlaying(!userPlaying.value);
                } else {
                  int rand8 = Random().nextInt(9);
                  if (boxes[rand8] == "") {
                    addToBox(rand8, userPlaying.value ? "X" : "O", context,
                        size, selectedSymbol);
                    changeUserPlaying(!userPlaying.value);
                  } else {
                    int rand9 = Random().nextInt(9);
                    if (boxes[rand9] == "") {
                      addToBox(rand9, userPlaying.value ? "X" : "O", context,
                          size, selectedSymbol);
                      changeUserPlaying(!userPlaying.value);
                    } else {
                      int rand10 = Random().nextInt(9);
                      if (boxes[rand10] == "") {
                        addToBox(rand10, userPlaying.value ? "X" : "O", context,
                            size, selectedSymbol);
                        changeUserPlaying(!userPlaying.value);
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }

  finishGame() {
    isGameCompleted.value = true;
  }

  checkIfWinner(context, size, selectedSymbol) {
    if (boxes[0] == boxes[1] && boxes[0] == boxes[2] && boxes[0].isNotEmpty) {
      if (boxes[0] == 'X') {
        MainComponents().showWinDialog(
            context, "X", size, selectedSymbol == "X" ? true : false, true);
        winner.value = 'X';
      } else {
        MainComponents().showWinDialog(
            context, "O", size, selectedSymbol == "O" ? true : false, true);
        winner.value = 'O';
      }
    }
    if (boxes[3] == boxes[4] && boxes[3] == boxes[5] && boxes[3].isNotEmpty) {
      if (boxes[3] == 'X') {
        MainComponents().showWinDialog(
            context, "X", size, selectedSymbol == "X" ? true : false, true);
        winner.value = 'X';
      } else {
        MainComponents().showWinDialog(
            context, "O", size, selectedSymbol == "O" ? true : false, true);
        winner.value = 'O';
      }
    }
    if (boxes[6] == boxes[7] && boxes[6] == boxes[8] && boxes[6].isNotEmpty) {
      if (boxes[6] == 'X') {
        MainComponents().showWinDialog(
            context, "X", size, selectedSymbol == "X" ? true : false, true);
        winner.value = 'X';
      } else {
        MainComponents().showWinDialog(
            context, "O", size, selectedSymbol == "O" ? true : false, true);
        winner.value = 'O';
      }
    }
    if (boxes[0] == boxes[3] && boxes[0] == boxes[6] && boxes[0].isNotEmpty) {
      if (boxes[0] == 'X') {
        MainComponents().showWinDialog(
            context, "X", size, selectedSymbol == "X" ? true : false, true);
        winner.value = 'X';
      } else {
        MainComponents().showWinDialog(
            context, "O", size, selectedSymbol == "O" ? true : false, true);
        winner.value = 'O';
      }
    }
    if (boxes[1] == boxes[4] && boxes[1] == boxes[7] && boxes[1].isNotEmpty) {
      if (boxes[1] == 'X') {
        MainComponents().showWinDialog(
            context, "X", size, selectedSymbol == "X" ? true : false, true);
        winner.value = 'X';
      } else {
        MainComponents().showWinDialog(
            context, "O", size, selectedSymbol == "O" ? true : false, true);
        winner.value = 'O';
      }
    }
    if (boxes[2] == boxes[5] && boxes[2] == boxes[8] && boxes[2].isNotEmpty) {
      if (boxes[2] == 'X') {
        MainComponents().showWinDialog(
            context, "X", size, selectedSymbol == "X" ? true : false, true);
        winner.value = 'X';
      } else {
        MainComponents().showWinDialog(
            context, "O", size, selectedSymbol == "O" ? true : false, true);
        winner.value = 'O';
      }
    }
    if (boxes[0] == boxes[4] && boxes[0] == boxes[8] && boxes[0].isNotEmpty) {
      if (boxes[0] == 'X') {
        MainComponents().showWinDialog(
            context, "X", size, selectedSymbol == "X" ? true : false, true);
        winner.value = 'X';
      } else {
        MainComponents().showWinDialog(
            context, "O", size, selectedSymbol == "O" ? true : false, true);
        winner.value = 'O';
      }
    }
    if (boxes[2] == boxes[4] && boxes[2] == boxes[6] && boxes[2].isNotEmpty) {
      if (boxes[2] == 'X') {
        MainComponents().showWinDialog(
            context, "X", size, selectedSymbol == "X" ? true : false, true);
        winner.value = 'X';
      } else {
        MainComponents().showWinDialog(
            context, "O", size, selectedSymbol == "O" ? true : false, true);
        winner.value = 'O';
      }
    }
  }

  checkIfGameFinished(context, size, selectedSymbol) {
    checkIfWinner(context, size, selectedSymbol);
    if (boxes[0] != "" &&
        boxes[1] != "" &&
        boxes[2] != "" &&
        boxes[3] != "" &&
        boxes[4] != "" &&
        boxes[5] != "" &&
        boxes[6] != "" &&
        boxes[7] != "" &&
        boxes[8] != "" &&
        winner.value == "") {
      MainComponents().showDrawDialog(context, size, true);
      finishGame();
    }
  }
}
