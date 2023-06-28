import 'package:bolt/Screens/Auth%20Screens/error_screen.dart';
import 'package:bolt/Theme/colors.dart';
import 'package:bolt/Theme/font_family.dart';
import 'package:bolt/Theme/font_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';

import '../../Components/fragments.dart';
import '../../Utils/firebase_functions.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    phoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: MainColors.mainPageColor,
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: ListView(
          children: [
            upperRow(size),
            Padding(
              padding: const EdgeInsets.only(right: 30.0, left: 30, top: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Text(
                        "Name",
                        style: TextStyle(
                          fontSize: FontSizes.mainText,
                          color: MainColors.black,
                          fontFamily: FontFamily.bold,
                        ),
                      )),
                  SizedBox(
                    height: 80,
                    width: size.width * 0.8,
                    child: TextField(
                      maxLength: 32,
                      controller: nameController,
                      style: Fragments().mainTextStyle(
                        FontSizes.smText,
                        MainColors.black,
                        FontFamily.semiBold,
                      ),
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14.0),
                            borderSide:
                                BorderSide(color: MainColors.gray, width: 1.0)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14.0),
                            borderSide:
                                BorderSide(color: MainColors.gray, width: 1.0)),
                        hintText: 'Enter Name',
                        hintStyle: Fragments().mainTextStyle(FontSizes.mainText,
                            MainColors.gray, FontFamily.semiBold),
                      ),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Text(
                        "Phone Number",
                        style: TextStyle(
                          fontSize: FontSizes.mainText,
                          color: MainColors.black,
                          fontFamily: FontFamily.bold,
                        ),
                      )),
                  SizedBox(
                    height: 80,
                    width: size.width * 0.8,
                    child: TextField(
                      maxLength: 11,
                      controller: phoneController,
                      style: Fragments().mainTextStyle(
                        FontSizes.smText,
                        MainColors.black,
                        FontFamily.semiBold,
                      ),
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14.0),
                            borderSide:
                                BorderSide(color: MainColors.gray, width: 1.0)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14.0),
                            borderSide:
                                BorderSide(color: MainColors.gray, width: 1.0)),
                        hintText: 'Enter Phone Number',
                        hintStyle: Fragments().mainTextStyle(FontSizes.mainText,
                            MainColors.gray, FontFamily.semiBold),
                      ),
                    ),
                  ),
                  Padding(padding: const EdgeInsets.only(top: 20) ,
                  child:    Fragments().mainButton(
                      size,
                      isLoading ? "Loading" : "Change Profile",
                      isLoading ? MainColors.gray : MainColors.purple,
                      FontSizes.buttonTitle,
                      MainColors.white,
                      isLoading
                          ? () {}
                          : () {
                              if (nameController.text.isNotEmpty &&
                                  phoneController.text.isNotEmpty) {
                                setState(() {
                                  isLoading = true;
                                });
                                FirebaseFunctions().updateUserInfo(
                                  nameController.text.trim(),
                                  phoneController.text.trim(),
                                );
                              } else {
                                setState(() {
                                  isLoading = false;
                                });
                                Get.to(const ErrorScreen(
                                    message: "All Fields are Mandatory"));
                              }
                            }) ,),

                ],
              ),
            )
          ],
        ),
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
    return SizedBox(
      height: 50,
      child: Row(
        children: [
          IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                FeatherIcons.arrowLeft,
                color: MainColors.black,
              )),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "Edit Profile",
                style: Fragments().mainTextStyle(
                    FontSizes.mainText, MainColors.black, FontFamily.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
