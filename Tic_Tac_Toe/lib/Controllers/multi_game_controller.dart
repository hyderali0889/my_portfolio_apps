import 'package:get/get.dart';

import '../Components/main_components.dart';

class MultiController extends GetxController {
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

  finishGame() {
    isGameCompleted.value = true;
  }

  checkIfWinner(context, size, selectedSymbol) {
    if (boxes[0] == boxes[1] && boxes[0] == boxes[2] && boxes[0].isNotEmpty) {
      if (boxes[0] == 'X') {
        MainComponents().showWinDialog(
            context, "X", size, selectedSymbol == "X" ? true : false, false);
        winner.value = 'X';
      } else {
        MainComponents().showWinDialog(
            context, "O", size, selectedSymbol == "O" ? true : false, false);
            winner.value = 'O';

      }
    }
    if (boxes[3] == boxes[4] && boxes[3] == boxes[5] && boxes[3].isNotEmpty) {
      if (boxes[3] == 'X') {
        MainComponents().showWinDialog(
            context, "X", size, selectedSymbol == "X" ? true : false, false);
            winner.value = 'X';
      } else {
        MainComponents().showWinDialog(
            context, "O", size, selectedSymbol == "O" ? true : false, false);
            winner.value = 'O';

      }
    }
    if (boxes[6] == boxes[7] && boxes[6] == boxes[8] && boxes[6].isNotEmpty) {
      if (boxes[6] == 'X') {
        MainComponents().showWinDialog(
            context, "X", size, selectedSymbol == "X" ? true : false, false);
            winner.value = 'X';
      } else {
        MainComponents().showWinDialog(
            context, "O", size, selectedSymbol == "O" ? true : false, false);
            winner.value = 'O';

      }
    }
    if (boxes[0] == boxes[3] && boxes[0] == boxes[6] && boxes[0].isNotEmpty) {
      if (boxes[0] == 'X') {
        MainComponents().showWinDialog(
            context, "X", size, selectedSymbol == "X" ? true : false, false);
            winner.value = 'X';
      } else {
        MainComponents().showWinDialog(
            context, "O", size, selectedSymbol == "O" ? true : false, false);
            winner.value = 'O';

      }
    }
    if (boxes[1] == boxes[4] && boxes[1] == boxes[7] && boxes[1].isNotEmpty) {
      if (boxes[1] == 'X') {
        MainComponents().showWinDialog(
            context, "X", size, selectedSymbol == "X" ? true : false, false);
            winner.value = 'X';
      } else {
        MainComponents().showWinDialog(
            context, "O", size, selectedSymbol == "O" ? true : false, false);
            winner.value = 'O';

      }
    }
    if (boxes[2] == boxes[5] && boxes[2] == boxes[8] && boxes[2].isNotEmpty) {
      if (boxes[2] == 'X') {
        MainComponents().showWinDialog(
            context, "X", size, selectedSymbol == "X" ? true : false, false);
            winner.value = 'X';
      } else {
        MainComponents().showWinDialog(
            context, "O", size, selectedSymbol == "O" ? true : false, false);
            winner.value = 'O';

      }
    }
    if (boxes[0] == boxes[4] && boxes[0] == boxes[8] && boxes[0].isNotEmpty) {
      if (boxes[0] == 'X') {
        MainComponents().showWinDialog(
            context, "X", size, selectedSymbol == "X" ? true : false, false);
            winner.value = 'X';
      } else {
        MainComponents().showWinDialog(
            context, "O", size, selectedSymbol == "O" ? true : false, false);
            winner.value = 'O';

      }
    }
    if (boxes[2] == boxes[4] && boxes[2] == boxes[6] && boxes[2].isNotEmpty) {
      if (boxes[2] == 'X') {
        MainComponents().showWinDialog(
            context, "X", size, selectedSymbol == "X" ? true : false, false);
            winner.value = 'X';
      } else {
        MainComponents().showWinDialog(
            context, "O", size, selectedSymbol == "O" ? true : false, false);
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
      MainComponents().showDrawDialog(context, size, false);

      finishGame();
    }
  }
}
