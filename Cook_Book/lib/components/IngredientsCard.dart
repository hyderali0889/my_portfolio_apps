// ignore_for_file: file_names

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hovering/hovering.dart';

import '../Theme/Colors.dart';
import '../Theme/Sizes.dart';
import '../Theme/Spacing.dart';

class IngredientsCard extends StatelessWidget {
  const IngredientsCard(
      {Key? key,
      required this.headingText,
      required this.text,
      required this.func})
      : super(key: key);

  final String headingText;
  final String text;
  final VoidCallback func;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 15.0, 15.0),
      child: Container(
        width: 350,
        decoration: BoxDecoration(
          color: Color.iconColor,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Text(headingText,
                    style: TextStyle(
                        color: Color.headingColor, fontSize: Sizes.lg)),
              ),
              SizedBox(
                height: 120,
                child: SingleChildScrollView(
                    child: Text(text,
                        style: TextStyle(
                            color: Color.simpleColor,
                            fontFamily: "QuickSand",
                            fontSize: Sizes.sm))),
              ),
              Expanded(
                child: Center(
                  child: HoverButton(
                    onpressed: func,
                    color: Platform.isAndroid || Platform.isIOS
                        ? Color.foregroundColor
                        : Color.iconColor,
                    hoverColor: Color.foregroundColor,
                    minWidth: Spacing.xl * 5,
                    height: Spacing.xl,
                    child: Text(" Get Details ",
                        style: TextStyle(
                            color: Color.textColor,
                            fontFamily: "QuickSand",
                            fontSize: Sizes.md)),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
