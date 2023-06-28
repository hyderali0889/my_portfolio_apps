import 'package:bolt/Theme/colors.dart';
import 'package:bolt/Theme/font_family.dart';
import 'package:bolt/Theme/font_sizes.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class Fragments {
  /*
 * 888888 88""Yb    db     dP""b8 8b    d8 888888 88b 88 888888      dP"Yb  88b 88 888888
 * 88__   88__dP   dPYb   dP   `" 88b  d88 88__   88Yb88   88       dP   Yb 88Yb88 88__
 * 88""   88"Yb   dP__Yb  Yb  "88 88YbdP88 88""   88 Y88   88       Yb   dP 88 Y88 88""
 * 88     88  Yb dP""""Yb  YboodP 88 YY 88 888888 88  Y8   88        YbodP  88  Y8 888888
  */
  mainButton(Size size, String title, Color color, double textSize,
      Color textColor, VoidCallback func) {
    return InkWell(
      onTap: func,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: color,
        ),
        width: size.width * 0.8,
        height: 60,
        child: Center(
            child: Text(title,
                style: mainTextStyle(textSize, textColor, FontFamily.bold))),
      ),
    );
  }

  loadingButton(color, size) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: color,
      ),
      width: size.width * 0.8,
      height: 60,
      child: Center(child: Image.asset("assets/gifs/loading.gif")),
    );
  }

  /*
 * 888888 88""Yb    db     dP""b8 8b    d8 888888 88b 88 888888     888888 Yb        dP  dP"Yb
 * 88__   88__dP   dPYb   dP   `" 88b  d88 88__   88Yb88   88         88    Yb  db  dP  dP   Yb
 * 88""   88"Yb   dP__Yb  Yb  "88 88YbdP88 88""   88 Y88   88         88     YbdPYbdP   Yb   dP
 * 88     88  Yb dP""""Yb  YboodP 88 YY 88 888888 88  Y8   88         88      YP  YP     YbodP
  */

  headingText(String title, double size, Color color) {
    return Text(title, style: mainTextStyle(size, color, FontFamily.extraBold));
  }

