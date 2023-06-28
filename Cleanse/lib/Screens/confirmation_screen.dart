import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:house_cleaning/Controller/home_controller.dart';
import 'package:house_cleaning/Routes/page_routes.dart';
import 'package:house_cleaning/utils/firebase_functions.dart';
import 'package:house_cleaning/utils/main_colors.dart';
import '../utils/font_names.dart';
import '../main.dart';
import "../Models/user_model.dart";
import 'package:objectbox/objectbox.dart';

class ConfirmationScreen extends StatefulWidget {
  const ConfirmationScreen({super.key});

  @override
  State<ConfirmationScreen> createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen> {


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Box<User> userData = objectBox.store.box<User>();

    HomeController controller = Get.find<HomeController>();
    return Scaffold(
      body: SafeArea(
          child: SizedBox(
        width: size.width,
        height: size.height,
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.15,
              width: size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: FaIcon(
                        FontAwesomeIcons.lightArrowLeft,
                        size: 14,
                        color: MainColors().textWhite,
                      )),
                  Text(
                    "Confirm Your Cleaning",
                    style: context.textTheme.bodyMedium,
                  ),
                  Container()
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: size.width,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(14),
                      topRight: Radius.circular(14)),
                  color: MainColors().textWhite,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 25.0, left: 20),
                  child: ListView(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Name",
                            style: context.textTheme.labelMedium!
                                .copyWith(fontFamily: FontNames().pub["bold"]),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 25.0),
                            child: Text(
                              userData.count() == 0
                                  ? "Not Found"
                                  : userData.get(1)!.name,
                              style: context.textTheme.labelMedium!.copyWith(
                                  fontFamily: FontNames().pub["semiBold"],
                                  color: MainColors().backgroundPurple),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 25.0),
                            child: Text(
                              "Address",
                              style: context.textTheme.labelMedium!.copyWith(
                                  fontFamily: FontNames().pub["bold"]),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 25.0),
                            child: Text(
                              userData.count() == 0
                                  ? "Not Found"
                                  : userData.get(1)!.address,
                              style: context.textTheme.labelMedium!.copyWith(
                                  fontFamily: FontNames().pub["semiBold"],
                                  color: MainColors().backgroundPurple),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 25.0),
                            child: Text(
                              "Cleaning Type Selected",
                              style: context.textTheme.labelMedium!.copyWith(
                                  fontFamily: FontNames().pub["bold"]),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 25.0),
                            child: Text(
                              controller.initialCleaning.value
                                  ? "Initial Cleaning"
                                  : "Upwork Cleaning",
                              style: context.textTheme.labelMedium!.copyWith(
                                  fontFamily: FontNames().pub["semiBold"],
                                  color: MainColors().backgroundPurple),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 25.0),
                            child: Text(
                              "Frequency Selected",
                              style: context.textTheme.labelMedium!.copyWith(
                                  fontFamily: FontNames().pub["bold"]),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 25.0),
                            child: Text(
                              controller.selectedFreq.value,
                              style: context.textTheme.labelMedium!.copyWith(
                                  fontFamily: FontNames().pub["semiBold"],
                                  color: MainColors().backgroundPurple),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 25.0),
                            child: Text(
                              "Extras Selected",
                              style: context.textTheme.labelMedium!.copyWith(
                                  fontFamily: FontNames().pub["bold"]),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 25.0),
                            child: Text(
                              "Inside Fridge X ${controller.vals[ValNames.inFridge].toString()}",
                              style: context.textTheme.labelMedium!.copyWith(
                                  fontFamily: FontNames().pub["semiBold"],
                                  color: MainColors().backgroundPurple),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 25.0),
                            child: Text(
                              "Organizing X ${controller.vals[ValNames.orgVal].toString()}",
                              style: context.textTheme.labelMedium!.copyWith(
                                  fontFamily: FontNames().pub["semiBold"],
                                  color: MainColors().backgroundPurple),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 25.0),
                            child: Text(
                              "Small Blinds X ${controller.vals[ValNames.blindsVal].toString()}",
                              style: context.textTheme.labelMedium!.copyWith(
                                  fontFamily: FontNames().pub["semiBold"],
                                  color: MainColors().backgroundPurple),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 25.0),
                            child: Text(
                              "Patio X ${controller.vals[ValNames.patioVal].toString()}",
                              style: context.textTheme.labelMedium!.copyWith(
                                  fontFamily: FontNames().pub["semiBold"],
                                  color: MainColors().backgroundPurple),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 25.0),
                            child: Text(
                              "Chimney X ${controller.vals[ValNames.chimneyVal].toString()}",
                              style: context.textTheme.labelMedium!.copyWith(
                                  fontFamily: FontNames().pub["semiBold"],
                                  color: MainColors().backgroundPurple),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 25.0),
                            child: Text(
                              "Garage X ${controller.vals[ValNames.garageVal].toString()}",
                              style: context.textTheme.labelMedium!.copyWith(
                                  fontFamily: FontNames().pub["semiBold"],
                                  color: MainColors().backgroundPurple),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 25.0, bottom: 10),
                            child: Center(
                              child: InkWell(
                                onTap: () {
                                  controller.changeisCon(true);
                                  if (userData.count() == 0) {
                                    Get.toNamed(PageRoutes().userDataScreen,
                                        arguments: false);
                                    controller.changeisCon(false);
                                  } else {
                                    FirebaseFunctions().addServicetoFirebase(
                                        userData.get(1)!.address, () {
                                      showConfirmDialog(size);

                                      controller.changeisCon(false);
                                    }, context);
                                  }
                                },
                                child: Obx(
                                  () => Container(
                                    height: 50,
                                    width: size.width * 0.8,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(14),
                                        color: controller.isConLoading.value
                                            ? MainColors().borderBlack
                                            : MainColors().backgroundPurple),
                                    child: controller.isConLoading.value
                                        ? Image.asset(
                                            'assets/icons/loading.gif')
                                        : Text(
                                            "Confirm",
                                            style: context.textTheme.bodyMedium!
                                                .copyWith(
                                              fontFamily:
                                                  FontNames().pub["semiBold"],
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }

  showConfirmDialog(
    size,
  ) {
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              height: 400,
              width: 350,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: MainColors().backgroundPurple),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {
                              Get.offAllNamed(PageRoutes().swipeScreen , arguments: 1);
                            },
                            icon: const FaIcon(
                              FontAwesomeIcons.lightTimes,
                              color: Colors.white,
                              size: 18,
                            )),
                        Container(),
                      ],
                    ),
                    Image.asset("assets/icons/giphy.gif"),
                    Text(
                      "Yeah !! Your session is confirmed with us",
                      style: context.textTheme.bodyMedium!.copyWith(
                        fontFamily: FontNames().pub["semiBold"],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        "Our Cleaner Will arrive in under 3 hours",
                        style: context.textTheme.bodyMedium!.copyWith(
                          fontFamily: FontNames().pub["semiBold"],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
