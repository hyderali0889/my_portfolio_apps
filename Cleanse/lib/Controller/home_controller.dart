import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum ValNames { inFridge, orgVal, blindsVal, patioVal, garageVal, chimneyVal }

class HomeController extends GetxController {
  RxBool initialCleaning = true.obs;
  RxBool upworkCleaning = false.obs;
  RxString selectedFreq = "Weekly".obs;
  RxBool isConLoading = false.obs;
  RxBool isAddLoading = false.obs;
  RxBool isProfileUpdating = false.obs;
  RxInt selectedPage = 1.obs;

  changePage(int page) {
    selectedPage.value = page;
  }

  goToAnotherPage(PageController cont) {
    cont.jumpToPage(2);
  }

  updateProfile(bool val) {
    isProfileUpdating.value = val;
  }

  changeisCon(bool val) {
    isConLoading.value = val;
  }

  changeisAdd(bool val) {
    isAddLoading.value = val;
  }

  RxMap vals = {
    ValNames.inFridge: 0,
    ValNames.orgVal: 0,
    ValNames.blindsVal: 0,
    ValNames.patioVal: 0,
    ValNames.garageVal: 0,
    ValNames.chimneyVal: 0,
  }.obs;

  selectFreq(String str) {
    selectedFreq.value = str;
  }

  increaseInFridge(bool shouldInc, ValNames val) {
    if (shouldInc) {
      vals[val] = vals[val] + 1;
    } else {
      if (vals[val] <= 0) {
        vals[val] = 0;
      } else {
        vals[val] = vals[val] - 1;
      }
    }
  }

  resetVals() {
    vals[ValNames.blindsVal] = 0;
    vals[ValNames.orgVal] = 0;
    vals[ValNames.garageVal] = 0;
    vals[ValNames.patioVal] = 0;
    vals[ValNames.chimneyVal] = 0;
    vals[ValNames.inFridge] = 0;
  }

  changeInitial() {
    initialCleaning.value = true;
    upworkCleaning.value = false;
  }

  changeUpwork() {
    upworkCleaning.value = true;
    initialCleaning.value = false;
  }
}