/*
  * 888888 88""Yb    db     dP""b8 8b    d8 888888 88b 88 888888     888888 88  88 88""Yb 888888 888888
  * 88__   88__dP   dPYb   dP   `" 88b  d88 88__   88Yb88   88         88   88  88 88__dP 88__   88__
  * 88""   88"Yb   dP__Yb  Yb  "88 88YbdP88 88""   88 Y88   88         88   888888 88"Yb  88""   88""
  * 88     88  Yb dP""""Yb  YboodP 88 YY 88 888888 88  Y8   88         88   88  88 88  Yb 888888 888888
*/

  mainTextStyle(double size, Color color, String family) {
    return TextStyle(
      fontFamily: family,
      color: color,
      fontSize: size,
    );
  }

  /*
 * 888888 88""Yb    db     dP""b8 8b    d8 888888 88b 88 888888     888888  dP"Yb  88   88 88""Yb
 * 88__   88__dP   dPYb   dP   `" 88b  d88 88__   88Yb88   88       88__   dP   Yb 88   88 88__dP
 * 88""   88"Yb   dP__Yb  Yb  "88 88YbdP88 88""   88 Y88   88       88""   Yb   dP Y8   8P 88"Yb
 * 88     88  Yb dP""""Yb  YboodP 88 YY 88 888888 88  Y8   88       88      YbodP  `YbodP' 88  Yb
  */
  textField(String hint, TextEditingController controller, bool obsecure,
      showFunc, bool isEmail) {
    return TextField(
      obscureText: obsecure,
      controller: controller,
      style: mainTextStyle(
        FontSizes.smText,
        MainColors.black,
        FontFamily.semiBold,
      ),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.zero,
        suffix: obsecure
            ? TextButton(
                onPressed: showFunc,
                child: const Text("Show"),
              )
            : isEmail
                ? const Spacer()
                : TextButton(
                    onPressed: showFunc,
                    child: const Text("Hide"),
                  ),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: MainColors.gray, width: 1.0)),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: MainColors.gray, width: 1.0)),
        hintText: hint,
        hintStyle: mainTextStyle(
            FontSizes.mainText, MainColors.gray, FontFamily.semiBold),
      ),
    );
  }

  /*
 * 888888 88""Yb    db     dP""b8 8b    d8 888888 88b 88 888888     888888 88 Yb    dP 888888
 * 88__   88__dP   dPYb   dP   `" 88b  d88 88__   88Yb88   88       88__   88  Yb  dP  88__
 * 88""   88"Yb   dP__Yb  Yb  "88 88YbdP88 88""   88 Y88   88       88""   88   YbdP   88""
 * 88     88  Yb dP""""Yb  YboodP 88 YY 88 888888 88  Y8   88       88     88    YP    888888
  */

  navRailLinks(String label, Widget icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            icon,
            Text(
              label,
              style: TextStyle(
                  color: MainColors.white,
                  fontFamily: FontFamily.semiBold,
                  fontSize: FontSizes.mainText),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 25.0, left: 30),
          child: Container(
            width: 180,
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
              color: Colors.white.withOpacity(0.2),
            ))),
          ),
        )
      ],
    );
  }

  /*
 * 888888 88""Yb    db     dP""b8 8b    d8 888888 88b 88 888888     .dP"Y8 88 Yb  dP
 * 88__   88__dP   dPYb   dP   `" 88b  d88 88__   88Yb88   88       `Ybo." 88  YbdP
 * 88""   88"Yb   dP__Yb  Yb  "88 88YbdP88 88""   88 Y88   88       o.`Y8b 88  dPYb
 * 88     88  Yb dP""""Yb  YboodP 88 YY 88 888888 88  Y8   88       8bodP' 88 dP  Yb
  */

  mainProductCard(data, index, type) {
    if (data[index]["Type"] == type) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Column(
                  children: [
                    Container(
                        margin: const EdgeInsets.only(top: 40),
                        height: 280,
                        width: 250,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.0),
                            color: MainColors.white),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 150.0, left: 20, right: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                  data[index]["Name"]
                                      .replaceAll(RegExp(r"\s+\b|\b\s"), " ")
                                      .trim(),
                                  textAlign: TextAlign.start,
                                  maxLines: 1,
                                  style: mainTextStyle(
                                    FontSizes.productTitle,
                                    MainColors.black,
                                    FontFamily.semiBold,
                                  )),
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Text(
                                    data[index]["Label"]
                                        .replaceAll(RegExp(r"\s+\b|\b\s"), " ")
                                        .trim(),
                                    textAlign: TextAlign.start,
                                    maxLines: 1,
                                    style: mainTextStyle(
                                      FontSizes.subText,
                                      MainColors.grey,
                                      FontFamily.semiBold,
                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Text(" \$ ${data[index]["Price"]}",
                                    textAlign: TextAlign.start,
                                    style: mainTextStyle(
                                      FontSizes.mainText,
                                      MainColors.purple,
                                      FontFamily.bold,
                                    )),
                              ),
                            ],
                          ),
                        ))
                  ],
                ),
              ),
              SizedBox(
                width: 250,
                child: Container(
                  width: 200,
                  height: 120,
                  decoration: BoxDecoration(
                      color: MainColors.white, shape: BoxShape.circle),
                  alignment: Alignment.topCenter,
                  child: Center(
                    child: Hero(
                      tag: data[index]["id"],
                      child: CachedNetworkImage(
                        height: 100,
                        width: 240,
                        placeholder: (context, url) => const SizedBox(
                            height: 50,
                            width: 50,
                            child: Center(child: CircularProgressIndicator())),
                        errorWidget: (context, url, error) => Icon(
                          FeatherIcons.alertTriangle,
                          color: MainColors.purple,
                        ),
                        imageUrl: data[index]["ImageUrl"],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return const SizedBox(
        height: 0,
        width: 0,
      );
    }
  }

  /*
 << 888888 88b 88 8888b.       dP"Yb  888888     888888 88""Yb    db     dP""b8 8b    d8 888888 88b 88 888888 .dP"Y8
 << 88__   88Yb88  8I  Yb     dP   Yb 88__       88__   88__dP   dPYb   dP   `" 88b  d88 88__   88Yb88   88   `Ybo."
 << 88""   88 Y88  8I  dY     Yb   dP 88""       88""   88"Yb   dP__Yb  Yb  "88 88YbdP88 88""   88 Y88   88   o.`Y8b
 << 888888 88  Y8 8888Y"       YbodP  88         88     88  Yb dP""""Yb  YboodP 88 YY 88 888888 88  Y8   88   8bodP'
  */
}
