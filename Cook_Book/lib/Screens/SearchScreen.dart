// ignore_for_file: file_names

import 'dart:io';

import 'package:advance_notification/advance_notification.dart';
import 'package:cook_book/Screens/RecipeDetails.dart';
import 'package:flutter/material.dart';
import 'package:hovering/hovering.dart';
import '../Theme/Colors.dart';
import '../Theme/Sizes.dart';
import '../Theme/Spacing.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController inputText = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.backgroundColor,
      body: Column(
        children: [
          Padding(
            padding: Platform.isAndroid || Platform.isIOS
                ? EdgeInsets.fromLTRB(
                    8.0, MediaQuery.of(context).viewPadding.top, 8.0, 8.0)
                : const EdgeInsets.all(8.0),
            child: TextField(
              controller: inputText,
              decoration: InputDecoration(
                hintText: "Please Enter Recipe Name",
                hintStyle: TextStyle(
                  color: Color.simpleColor.withOpacity(0.3),
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide(color: Color.foregroundColor)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide(color: Color.foregroundColor)),
              ),
              cursorColor: Color.textColor,
              style: TextStyle(
                  color: Color.textColor, fontWeight: FontWeight.w900),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(top: Spacing.sm),
              child: HoverButton(
                height: Spacing.xl,
                minWidth: MediaQuery.of(context).size.width * 0.8,
                onpressed: () {
                  if (inputText.text.isEmpty) {
                    const AdvanceSnackBar(
                            mode: Mode.ADVANCE,
                            message: "Please Type Something",
                            type: sType.ERROR)
                        .show(context);
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) =>
                                RecipeDetails(recipeName: inputText.text))));
                  }
                },
                hoverColor: Color.iconColor,
                color: Color.foregroundColor,
                child: Text(
                  "Search",
                  style: TextStyle(color: Color.textColor, fontSize: Sizes.md),
                ),
              ))
        ],
      ),
    );
  }
}
