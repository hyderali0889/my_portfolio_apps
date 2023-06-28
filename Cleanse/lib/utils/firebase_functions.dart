import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Components/dialog_box.dart';
import '../Controller/home_controller.dart';
import '../Models/user_model.dart';
import '../main.dart';
import '../objectbox.g.dart';

class FirebaseFunctions {
  Box<User> userData = objectBox.store.box<User>();


  void addServicetoFirebase(String address,VoidCallback func, context) {
    try {
      FirebaseFirestore.instance
          .collection(userData.get(1)!.name)
          .add({
 "Address": address,
        "Cleaning Type": Get.find<HomeController>().initialCleaning.value
            ? "Initial Clenaing"
            : "Upwork Cleaning",
        "Cleaning Frequency": Get.find<HomeController>().selectedFreq.value,
        "Hour": DateTime.now().hour,
        "Month": DateTime.now().month,
        "Year": DateTime.now().year,
        "Extras": {
          ValNames.inFridge.toString():
              Get.find<HomeController>().vals[ValNames.inFridge].toString(),
          ValNames.orgVal.toString():
              Get.find<HomeController>().vals[ValNames.orgVal].toString(),
          ValNames.blindsVal.toString():
              Get.find<HomeController>().vals[ValNames.blindsVal].toString(),
          ValNames.patioVal.toString():
              Get.find<HomeController>().vals[ValNames.patioVal].toString(),
          ValNames.chimneyVal.toString():
              Get.find<HomeController>().vals[ValNames.chimneyVal].toString(),
          ValNames.garageVal.toString():
              Get.find<HomeController>().vals[ValNames.garageVal].toString(),
        }
      }).then((value) {
        func();
      });
    } catch (e) {
      DialogBox().errDialog(context, "ERROR",
          "AN ERROR OCCURED Please check your network and try again");
    }
  }

  Future getFirebaseData(context) async {
    try {
      String name = userData.get(1)!.name;
      dynamic firebaseData;
      firebaseData = await FirebaseFirestore.instance.collection(name).get();
      return firebaseData.docs;
    } catch (e) {
      DialogBox().errDialog(context, "ERROR",
          "AN ERROR OCCURED Please check your network and try again");
    }
  }
}
