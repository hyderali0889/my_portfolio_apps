import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:house_cleaning/Controller/home_controller.dart';
import 'package:house_cleaning/utils/font_names.dart';
import 'package:house_cleaning/utils/main_colors.dart';
import '../Components/dialog_box.dart';
import '../Models/user_model.dart';
import '../Routes/page_routes.dart';
import '../main.dart';
import '../objectbox.g.dart';

class UserDataScreen extends StatefulWidget {
  const UserDataScreen({super.key});

  @override
  State<UserDataScreen> createState() => _UserDataScreenState();
}

class _UserDataScreenState extends State<UserDataScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Box<User> userData = objectBox.store.box<User>();
    HomeController controller = Get.find<HomeController>();

    TextEditingController nameController = TextEditingController();
    TextEditingController addressController = TextEditingController();

    return Scaffold(
      body: SafeArea(
          child: SizedBox(
        width: size.width,
        height: size.height,
        child: Column(
          children: [
            SizedBox(
              width: size.width,
              height: size.height * 0.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: FaIcon(
                        FontAwesomeIcons.arrowLeft,
                        color: MainColors().textWhite,
                        size: 18,
                      )),
                  Text(
                    "Add Your Info",
                    style: context.textTheme.bodyMedium!
                        .copyWith(fontFamily: FontNames().monst["bold"]),
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
                child: Obx(
                  () => Padding(
                    padding:
                        const EdgeInsets.only(left: 15.0, right: 15.0, top: 30),
                    child: userData.count() != 0 &&
                            !controller.isProfileUpdating.value
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Name",
                                style: context.textTheme.labelMedium!.copyWith(
                                    fontFamily: FontNames().pub["bold"]),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 25.0),
                                child: Text(
                                  userData.count() == 0
                                      ? "Not Found"
                                      : userData.get(1)!.name,
                                  style: context.textTheme.labelMedium!
                                      .copyWith(
                                          fontFamily:
                                              FontNames().pub["semiBold"],
                                          color: MainColors().backgroundPurple),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 25.0),
                                child: Text(
                                  "Address",
                                  style: context.textTheme.labelMedium!
                                      .copyWith(
                                          fontFamily: FontNames().pub["bold"]),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 25.0),
                                child: Text(
                                  userData.count() == 0
                                      ? "Not Found"
                                      : userData.get(1)!.address,
                                  style: context.textTheme.labelMedium!
                                      .copyWith(
                                          fontFamily:
                                              FontNames().pub["semiBold"],
                                          color: MainColors().backgroundPurple),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 25.0, bottom: 10),
                                child: Center(
                                  child: InkWell(
                                    onTap: () {
                                      controller.updateProfile(true);
                                    },
                                    child: Obx(
                                      () => Container(
                                        height: 50,
                                        width: size.width * 0.8,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(14),
                                            color: controller.isAddLoading.value
                                                ? MainColors().borderBlack
                                                : MainColors()
                                                    .backgroundPurple),
                                        child: controller.isAddLoading.value
                                            ? Image.asset(
                                                'assets/icons/loading.gif')
                                            : Text(
                                                "Update Data",
                                                style: context
                                                    .textTheme.bodyMedium!
                                                    .copyWith(
                                                  fontFamily: FontNames()
                                                      .pub["semiBold"],
                                                ),
                                              ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                        : controller.isProfileUpdating.value
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Name",
                                    style: context.textTheme.labelLarge,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: SizedBox(
                                      height: 50,
                                      child: TextField(
                                        controller: nameController,
                                        style: context.textTheme.labelMedium,
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: MainColors()
                                                        .borderBlack))),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20.0),
                                    child: Text(
                                      "Address",
                                      style: context.textTheme.labelLarge,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: SizedBox(
                                      height: 50,
                                      child: TextField(
                                        controller: addressController,
                                        style: context.textTheme.labelMedium,
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: MainColors()
                                                        .borderBlack))),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 25.0, bottom: 10),
                                    child: Center(
                                      child: InkWell(
                                        onTap: () {
                                          controller.changeisAdd(true);
                                          controller.updateProfile(false);
                                          if (nameController.text.isEmpty ||
                                              addressController.text.isEmpty) {
                                            DialogBox().errDialog(
                                                context,
                                                "ERROR",
                                                "Name or address field is empty");
                                            return;
                                          }

                                          User data = User(
                                              id: 1,
                                              name: nameController.text.trim(),
                                              address: addressController.text
                                                  .trim());
                                          userData.put(data);
                                          controller.changeisAdd(false);
                                        },
                                        child: Obx(
                                          () => Container(
                                            height: 50,
                                            width: size.width * 0.8,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(14),
                                                color: controller
                                                        .isAddLoading.value
                                                    ? MainColors().borderBlack
                                                    : MainColors()
                                                        .backgroundPurple),
                                            child: controller.isAddLoading.value
                                                ? Image.asset(
                                                    'assets/icons/loading.gif')
                                                : Text(
                                                    "Update Data",
                                                    style: context
                                                        .textTheme.bodyMedium!
                                                        .copyWith(
                                                      fontFamily: FontNames()
                                                          .pub["semiBold"],
                                                    ),
                                                  ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Name",
                                    style: context.textTheme.labelLarge,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: SizedBox(
                                      height: 50,
                                      child: TextField(
                                        controller: nameController,
                                        style: context.textTheme.labelMedium,
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: MainColors()
                                                        .borderBlack))),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20.0),
                                    child: Text(
                                      "Address",
                                      style: context.textTheme.labelLarge,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: SizedBox(
                                      height: 50,
                                      child: TextField(
                                        controller: addressController,
                                        style: context.textTheme.labelMedium,
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: MainColors()
                                                        .borderBlack))),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 25.0, bottom: 10),
                                    child: Center(
                                      child: InkWell(
                                        onTap: () {
                                          if (nameController.text.isEmpty ||
                                              addressController.text.isEmpty) {
                                            DialogBox().errDialog(
                                                context,
                                                "ERROR",
                                                "Name or address field is empty");
                                            return;
                                          }

                                          controller.changeisAdd(true);
                                          User data = User(
                                              name: nameController.text.trim(),
                                              address: addressController.text
                                                  .trim());
                                          userData.put(data);
                                          controller.changeisAdd(false);

                                          if (Get.arguments) {
                                            Get.toNamed(
                                                PageRoutes().swipeScreen);
                                          } else {
                                            Get.toNamed(PageRoutes()
                                                .confirmationScreen);
                                          }
                                        },
                                        child: Obx(
                                          () => Container(
                                            height: 50,
                                            width: size.width * 0.8,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(14),
                                                color: controller
                                                        .isAddLoading.value
                                                    ? MainColors().borderBlack
                                                    : MainColors()
                                                        .backgroundPurple),
                                            child: controller.isAddLoading.value
                                                ? Image.asset(
                                                    'assets/icons/loading.gif')
                                                : Text(
                                                    "Confirm",
                                                    style: context
                                                        .textTheme.bodyMedium!
                                                        .copyWith(
                                                      fontFamily: FontNames()
                                                          .pub["semiBold"],
                                                    ),
                                                  ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                  ),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
