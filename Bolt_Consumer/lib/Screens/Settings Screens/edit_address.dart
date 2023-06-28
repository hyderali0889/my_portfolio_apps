import 'package:bolt/Theme/colors.dart';
import 'package:bolt/Utils/firebase_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';

import '../../Components/fragments.dart';
import '../../Theme/font_family.dart';
import '../../Theme/font_sizes.dart';
import '../Auth Screens/error_screen.dart';

class EditAddress extends StatefulWidget {
  const EditAddress({super.key});

  @override
  State<EditAddress> createState() => _EditAddressState();
}

class _EditAddressState extends State<EditAddress> {
  bool isLoading = false;
  TextEditingController addressController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    addressController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: MainColors.mainPageColor,
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: ListView(
          children: [
            upperRow(size),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                height: 200,
                width: size.width * 0.8,
                child: TextField(
                  maxLines: 7,
                  maxLength: 62,
                  controller: addressController,
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
                    hintText: 'Enter Shipping Address',
                    hintStyle: Fragments().mainTextStyle(FontSizes.mainText,
                        MainColors.gray, FontFamily.semiBold),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Fragments().mainButton(
                  size,
                  isLoading ? "Loading" : "Change Address",
                  isLoading ? MainColors.gray : MainColors.purple,
                  FontSizes.buttonTitle,
                  MainColors.white,
                  isLoading
                      ? () {}
                      : () {
                         
                          if (addressController.text.isNotEmpty) {
                            setState(() {
                              isLoading = true;
                            });
                            FirebaseFunctions().updateUserAddress(
                                addressController.text.trim());
                          } else {
                            setState(() {
                              isLoading = false;
                            });
                            Get.to(const ErrorScreen(
                                message: "Address is Mandatory"));
                          }
                        }),
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
                "Edit Shipping Address",
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
