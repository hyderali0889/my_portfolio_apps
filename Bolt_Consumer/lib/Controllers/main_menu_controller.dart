import 'package:get/get.dart';

class MainMenuController extends GetxController {
  RxBool isExpanded = true.obs;
  RxInt selectedPage = 0.obs;

  changeIsExpanded(bool val) {
    isExpanded.value = val;
  }

  changePage(int va) {
    selectedPage.value = va;
  }
}
