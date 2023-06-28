// ignore_for_file: file_names, avoid_print

import 'package:cook_book/Theme/Spacing.dart';
import 'package:flutter/material.dart';
import '../Theme/Colors.dart';
import '../Theme/Sizes.dart';

class ComponentCard extends StatefulWidget {
  const ComponentCard({Key? key, required this.text, required this.func})
      : super(key: key);
  final String text;
  final VoidCallback func;

  @override
  State<ComponentCard> createState() => _ComponentCardState();
}

class _ComponentCardState extends State<ComponentCard> {
  @override
  Widget build(BuildContext context) {
    bool hovering = false;
    return Padding(
        padding: EdgeInsets.only(right: Spacing.md),
        child: MouseRegion(
          onEnter: (e) {
            setState(() {
              hovering = true;
            });
         
          },
          onExit: (e) {
            setState(() {
              hovering = false;
            });

          },
          child: InkWell(
            onTap: widget.func,
            child: Container(
              decoration: BoxDecoration(
                  color: hovering ? Colors.red : Color.foregroundColor,
                  borderRadius: BorderRadius.circular(12.0)),
              width: 120,
              height: 40,
              child: Center(
                  child: Text(widget.text,
                      style: TextStyle(
                          fontSize: Sizes.lg,

                          color: Color.textColor))),
            ),
          ),
        ));
  }
}
