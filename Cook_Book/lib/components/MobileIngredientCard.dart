// ignore_for_file: file_names

import 'package:cook_book/Theme/Spacing.dart';
import 'package:flutter/material.dart';
import '../Theme/Colors.dart';
import '../Theme/Sizes.dart';

class MobileCard extends StatelessWidget {
  const MobileCard(
      {Key? key, required this.data, required this.fun, required this.img})
      : super(key: key);

  final Widget data;
  final Widget img;
  final VoidCallback fun;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14.0), color: Color.iconColor),
        width: 125,
        height: 208,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Center(child: img),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: SizedBox(
                  height: 30,
                  child: SingleChildScrollView(
                    child: data,
                  ),
                ),
              ),
              InkWell(
                onTap: fun,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Container(
                    width: Spacing.lg * 5,
                    height: Spacing.lg,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14.0),
                      color: Color.foregroundColor,
                    ),
                    child: Center(
                      child: Text("Get Details",
                          style: TextStyle(
                              color: Color.textColor, fontSize: Sizes.sm)),
                    ),
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
