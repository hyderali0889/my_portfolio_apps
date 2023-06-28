
import 'package:bolt/Theme/font_family.dart';
import 'package:bolt/Theme/font_sizes.dart';
import 'package:bolt/Utils/firebase_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';

import '../../Components/fragments.dart';
import '../../Controllers/error_screen_controller.dart';
import '../../Theme/colors.dart';
import 'error_screen.dart';
import 'login_screen.dart';


class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController emailController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    Get.put(ErrorController());
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ErrorController controller = Get.find<ErrorController>();

    return Scaffold(
        backgroundColor: MainColors.purple,
        body: SizedBox(
          width: size.width,
          height: size.height,
          child: ListView(
            children: [
              SizedBox(
                width: size.width,
                height: size.height,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                          onPressed: goBack,
                          icon: Icon(
                            Icons.keyboard_arrow_left_outlined,
                            color: MainColors.white,
                          )),
                    ),
                    mainHeading("Reset \n Password", FontSizes.splashHeading,
                        MainColors.white, size),
                    Expanded(child: loginSection(size, controller))
                  ],
                ),
              )
            ],
          ),
        ));
  }

  /*
 ? Yb        dP 88 8888b.   dP""b8 888888 888888     .dP"Y8 888888  dP""b8 888888 88  dP"Yb  88b 88
 ?  Yb  db  dP  88  8I  Yb dP   `" 88__     88       `Ybo." 88__   dP   `"   88   88 dP   Yb 88Yb88
 ?   YbdPYbdP   88  8I  dY Yb  "88 88""     88       o.`Y8b 88""   Yb        88   88 Yb   dP 88 Y88
 ?    YP  YP    88 8888Y"   YboodP 888888   88       8bodP' 888888  YboodP   88   88  YbodP  88  Y8
  */

  /*
 ! Yb        dP 88 8888b.   dP""b8 888888 888888      dP"Yb  88b 88 888888
 !  Yb  db  dP  88  8I  Yb dP   `" 88__     88       dP   Yb 88Yb88 88__
 !   YbdPYbdP   88  8I  dY Yb  "88 88""     88       Yb   dP 88 Y88 88""
 !    YP  YP    88 8888Y"   YboodP 888888   88        YbodP  88  Y8 888888
  */

  Widget mainHeading(title, size, color, contextSize) {
    return Stack(
      children: [
        Container(
          alignment: Alignment.topRight,
          width: contextSize.width,
          child: Container(
            margin: const EdgeInsets.only(right: 50),
            width: 100,
            height: 70,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(0),
                topRight: Radius.circular(0),
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
              gradient: LinearGradient(colors: [
                Colors.purple,
                Colors.transparent,
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20.0, left: 20),
          child: Opacity(
            opacity: 0.4,
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(width: 4, color: Colors.white)),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 120.0, left: 200),
          child: Opacity(
            opacity: 0.4,
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(width: 4, color: Colors.white)),
            ),
          ),
        ),
        SizedBox(
          width: contextSize.width,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 60),
              child: Fragments().headingText(title, size, color),
            ),
          ),
        ),
      ],
    );
  }

  /*
  !Yb        dP 88 8888b.   dP""b8 888888 888888     888888 Yb        dP  dP"Yb
  ! Yb  db  dP  88  8I  Yb dP   `" 88__     88         88    Yb  db  dP  dP   Yb
  !  YbdPYbdP   88  8I  dY Yb  "88 88""     88         88     YbdPYbdP   Yb   dP
  !   YP  YP    88 8888Y"   YboodP 888888   88         88      YP  YP     YbodP
  */

  Widget loginSection(size, controller) {
    return Container(
      width: size.width,
      margin: const EdgeInsets.only(top: 40),
      decoration: BoxDecoration(
          color: MainColors.white,
          borderRadius: const BorderRadius.horizontal(
              left: Radius.circular(14.0), right: Radius.circular(14.0))),
      child: Padding(
        padding: const EdgeInsets.only(top: 30.0, left: 50, right: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Reset Password',
              style: Fragments().mainTextStyle(
                  FontSizes.subTitle, MainColors.black, FontFamily.bold),
            ),
            Column(children: [
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Row(
                  children: [
                    Icon(
                      FeatherIcons.mail,
                      color: MainColors.gray,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        '  Email',
                        style: Fragments().mainTextStyle(FontSizes.smText,
                            MainColors.gray, FontFamily.semiBold),
                      ),
                    ),
                  ],
                ),
              ),
              TextField(
                controller: emailController,
                style: Fragments().mainTextStyle(
                  FontSizes.smText,
                  MainColors.black,
                  FontFamily.semiBold,
                ),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: MainColors.gray, width: 1.0)),
                  enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: MainColors.gray, width: 1.0)),
                  hintText: "email",
                  hintStyle: Fragments().mainTextStyle(
                      FontSizes.mainText, MainColors.gray, FontFamily.semiBold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: isLoading
                    ?  Obx( ()=>controller.isError.value
                        ? Fragments().mainButton(
                            size,
                            "Reset Password",
                            MainColors.purple,
                            FontSizes.buttonTitle,
                            MainColors.white,
                            resetPass)
                        : Fragments().loadingButton(MainColors.turquiose, size))
                    : Fragments().mainButton(
                        size,
                        "Reset Password",
                        MainColors.purple,
                        FontSizes.buttonTitle,
                        MainColors.white,
                        resetPass),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: TextButton(
                  onPressed: goToLogin,
                  child: Text(
                    "Back To Login",
                    style: Fragments().mainTextStyle(FontSizes.mainText,
                        MainColors.lightPurple, FontFamily.bold),
                  ),
                ),
              ),
            ])
          ],
        ),
      ),
    );
  }

  /*
 Todo 888888 88   88 88b 88  dP""b8 888888 88  dP"Yb  88b 88 .dP"Y8     .dP"Y8 888888  dP""b8 888888 88  dP"Yb  88b 88
 Todo 88__   88   88 88Yb88 dP   `"   88   88 dP   Yb 88Yb88 `Ybo."     `Ybo." 88__   dP   `"   88   88 dP   Yb 88Yb88
 Todo 88""   Y8   8P 88 Y88 Yb        88   88 Yb   dP 88 Y88 o.`Y8b     o.`Y8b 88""   Yb        88   88 Yb   dP 88 Y88
 Todo 88     `YbodP' 88  Y8  YboodP   88   88  YbodP  88  Y8 8bodP'     8bodP' 888888  YboodP   88   88  YbodP  88  Y8
  */

  /*
 * 888888 88   88 88b 88  dP""b8 888888 88  dP"Yb  88b 88      dP"Yb  88b 88 888888
 * 88__   88   88 88Yb88 dP   `"   88   88 dP   Yb 88Yb88     dP   Yb 88Yb88 88__
 * 88""   Y8   8P 88 Y88 Yb        88   88 Yb   dP 88 Y88     Yb   dP 88 Y88 88""
 * 88     `YbodP' 88  Y8  YboodP   88   88  YbodP  88  Y8      YbodP  88  Y8 888888
  */

  resetPass() {
    try {
      if (emailController.text.isEmpty) {
        Get.dialog(const ErrorScreen(
          message: "Either the fields are empty or password is too weak",
        ));
      } else {
        Get.find<ErrorController>().changeError(false);

        setState(() {
          isLoading = true;
        });
        FirebaseFunctions().resetPassword(emailController.text.trim());
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      Get.dialog(
          const ErrorScreen(
            message: "Either the fields are empty or password is too weak",
          ),
          barrierDismissible: true);
    }
  }

  /*
 * 888888 88   88 88b 88  dP""b8 888888 88  dP"Yb  88b 88 888888 Yb        dP  dP"Yb
 * 88__   88   88 88Yb88 dP   `"   88   88 dP   Yb 88Yb88   88    Yb  db  dP  dP   Yb
 * 88""   Y8   8P 88 Y88 Yb        88   88 Yb   dP 88 Y88   88     YbdPYbdP   Yb   dP
 * 88     `YbodP' 88  Y8  YboodP   88   88  YbodP  88  Y8   88      YP  YP     YbodP
  */

  goToLogin() {
    Get.to(() => const LoginScreen());
  }

/*
*   888888 88   88 88b 88  dP""b8 888888 88  dP"Yb  88b 88     888888 88  88 88""Yb 888888 888888
*   88__   88   88 88Yb88 dP   `"   88   88 dP   Yb 88Yb88       88   88  88 88__dP 88__   88__
*   88""   Y8   8P 88 Y88 Yb        88   88 Yb   dP 88 Y88       88   888888 88"Yb  88""   88""
*   88     `YbodP' 88  Y8  YboodP   88   88  YbodP  88  Y8       88   88  88 88  Yb 888888 888888
*/

  goBack() {
    Get.back();
  }

  /*
 << 888888 88b 88 8888b.       dP"Yb  888888      dP""b8 88        db    .dP"Y8 .dP"Y8
 << 88__   88Yb88  8I  Yb     dP   Yb 88__       dP   `" 88       dPYb   `Ybo." `Ybo."
 << 88""   88 Y88  8I  dY     Yb   dP 88""       Yb      88  .o  dP__Yb  o.`Y8b o.`Y8b
 << 888888 88  Y8 8888Y"       YbodP  88          YboodP 88ood8 dP""""Yb 8bodP' 8bodP'
  */
}
