import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:house_cleaning/utils/main_colors.dart';

import '../Routes/page_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Titleandimg(size: size), BottomButton(size: size)],
          ),
        ),
      ),
    );
  }
}

class BottomButton extends StatelessWidget {
  const BottomButton({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: InkWell(
        onTap: () {
          Get.toNamed(PageRoutes().infoScreen);
        },
        child: Container(
            decoration: BoxDecoration(
              color: MainColors().textWhite,
              borderRadius:
                  const BorderRadius.only(topLeft: Radius.circular(14.0)),
            ),
            alignment: Alignment.center,
            height: 50,
            width: size.width * 0.5,
            child: Text(
              "Get Started",
              style: context.textTheme.headlineSmall,
            )),
      ),
    );
  }
}

class Titleandimg extends StatelessWidget {
  const Titleandimg({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(top: size.height * 0.1),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: FaIcon(
                  FontAwesomeIcons.lightVacuumRobot,
                  color: MainColors().textWhite,
                  size: 18,
                ),
              ),
              Text(
                "Cleanse",
                style: context.textTheme.bodySmall!.copyWith(fontSize: 18),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: size.height * 0.025),
          child: Text(
            textAlign: TextAlign.center,
            "Clean Home \nClean Life.",
            style: context.textTheme.bodyLarge,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: size.height * 0.02),
          child: Text(
            textAlign: TextAlign.center,
            "Book Cleaners at the Comfort\nof you home.",
            style: context.textTheme.bodyMedium!.copyWith(fontSize: 11),
          ),
        ),
        Padding(
            padding: EdgeInsets.only(top: size.height * 0.05),
            child: Container(
              width: size.width,
              height: 300,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                'assets/icons/back.png',
              ))),
            ))
      ],
    );
  }
}
