import 'package:bolt/Components/fragments.dart';
import 'package:bolt/Controllers/notification_controller.dart';

import 'package:bolt/Theme/colors.dart';
import 'package:bolt/Utils/firebase_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';

import '../../Controllers/main_menu_controller.dart';
import '../../Theme/font_family.dart';
import '../../Theme/font_sizes.dart';
import 'navigation_screen.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  @override
  void initState() {
    super.initState();
    Get.put(MainMenuController());
    Get.put(NotificationController());
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    MainMenuController controller = Get.find<MainMenuController>();
    return Scaffold(
        body: Container(
            width: size.width,
            height: size.height,
            color: MainColors.purple,
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                Obx(
                  () => AnimatedPadding(
                    duration: const Duration(milliseconds: 200),
                    padding: controller.isExpanded.value
                        ? EdgeInsets.zero
                        : const EdgeInsets.only(top: 170),
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: controller.isExpanded.value
                              ? const Radius.circular(0)
                              : const Radius.circular(20.0),
                          bottomLeft: controller.isExpanded.value
                              ? const Radius.circular(0)
                              : const Radius.circular(20.0)),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: controller.isExpanded.value
                            ? size.width
                            : size.width * 0.4,
                        height: controller.isExpanded.value
                            ? size.height
                            : size.height * 0.5,
                        child: const NavigationScreen(),
                      ),
                    ),
                  ),
                ),
                Obx(
                  () => controller.isExpanded.value
                      ? Container()
                      : Stack(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 0, left: 40),
                                  child: Container(
                                    width: 70,
                                    height: 70,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white.withOpacity(0.4)),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 70, left: 60),
                                  child: Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 3,
                                          color: Colors.white.withOpacity(0.4)),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: size.height * 0.2, left: 30),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 30),
                                            child: TextButton(
                                              onPressed: () {
                                                changePage(0);
                                              },
                                              child: Fragments().navRailLinks(
                                                  "Home",
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 8),
                                                    child: Icon(
                                                      FeatherIcons.home,
                                                      color: MainColors.white,
                                                    ),
                                                  )),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 30),
                                            child: TextButton(
                                              onPressed: () {
                                                changePage(1);
                                              },
                                              child: Fragments().navRailLinks(
                                                  "My Bucket",
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 8),
                                                    child: Icon(
                                                      FeatherIcons.shoppingCart,
                                                      color: MainColors.white,
                                                    ),
                                                  )),
                                            ),
                                          ),
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 30),
                                              child: TextButton(
                                                onPressed: () {
                                                  changePage(2);
                                                },
                                                child: Fragments().navRailLinks(
                                                    "Favorites",
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 8),
                                                      child: Icon(
                                                        FeatherIcons.heart,
                                                        color: MainColors.white,
                                                      ),
                                                    )),
                                              )),
                                          TextButton(
                                            onPressed: () {
                                              changePage(3);
                                            },
                                            child: Fragments().navRailLinks(
                                                "Settings",
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 8),
                                                  child: Icon(
                                                    Icons.settings,
                                                    color: MainColors.white,
                                                  ),
                                                )),
                                          ),
                                          Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 0, right: 50),
                                                child: Container(
                                                  width: 30,
                                                  height: 30,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 3,
                                                        color: Colors.white
                                                            .withOpacity(0.4)),
                                                    shape: BoxShape.circle,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 70, left: 40),
                                                child: Container(
                                                  width: 70,
                                                  height: 70,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Colors.white
                                                          .withOpacity(0.4)),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 60, right: 100),
                                        child: TextButton(
                                          onPressed: () {
                                            FirebaseFunctions().signOut();
                                          },
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 8),
                                                child: Icon(
                                                  FeatherIcons.logOut,
                                                  color: MainColors.white,
                                                ),
                                              ),
                                              Text(
                                                "Sign Out",
                                                style: TextStyle(
                                                    color: MainColors.white,
                                                    fontFamily:
                                                        FontFamily.semiBold,
                                                    fontSize:
                                                        FontSizes.mainText),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 80),
                                  width: size.width * 0.45,
                                  height: size.height * 0.55,
                                  decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.2),
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(20.0),
                                          bottomLeft: Radius.circular(20.0))),
                                ),
                              ],
                            ),
                          ],
                        ),
                ),
              ],
            )));
  }

/*
   ?     888888 88   88 88b 88  dP""b8 888888 88  dP"Yb  88b 88 .dP"Y8     .dP"Y8 888888  dP""b8 888888 88  dP"Yb  88b 88 .dP"Y8
   ?     88__   88   88 88Yb88 dP   `"   88   88 dP   Yb 88Yb88 `Ybo."     `Ybo." 88__   dP   `"   88   88 dP   Yb 88Yb88 `Ybo."
   ?     88""   Y8   8P 88 Y88 Yb        88   88 Yb   dP 88 Y88 o.`Y8b     o.`Y8b 88""   Yb        88   88 Yb   dP 88 Y88 o.`Y8b
   ?     88     `YbodP' 88  Y8  YboodP   88   88  YbodP  88  Y8 8bodP'     8bodP' 888888  YboodP   88   88  YbodP  88  Y8 8bodP'
*/

/*
 * 888888 88   88 88b 88  dP""b8 888888 88  dP"Yb  88b 88      dP"Yb  88b 88 888888
 * 88__   88   88 88Yb88 dP   `"   88   88 dP   Yb 88Yb88     dP   Yb 88Yb88 88__
 * 88""   Y8   8P 88 Y88 Yb        88   88 Yb   dP 88 Y88     Yb   dP 88 Y88 88""
 * 88     `YbodP' 88  Y8  YboodP   88   88  YbodP  88  Y8      YbodP  88  Y8 888888
*/

  changePage(int va) {
    Get.find<MainMenuController>().changePage(va);
    Get.find<MainMenuController>().changeIsExpanded(true);
  }

/*
<<  888888 88b 88 8888b.       dP"Yb  888888      dP""b8 88        db    .dP"Y8 .dP"Y8
<<  88__   88Yb88  8I  Yb     dP   Yb 88__       dP   `" 88       dPYb   `Ybo." `Ybo."
<<  88""   88 Y88  8I  dY     Yb   dP 88""       Yb      88  .o  dP__Yb  o.`Y8b o.`Y8b
<<  888888 88  Y8 8888Y"       YbodP  88          YboodP 88ood8 dP""""Yb 8bodP' 8bodP'
*/
}
