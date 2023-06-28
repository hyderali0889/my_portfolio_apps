import 'dart:ui';
import 'package:bolt/Components/fragments.dart';
import 'package:bolt/Theme/colors.dart';
import 'package:bolt/Theme/font_sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'login_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: MainColors.purple,
        body: SizedBox(
          width: size.width,
          height: size.height,
          child: ListView(
            children: [
              Column(
                children: [
                  mainHeading("Find Your \n Gadget", FontSizes.splashHeading,
                      MainColors.white, size),
                  mainIllustration(size),
                  mainButton(size, "Get Started", MainColors.white,
                      FontSizes.buttonTitle, MainColors.purple)
                ],
              )
            ],
          ),
        ));
  }

/*
?
?        Yb        dP 88 8888b.   dP""b8 888888 888888     .dP"Y8 888888  dP""b8 888888 88  dP"Yb  88b 88
?         Yb  db  dP  88  8I  Yb dP   `" 88__     88       `Ybo." 88__   dP   `"   88   88 dP   Yb 88Yb88
?          YbdPYbdP   88  8I  dY Yb  "88 88""     88       o.`Y8b 88""   Yb        88   88 Yb   dP 88 Y88
?           YP  YP    88 8888Y"   YboodP 888888   88       8bodP' 888888  YboodP   88   88  YbodP  88  Y8
*/


/*
!  Yb        dP 88 8888b.   dP""b8 888888 888888      dP"Yb  88b 88 888888
!   Yb  db  dP  88  8I  Yb dP   `" 88__     88       dP   Yb 88Yb88 88__
!    YbdPYbdP   88  8I  dY Yb  "88 88""     88       Yb   dP 88 Y88 88""
!     YP  YP    88 8888Y"   YboodP 888888   88        YbodP  88  Y8 888888
*/

  Widget mainHeading(title, size, color, contextSize) {
    return Stack(
      children: [
            Padding(
              padding: const EdgeInsets.only(top: 120.0, left: 50),
              child: Opacity(
                opacity: 0.4,
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      shape: BoxShape.circle,
                      border: Border.all(width: 4, color: Colors.white)),
                ),
              ),
            ),

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
        Container(
          margin: const EdgeInsets.only(top: 40),
          width: contextSize.width,
          child: Center(
            child: Fragments().headingText(title, size, color),
          ),
        )
      ],
    );
  }


  /*
 ! Yb        dP 88 8888b.   dP""b8 888888 888888     888888 Yb        dP  dP"Yb
 !  Yb  db  dP  88  8I  Yb dP   `" 88__     88         88    Yb  db  dP  dP   Yb
 !   YbdPYbdP   88  8I  dY Yb  "88 88""     88         88     YbdPYbdP   Yb   dP
 !    YP  YP    88 8888Y"   YboodP 888888   88         88      YP  YP     YbodP
  */

  Widget mainIllustration(Size size) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Stack(
        children: [
          Image.asset(
            "assets/imgs/Saly-19.png",
          ),
          Positioned(
            bottom: 0,
            child: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 11.0, sigmaY: 11.0),
                child: SizedBox(
                  height: 20,
                  width: size.width,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

/*
 !      Yb        dP 88 8888b.   dP""b8 888888 888888     888888 88  88 88""Yb 888888 888888
 !       Yb  db  dP  88  8I  Yb dP   `" 88__     88         88   88  88 88__dP 88__   88__
 !        YbdPYbdP   88  8I  dY Yb  "88 88""     88         88   888888 88"Yb  88""   88""
 !         YP  YP    88 8888Y"   YboodP 888888   88         88   88  88 88  Yb 888888 888888
*/

  Widget mainButton(size, title, color, textSize, textColor) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(seconds: 1),
      builder: ((context, double value, child) {
        return Opacity(
          opacity: value,
          child: Padding(
            padding: EdgeInsets.only(top: value * 80),
            child: Fragments()
                .mainButton(size, title, color, textSize, textColor, funcbtn),
          ),
        );
      }),
    );
  }

  /*
 Todo  888888 88   88 88b 88  dP""b8 888888 88  dP"Yb  88b 88 .dP"Y8     .dP"Y8 888888  dP""b8 888888 88  dP"Yb  88b 88
 Todo  88__   88   88 88Yb88 dP   `"   88   88 dP   Yb 88Yb88 `Ybo."     `Ybo." 88__   dP   `"   88   88 dP   Yb 88Yb88
 Todo  88""   Y8   8P 88 Y88 Yb        88   88 Yb   dP 88 Y88 o.`Y8b     o.`Y8b 88""   Yb        88   88 Yb   dP 88 Y88
 Todo  88     `YbodP' 88  Y8  YboodP   88   88  YbodP  88  Y8 8bodP'     8bodP' 888888  YboodP   88   88  YbodP  88  Y8
  */


/*
 *      888888 88   88 88b 88  dP""b8 888888 88  dP"Yb  88b 88      dP"Yb  88b 88 888888
 *      88__   88   88 88Yb88 dP   `"   88   88 dP   Yb 88Yb88     dP   Yb 88Yb88 88__
 *      88""   Y8   8P 88 Y88 Yb        88   88 Yb   dP 88 Y88     Yb   dP 88 Y88 88""
 *      88     `YbodP' 88  Y8  YboodP   88   88  YbodP  88  Y8      YbodP  88  Y8 888888
*/

  funcbtn() {
    Get.offAll ( ()=> const LoginScreen());
  }


    /*
 << 888888 88b 88 8888b.       dP"Yb  888888      dP""b8 88        db    .dP"Y8 .dP"Y8
 << 88__   88Yb88  8I  Yb     dP   Yb 88__       dP   `" 88       dPYb   `Ybo." `Ybo."
 << 88""   88 Y88  8I  dY     Yb   dP 88""       Yb      88  .o  dP__Yb  o.`Y8b o.`Y8b
 << 888888 88  Y8 8888Y"       YbodP  88          YboodP 88ood8 dP""""Yb 8bodP' 8bodP'
  */
}
