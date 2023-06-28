import 'package:bolt/Constants/firebase_const.dart';
import 'package:bolt/Controllers/notification_controller.dart';
import 'package:bolt/Theme/colors.dart';
import 'package:bolt/Theme/font_family.dart';
import 'package:bolt/Theme/font_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  dynamic productsData;
  @override
  void initState() {
    super.initState();
    Get.put(NotificationController());
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
        child: SafeArea(
            child: controller.notifications.isEmpty
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          upperRow(size),
                          Text(
                            "Notification Screen",
                            style: TextStyle(
                                color: MainColors.black,
                                fontFamily: FontFamily.bold,
                                fontSize: FontSizes.mainText),
                          ),
                          Container()
                        ],
                      ),
                      Column(
                        children: [
                          Image.asset(
                            'assets/imgs/Saly-24.png',
                            height: 350,
                            width: 350,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: Text(
                              "No Notifications Yet, Book an Order from us to see Notifications here.",
                              style: TextStyle(
                                  color: MainColors.black,
                                  fontFamily: FontFamily.semiBold,
                                  fontSize: FontSizes.mainText),
                            ),
                          ),
                        ],
                      ),
                      Container()
                    ],
                  )
                : Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          upperRow(size),
                          Text(
                            "Notification Screen",
                            style: TextStyle(
                                color: MainColors.black,
                                fontFamily: FontFamily.bold,
                                fontSize: FontSizes.mainText),
                          ),
                          Container()
                        ],
                      ),
                      SizedBox(
                          width: size.width,
                          height: size.height * 0.9,
                          child: ListView.builder(
                              itemCount: controller.notifications.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: MainColors.white),
                                    child: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Text(
                                        "${controller.notifications[index][0][ProductModelConsts().name]} has been added to cart",
                                        style: TextStyle(
                                            color: MainColors.purple,
                                            fontFamily: FontFamily.bold,
                                            fontSize: FontSizes.mainText),
                                      ),
                                    ),
                                  ),
                                );
                              }))
                    ],
                  )),
      ),
    );
  }

  /*
 ? Yb        dP 88 8888b.   dP""b8 888888 888888 .dP"Y8     .dP"Y8 888888  dP""b8 888888 88  dP"Yb  88b 88
 ?  Yb  db  dP  88  8I  Yb dP   `" 88__     88   `Ybo."     `Ybo." 88__   dP   `"   88   88 dP   Yb 88Yb88
 ?   YbdPYbdP   88  8I  dY Yb  "88 88""     88   o.`Y8b     o.`Y8b 88""   Yb        88   88 Yb   dP 88 Y88
 ?    YP  YP    88 8888Y"   YboodP 888888   88   8bodP'     8bodP' 888888  YboodP   88   88  YbodP  88  Y8
  */
  /*
 ! Yb        dP 88 8888b.   dP""b8 888888 888888      dP"Yb  88b 88 888888
 !  Yb  db  dP  88  8I  Yb dP   `" 88__     88       dP   Yb 88Yb88 88__
 !   YbdPYbdP   88  8I  dY Yb  "88 88""     88       Yb   dP 88 Y88 88""
 !    YP  YP    88 8888Y"   YboodP 888888   88        YbodP  88  Y8 888888
  */

  upperRow(size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                FeatherIcons.arrowLeft,
                color: MainColors.black,
              )),
        ),
        Container()
      ],
    );
  }
}
