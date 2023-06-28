import 'package:bolt/Controllers/error_screen_controller.dart';
import 'package:bolt/Screens/Others%20Screen/confirmation_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import '../Constants/firebase_const.dart';
import '../Screens/Auth Screens/error_screen.dart';
import '../Screens/Auth Screens/login_screen.dart';
import '../Screens/Nav Screens/main_menu.dart';

class FirebaseFunctions {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;

  login(String email, String password) async {
    Get.put(ErrorController());

    try {
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        Get.find<ErrorController>().changeError(false);
        Get.offAll(() => const MainMenu());
      });
    } catch (e) {
      Get.find<ErrorController>().changeError(true);
      Get.dialog(ErrorScreen(
        message: "$e",
      ));
    }
  }

  signUp(String email, String password, String name) async {
    Get.put(ErrorController());

    try {
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        Get.find<ErrorController>().changeError(false);
        Get.offAll(() => const MainMenu());
        firestore
            .collection(FirebaseConsts().user)
            .doc(auth.currentUser!.uid)
            .set({
          FirebaseConsts().email: email,
          FirebaseConsts().name: name,
          FirebaseConsts().address: "",
          FirebaseConsts().phone: "",
          FirebaseConsts().cardNum: "",
          FirebaseConsts().cardCVC: "",
          FirebaseConsts().cardExp: "",
          FirebaseConsts().cardCompany: "",
        });
      });
    } catch (e) {
      Get.find<ErrorController>().changeError(true);
      Get.dialog(ErrorScreen(
        message: "$e",
      ));
    }
  }

  updateUserInfo(
    name,
    phoneNum,
  ) {
    try {
      firestore
          .collection(FirebaseConsts().user)
          .doc(auth.currentUser!.uid)
          .update({
        FirebaseConsts().name: name,
        FirebaseConsts().phone: phoneNum,
      });
      Get.offAll(const MainMenu());
    } catch (e) {
      Get.dialog(ErrorScreen(
        message: "$e",
      ));
    }
  }

  updateUserAddress(address) {
    try {
      firestore
          .collection(FirebaseConsts().user)
          .doc(auth.currentUser!.uid)
          .update({FirebaseConsts().address: address});
      Get.offAll(() => const MainMenu());
    } catch (e) {
      Get.dialog(ErrorScreen(
        message: "$e",
      ));
    }
  }

  updateUserCardInfo(cardNum, cardCVC, cardExp, cardCompany) {
    try {
      firestore
          .collection(FirebaseConsts().user)
          .doc(auth.currentUser!.uid)
          .update({
        FirebaseConsts().cardNum: cardNum,
        FirebaseConsts().cardCVC: cardCVC,
        FirebaseConsts().cardExp: cardExp,
        FirebaseConsts().cardCompany: cardCompany,
      });
      Get.offAll(const MainMenu());
    } catch (e) {
      Get.dialog(ErrorScreen(
        message: "$e",
      ));
    }
  }

  resetPassword(String email) async {
    Get.put(ErrorController());
    try {
      await auth.sendPasswordResetEmail(email: email).then((value) {
        Get.find<ErrorController>().changeError(false);
        Get.offAll(() => const LoginScreen());
      });
    } catch (e) {
      Get.find<ErrorController>().changeError(true);
      Get.dialog(ErrorScreen(
        message: "$e",
      ));
    }
  }

  signOut() async {
    try {
      await auth.signOut();
      Get.offAll(const LoginScreen());
    } catch (e) {
      Get.offAll(() => const LoginScreen());
    }
  }

  getFirestoreData() async {
    try {
      QuerySnapshot<Map<String, dynamic>> data =
          await firestore.collection(FirebaseConsts().products).get();

      return data;
    } catch (e) {
      Get.dialog(ErrorScreen(
        message: "$e",
      ));
    }
  }

  getUserData() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> data = await firestore
          .collection(FirebaseConsts().user)
          .doc(auth.currentUser!.uid)
          .get();

      return data;
    } catch (e) {
      Get.dialog(ErrorScreen(
        message: "$e",
      ));
    }
  }

  addToFavorites(List favs) async {
    try {
      await firestore
          .collection(FirebaseConsts().user)
          .doc(auth.currentUser!.uid)
          .collection(FirebaseConsts().favs)
          .add({FirebaseConsts().products: favs}).then((value) {
        Get.offAll(() => const MainMenu());
      });
    } catch (e) {
      Get.dialog(ErrorScreen(
        message: "$e",
      ));
    }
  }

  addToBucket(List item) async {
    try {
      await firestore
          .collection(FirebaseConsts().user)
          .doc(auth.currentUser!.uid)
          .collection(FirebaseConsts().bucket)
          .doc(item[0].toString())
          .set({
        FirebaseConsts().products: {
          ProductModelConsts().id: item[0],
          ProductModelConsts().name: item[1],
          ProductModelConsts().desc: item[2],
          ProductModelConsts().price: item[3],
          ProductModelConsts().label: item[4],
          ProductModelConsts().color: item[5],
          ProductModelConsts().quantity: item[6]
        }
      }).then((value) {
        Get.offAll(() => const MainMenu());
      });
    } catch (e) {
      Get.dialog(ErrorScreen(
        message: "$e",
      ));
    }
  }

  getBucketData() async {
    try {
      dynamic data = await firestore
          .collection(FirebaseConsts().user)
          .doc(auth.currentUser!.uid)
          .collection(FirebaseConsts().bucket)
          .get();

      return data;
    } catch (e) {
      Get.dialog(ErrorScreen(
        message: "$e",
      ));
    }
  }

  getFavsData() async {
    try {
      dynamic data = await firestore
          .collection(FirebaseConsts().user)
          .doc(auth.currentUser!.uid)
          .collection(FirebaseConsts().favs)
          .get();

      return data;
    } catch (e) {
      Get.dialog(ErrorScreen(
        message: "$e",
      ));
    }
  }

  removefromfavs(data, index) async {
    try {
      await firestore.runTransaction((transaction) async {
         transaction.delete(data[index].reference);
      });

      Get.offAll(() => const MainMenu());
    } catch (e) {
      Get.dialog(ErrorScreen(
        message: "$e",
      ));
    }
  }

  buyProducts(productList) async {
    try {
      await firestore
          .collection(FirebaseConsts().user)
          .doc(auth.currentUser!.uid)
          .collection(FirebaseConsts().bucketDetails)
          .doc()
          .set({"Items": productList}).then((value) {
        Get.offAll(() => const ConfirmationScreen());
      });
    } catch (e) {
      Get.dialog(ErrorScreen(
        message: "$e",
      ));
    }
  }

  getProductsData() async {
    try {
      dynamic data = await firestore
          .collection(FirebaseConsts().user)
          .doc(auth.currentUser!.uid)
          .collection(FirebaseConsts().bucketDetails)
          .get();
      return data;
    } catch (e) {
      Get.dialog(ErrorScreen(
        message: "$e",
      ));
    }
  }
}
