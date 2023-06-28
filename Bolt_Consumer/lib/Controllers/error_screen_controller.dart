import "package:get/get.dart";

class ErrorController extends GetxController {
  RxBool isError = false.obs;
  changeError(bool val) {
    isError.value = val;
  }
}
