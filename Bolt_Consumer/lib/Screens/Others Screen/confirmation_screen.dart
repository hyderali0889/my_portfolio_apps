import 'package:bolt/Components/fragments.dart';
import 'package:bolt/Controllers/main_menu_controller.dart';
import 'package:bolt/Screens/Nav%20Screens/main_menu.dart';
import 'package:bolt/Theme/colors.dart';
import 'package:bolt/Theme/font_family.dart';
import 'package:bolt/Theme/font_sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfirmationScreen extends StatefulWidget {
  const ConfirmationScreen({super.key});

  @override
  State<ConfirmationScreen> createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen> {
  @override
  void initState() {
    super.initState();
    Get.put(MainMenuController());
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    MainMenuController controller = Get.find<MainMenuController>();
    return Scaffold(
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Confirmation Screen",
                style: TextStyle(
                    color: MainColors.purple,
                    fontFamily: FontFamily.bold,
                    fontSize: FontSizes.mainHeading),
              ),
              Column(
                children: [
                  Image.asset(
                    'assets/imgs/Saly-22.png',
                    height: 350,
                    width: 350,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Text(
                      "Your Order is Confirmed, Thank you for Shopping with us.",
                      style: TextStyle(
                          color: MainColors.black,
                          fontFamily: FontFamily.semiBold,
                          fontSize: FontSizes.mainText),
                    ),
                  ),
                ],
              ),
              Fragments().mainButton(
                  size,
                  "Go To Home Screen",
                  MainColors.turquiose,
                  FontSizes.buttonTitle,
                  MainColors.white, () {
                controller.changePage(0);
                Get.offAll(() => const MainMenu());
              })
            ],
          ),
        ),
      ),
    );
  }
}
