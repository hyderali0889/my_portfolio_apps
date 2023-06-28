import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:house_cleaning/utils/font_names.dart';

import '../utils/main_colors.dart';

class DialogBox {
  errDialog(context, text, desc) {
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
                              Get.back();
                            },
                            icon: const FaIcon(
                              FontAwesomeIcons.lightTimes,
                              color: Colors.white,
                              size: 18,
                            )),
                        Container(),
                      ],
                    ),
                    const FaIcon(
                      FontAwesomeIcons.solidWindWarning,
                      color: Colors.red,
                      size: 150,
                    ),
                    Text(
                      text,
                      style: context.textTheme.bodyMedium!.copyWith(
                        fontFamily: FontNames().pub["semiBold"],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        desc,
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
