import 'package:bolt/Components/fragments.dart';
import 'package:bolt/Constants/firebase_const.dart';
import 'package:bolt/Controllers/main_menu_controller.dart';
import 'package:bolt/Screens/Auth%20Screens/error_screen.dart';
import 'package:bolt/Screens/Settings%20Screens/all_orders_screen.dart';
import 'package:bolt/Screens/Settings%20Screens/edit_profile_screen.dart';
import 'package:bolt/Theme/colors.dart';
import 'package:bolt/Theme/font_family.dart';
import 'package:bolt/Theme/font_sizes.dart';
import 'package:bolt/Utils/firebase_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';

import '../../Controllers/notification_controller.dart';
import '../Settings Screens/edit_address.dart';
import '../Settings Screens/edit_card_screen.dart';
import '../Settings Screens/notification_screen.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  TextEditingController textcontroller = TextEditingController();
  dynamic data;
  @override
  void initState() {
    super.initState();
    if (mounted) {
      Get.put(MainMenuController());
      getUserData();
    }
  }

  getUserData() async {
    try {
      dynamic main = await FirebaseFunctions().getUserData();
      if (!mounted) return;
      setState(() {
        data = main;
      });
    } catch (e) {
      Get.to(() => ErrorScreen(message: "$e"));
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    NotificationController controller = Get.find<NotificationController>();
    return Scaffold(
        backgroundColor: MainColors.mainPageColor,
        body: SizedBox(
          width: size.width,
          height: size.height,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 40.0, top: 20, right: 10, bottom: 20),
                      child: Fragments().headingText(
                          "Settings", FontSizes.mainHeading, MainColors.black),
                    ),
                    mainProfileBox(size),
                    mainBox(size, "Edit Profile",
                        const Icon(FeatherIcons.arrowRight), () {
                      Get.to(() => const EditProfile());
                    }),
                    mainBox(size, "Shopping Address",
                        const Icon(FeatherIcons.arrowRight), () {
                      Get.to(() => const EditAddress());
                    }),
                    mainBox(size, "Order History",
                        const Icon(FeatherIcons.arrowRight), () {
                      Get.to(() => const AllOrdersScreen());
                    }),
                    mainBox(size, "Cards", const Icon(FeatherIcons.arrowRight),
                        () {
                      Get.to(() => const EditCard());
                    }),
                    mainNotBox(size, "Notifications",
                        const Icon(FeatherIcons.arrowRight), () {
                      Get.to(() => const NotificationScreen());
                    }, controller),
                  ],
                ),
              )
            ],
          ),
        ));
  }

  /*
 ! Yb        dP 88 8888b.   dP""b8 888888 888888 .dP"Y8     .dP"Y8 888888  dP""b8 888888 88  dP"Yb  88b 88
 !  Yb  db  dP  88  8I  Yb dP   `" 88__     88   `Ybo."     `Ybo." 88__   dP   `"   88   88 dP   Yb 88Yb88
 !   YbdPYbdP   88  8I  dY Yb  "88 88""     88   o.`Y8b     o.`Y8b 88""   Yb        88   88 Yb   dP 88 Y88
 !    YP  YP    88 8888Y"   YboodP 888888   88   8bodP'     8bodP' 888888  YboodP   88   88  YbodP  88  Y8
  */

  /*
 ? Yb        dP 88 8888b.   dP""b8 888888 888888      dP"Yb  88b 88 888888
 ?  Yb  db  dP  88  8I  Yb dP   `" 88__     88       dP   Yb 88Yb88 88__
 ?   YbdPYbdP   88  8I  dY Yb  "88 88""     88       Yb   dP 88 Y88 88""
 ?    YP  YP    88 8888Y"   YboodP 888888   88        YbodP  88  Y8 888888
  */

  searchField(TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
          hintText: "Search",
          hintStyle: Fragments().mainTextStyle(
              FontSizes.mainText, MainColors.black, FontFamily.semiBold),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
          )),
    );
  }

  /*
 ? Yb        dP 88 8888b.   dP""b8 888888 888888     888888 Yb        dP  dP"Yb
 ?  Yb  db  dP  88  8I  Yb dP   `" 88__     88         88    Yb  db  dP  dP   Yb
 ?   YbdPYbdP   88  8I  dY Yb  "88 88""     88         88     YbdPYbdP   Yb   dP
 ?    YP  YP    88 8888Y"   YboodP 888888   88         88      YP  YP     YbodP
  */

  mainProfileBox(size) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: MainColors.white),
      width: size.width * 0.9,
      height: size.height * 0.15,
      child: data == null
          ? Center(
              child: CircularProgressIndicator(color: MainColors.purple),
            )
          : Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text(data[FirebaseConsts().name].toUpperCase(),
                      style: Fragments().mainTextStyle(
                        FontSizes.mainText,
                        MainColors.black,
                        FontFamily.bold,
                      )),
                  data[FirebaseConsts().address] == ""
                      ? Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                child: Icon(
                                  FeatherIcons.alertTriangle,
                                  color: Colors.red,
                                  size: 15,
                                ),
                              ),
                              Text(
                                "No Address Found",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontFamily: FontFamily.bold),
                              ),
                            ],
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child:
                              Text(data[FirebaseConsts().address].toUpperCase(),
                                  maxLines: 2,
                                  overflow: TextOverflow.fade,
                                  style: Fragments().mainTextStyle(
                                    FontSizes.mainText,
                                    MainColors.black,
                                    FontFamily.regular,
                                  )),
                        ),
                ],
              ),
            ),
    );
  }

  /*
 ? Yb        dP 88 8888b.   dP""b8 888888 888888     888888 88  88 88""Yb 888888 888888
 ?  Yb  db  dP  88  8I  Yb dP   `" 88__     88         88   88  88 88__dP 88__   88__
 ?   YbdPYbdP   88  8I  dY Yb  "88 88""     88         88   888888 88"Yb  88""   88""
 ?    YP  YP    88 8888Y"   YboodP 888888   88         88   88  88 88  Yb 888888 888888
  */

  mainBox(size, text, icon, func) {
    return InkWell(
      onTap: func,
      child: Container(
        margin: const EdgeInsets.only(top: 30),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: MainColors.white),
        width: size.width * 0.9,
        height: size.height * 0.08,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(text,
                  style: Fragments().mainTextStyle(
                      FontSizes.subText, MainColors.black, FontFamily.bold)),
              IconButton(onPressed: func, icon: icon),
            ],
          ),
        ),
      ),
    );
  }

  mainNotBox(size, text, icon, func, controller) {
    return InkWell(
      onTap: func,
      child: Container(
        margin: const EdgeInsets.only(top: 30),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: MainColors.white),
        width: size.width * 0.9,
        height: size.height * 0.08,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                Text(text,
                    style: Fragments().mainTextStyle(
                        FontSizes.subText, MainColors.black, FontFamily.bold)),
                controller.notifications.isEmpty
                    ? Container()
                    : Container(
                        margin: const EdgeInsets.only(left: 5),
                        decoration: BoxDecoration(
                            color: MainColors.purple, shape: BoxShape.circle),
                        width: 10,
                        height: 10,
                      ),
              ]),
              IconButton(onPressed: func, icon: icon),
            ],
          ),
        ),
      ),
    );
  }

  /*
 << 888888 88b 88 8888b.       dP"Yb  888888      dP""b8 88        db    .dP"Y8 .dP"Y8
 << 88__   88Yb88  8I  Yb     dP   Yb 88__       dP   `" 88       dPYb   `Ybo." `Ybo."
 << 88""   88 Y88  8I  dY     Yb   dP 88""       Yb      88  .o  dP__Yb  o.`Y8b o.`Y8b
 << 888888 88  Y8 8888Y"       YbodP  88          YboodP 88ood8 dP""""Yb 8bodP' 8bodP'
  */
}
