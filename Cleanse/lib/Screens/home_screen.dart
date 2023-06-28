import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:house_cleaning/Controller/home_controller.dart';
import 'package:house_cleaning/utils/main_colors.dart';

import '../Routes/page_routes.dart';
import '../utils/font_names.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    HomeController controller = Get.find<HomeController>();

    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Stack(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: size.height * 0.1,
                    child: Center(
                      child: Text(
                        "Your Plan",
                        style: context.textTheme.bodyMedium!.copyWith(
                            fontFamily: FontNames().monst['semiBold']),
                      ),
                    ),
                  ),
                  MainPageWidgets(size: size, controller: controller),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MainPageWidgets extends StatelessWidget {
  const MainPageWidgets({
    super.key,
    required this.size,
    required this.controller,
  });

  final Size size;
  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: size.width,
        decoration: BoxDecoration(
            color: MainColors().textWhite,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(14.0),
                topRight: Radius.circular(14.0))),
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, right: 8.0, top: 15),
                  child: Text(
                    "Selected Cleaning",
                    style: context.textTheme.labelLarge!.copyWith(
                        fontSize: 16, fontFamily: FontNames().ubu["bold"]),
                  ),
                ),
                SelectCleaning(controller: controller),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, right: 8.0, top: 20),
                  child: Text(
                    "Selected Frequency",
                    style: context.textTheme.labelLarge!.copyWith(
                        fontSize: 16, fontFamily: FontNames().ubu["bold"]),
                  ),
                ),
                PageButtons(
                  controller: controller,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, right: 20.0, top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Selected Extras",
                        style: context.textTheme.labelLarge!.copyWith(
                            fontSize: 16, fontFamily: FontNames().ubu["bold"]),
                      ),
                      TextButton(
                        onPressed: () {
                          controller.resetVals();
                        },
                        child: Text(
                          "Reset Buttons",
                          style: context.textTheme.headlineSmall,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Obx(
                            () => ExtrasButton(
                              labelVal: controller.vals[ValNames.inFridge],
                              rem: () {
                                controller.increaseInFridge(
                                    false, ValNames.inFridge);
                              },
                              func: () {
                                controller.increaseInFridge(
                                    true, ValNames.inFridge);
                              },
                              text: "Inside Fridge",
                              controller: controller,
                              icon: FaIcon(
                                FontAwesomeIcons.lightRefrigerator,
                                color: MainColors().textWhite,
                              ),
                            ),
                          ),
                          Obx(
                            () => ExtrasButton(
                              labelVal: controller.vals[ValNames.orgVal],
                              rem: () {
                                controller.increaseInFridge(
                                    false, ValNames.orgVal);
                              },
                              func: () {
                                controller.increaseInFridge(
                                    true, ValNames.orgVal);
                              },
                              text: "Organizing",
                              controller: controller,
                              icon: FaIcon(
                                FontAwesomeIcons.lightHandHoldingBox,
                                color: MainColors().textWhite,
                              ),
                            ),
                          ),
                          Obx(
                            () => ExtrasButton(
                              labelVal: controller.vals[ValNames.blindsVal],
                              rem: () {
                                controller.increaseInFridge(
                                    false, ValNames.blindsVal);
                              },
                              func: () {
                                controller.increaseInFridge(
                                    true, ValNames.blindsVal);
                              },
                              text: "Small Blinds",
                              controller: controller,
                              icon: FaIcon(
                                FontAwesomeIcons.lightBlindsOpen,
                                color: MainColors().textWhite,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Obx(
                              () => ExtrasButton(
                                labelVal: controller.vals[ValNames.patioVal],
                                rem: () {
                                  controller.increaseInFridge(
                                      false, ValNames.patioVal);
                                },
                                func: () {
                                  controller.increaseInFridge(
                                      true, ValNames.patioVal);
                                },
                                text: "Patio",
                                controller: controller,
                                icon: FaIcon(
                                  FontAwesomeIcons.lightChair,
                                  color: MainColors().textWhite,
                                ),
                              ),
                            ),
                            Obx(
                              () => ExtrasButton(
                                labelVal: controller.vals[ValNames.garageVal],
                                rem: () {
                                  controller.increaseInFridge(
                                      false, ValNames.garageVal);
                                },
                                func: () {
                                  controller.increaseInFridge(
                                      true, ValNames.garageVal);
                                },
                                text: "Garage",
                                controller: controller,
                                icon: FaIcon(
                                  FontAwesomeIcons.lightGarage,
                                  color: MainColors().textWhite,
                                ),
                              ),
                            ),
                            Obx(
                              () => ExtrasButton(
                                labelVal: controller.vals[ValNames.chimneyVal],
                                rem: () {
                                  controller.increaseInFridge(
                                      false, ValNames.chimneyVal);
                                },
                                func: () {
                                  controller.increaseInFridge(
                                      true, ValNames.chimneyVal);
                                },
                                text: "Chimney",
                                controller: controller,
                                icon: FaIcon(
                                  FontAwesomeIcons.lightChimney,
                                  color: MainColors().textWhite,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Center(
                    child: InkWell(
                      onTap: () {
                        Get.toNamed(PageRoutes().confirmationScreen);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: size.width * 0.8,
                        height: !controller.initialCleaning.value ||
                                !controller.upworkCleaning.value &&
                                    controller.selectedFreq.value != ""
                            ? 40
                            : 0,
                        decoration: BoxDecoration(
                            color: MainColors().buttonPink,
                            borderRadius: BorderRadius.circular(8)),
                        child: Text(
                          "Proceed",
                          style: context.textTheme.bodyMedium,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ExtrasButton extends StatelessWidget {
  const ExtrasButton({
    super.key,
    required this.func,
    required this.text,
    required this.controller,
    required this.icon,
    required this.rem,
    required this.labelVal,
  });
  final VoidCallback func;
  final String text;
  final HomeController controller;
  final FaIcon icon;
  final VoidCallback rem;
  final int labelVal;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 20,
        left: 18.0,
        right: 8.0,
      ),
      child: Column(
        children: [
          InkWell(
            onLongPress: rem,
            onTap: func,
            child: Align(
              child: Badge(
                label: Text(labelVal.toString()),
                backgroundColor: MainColors().buttonPink,
                padding: const EdgeInsets.symmetric(horizontal: 5),
                alignment: const AlignmentDirectional(40, -5),
                isLabelVisible: true,
                child: Container(
                    alignment: Alignment.center,
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: MainColors().backgroundPurple),
                    child: icon),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              text,
              style: context.textTheme.labelSmall!.copyWith(fontSize: 10),
            ),
          )
        ],
      ),
    );
  }
}

class PageButtons extends StatelessWidget {
  const PageButtons({
    super.key,
    required this.controller,
  });
  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            MainButton(
              func: () {
                controller.selectFreq("Weekly");
              },
              text: "Weekly",
              controller: controller,
            ),
            MainButton(
              func: () {
                controller.selectFreq("Bi-Weekly");
              },
              text: "Bi-Weekly",
              controller: controller,
            ),
            MainButton(
              func: () {
                controller.selectFreq("Monthly");
              },
              text: "Monthly",
              controller: controller,
            ),
          ],
        ));
  }
}

class MainButton extends StatelessWidget {
  const MainButton(
      {super.key,
      required this.func,
      required this.text,
      required this.controller});

  final VoidCallback func;
  final String text;
  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0, left: 8.0),
      child: InkWell(
        onTap: func,
        child: Obx(
          () => Container(
            alignment: Alignment.center,
            width: 90,
            height: 45,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: controller.selectedFreq.value == text
                    ? MainColors().buttonPink
                    : Colors.transparent,
                border: Border.all(color: MainColors().borderBlack)),
            child: Text(
              text,
              style: context.textTheme.displaySmall!.copyWith(
                  fontSize: 12,
                  color: controller.selectedFreq.value == text
                      ? MainColors().textWhite
                      : MainColors().mutedTextSilver),
            ),
          ),
        ),
      ),
    );
  }
}

class SelectCleaning extends StatelessWidget {
  const SelectCleaning({
    super.key,
    required this.controller,
  });

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                width: 140,
                height: 120,
                decoration: BoxDecoration(
                    color: MainColors().imgBackground,
                    borderRadius: BorderRadius.circular(20),
                    image: const DecorationImage(
                        image: AssetImage("assets/icons/1.png"))),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  "Initial Cleaning",
                  style: context.textTheme.labelSmall!
                      .copyWith(fontFamily: FontNames().monst["semiBold"]),
                ),
              ),
              Obx(
                () => Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: InkWell(
                    onTap: () {
                      controller.changeInitial();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: MainColors().buttonPink, width: 2),
                          color: controller.initialCleaning.value
                              ? MainColors().buttonPink
                              : Colors.transparent),
                      child: controller.initialCleaning.value
                          ? FaIcon(
                              FontAwesomeIcons.lightCheck,
                              color: MainColors().textWhite,
                              size: 10,
                            )
                          : Container(),
                    ),
                  ),
                ),
              )
            ],
          ),
          Column(
            children: [
              Container(
                alignment: Alignment.center,
                width: 140,
                height: 120,
                decoration: BoxDecoration(
                    color: MainColors().imgBackground,
                    borderRadius: BorderRadius.circular(20),
                    image: const DecorationImage(
                        image: AssetImage("assets/icons/2.png"))),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  "Upkeep Cleaning",
                  style: context.textTheme.labelSmall!
                      .copyWith(fontFamily: FontNames().monst["semiBold"]),
                ),
              ),
              Obx(
                () => Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: InkWell(
                    onTap: () {
                      controller.changeUpwork();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: MainColors().buttonPink, width: 2),
                          color: controller.upworkCleaning.value
                              ? MainColors().buttonPink
                              : Colors.transparent),
                      child: controller.upworkCleaning.value
                          ? FaIcon(
                              FontAwesomeIcons.lightCheck,
                              color: MainColors().textWhite,
                              size: 10,
                            )
                          : Container(),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
