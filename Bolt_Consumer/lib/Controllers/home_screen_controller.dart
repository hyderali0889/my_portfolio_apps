import 'package:get/get.dart';

class HomeController extends GetxController {
  RxBool isSearchBarActive = false.obs;
  RxInt selectedCat = 0.obs;

  makeSearchBarActive(bool val) {
    isSearchBarActive.value = val;
  }

  changeSelectedCat(int num) {
    selectedCat.value = num;
  }


}
