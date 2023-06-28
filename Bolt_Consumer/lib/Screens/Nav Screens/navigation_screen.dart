import 'package:bolt/Controllers/main_menu_controller.dart';

import 'package:bolt/Theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';

import '../Main Screens/favorites_screen.dart';
import '../Main Screens/home_screen.dart';
import '../Main Screens/bucket_screen.dart';
import '../Main Screens/settings_screen.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  List<Widget> pages = [
    const HomeScreen(),
    const BucketScreen(),
    const FavoritesScreen(),
    const SettingScreen()
  ];

  @override
  void initState() {
    super.initState();
    Get.put(MainMenuController());
  }

  @override
  Widget build(BuildContext context) {
    MainMenuController controller = Get.find<MainMenuController>();
    return Scaffold(
      backgroundColor: MainColors.mainPageColor,
      body: SafeArea(child: Obx(() => pages[controller.selectedPage.value])),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: MainColors.mainPageColor,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                    onPressed: () {
                      controller.changePage(0);
                    },
                    icon: Icon(
                      shadows: [
                        Shadow(
                          blurRadius: 5,
                          color: controller.selectedPage.value == 0
                              ? MainColors.purple
                              : Colors.transparent,
                        )
                      ],
                      FeatherIcons.home,
                      color: controller.selectedPage.value == 0
                          ? MainColors.purple
                          : MainColors.black,
                    )),
                IconButton(
                    onPressed: () {
                      controller.changePage(1);
                    },
                    icon: Icon(
                      shadows: [
                        Shadow(
                          blurRadius: 5,
                          color: controller.selectedPage.value == 1
                              ? MainColors.purple
                              : Colors.transparent,
                        )
                      ],
                      FeatherIcons.shoppingBag,
                      color: controller.selectedPage.value == 1
                          ? MainColors.purple
                          : MainColors.black,
                    )),
                IconButton(
                    onPressed: () {
                      controller.changePage(2);
                    },
                    icon: Icon(
                      shadows: [
                        Shadow(
                          blurRadius: 5,
                          color: controller.selectedPage.value == 2
                              ? MainColors.purple
                              : Colors.transparent,
                        )
                      ],
                      FeatherIcons.heart,
                      color: controller.selectedPage.value == 2
                          ? MainColors.purple
                          : MainColors.black,
                    )),
                IconButton(
                    onPressed: () {
                      controller.changePage(3);
                    },
                    icon: Icon(
                      shadows: [
                        Shadow(
                          blurRadius: 5,
                          color: controller.selectedPage.value == 3
                              ? MainColors.purple
                              : Colors.transparent,
                        )
                      ],
                      FeatherIcons.settings,
                      color: controller.selectedPage.value == 3
                          ? MainColors.purple
                          : MainColors.black,
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
