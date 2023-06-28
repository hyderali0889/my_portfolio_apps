// ignore_for_file: file_names

import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:cook_book/Screens/AllRecipes.dart';
import 'package:cook_book/Utils/ApiCall.dart';
import 'package:flutter/material.dart';
import "../Theme/Colors.dart";
import '../Theme/Sizes.dart';
import '../components/AppBarWithBackButton.dart';
import '../components/Card.dart';

class RecipeDetails extends StatefulWidget {
  final String recipeName;
  const RecipeDetails({Key? key, required this.recipeName}) : super(key: key);

  @override
  State<RecipeDetails> createState() => _RecipeDetailsState();
}

class _RecipeDetailsState extends State<RecipeDetails> {
  dynamic recipeDetails;
  bool isError = false;
  late Timer t;

  @override
  void initState() {
    super.initState();
    getRecipeDettails();
  }

  getRecipeDettails() async {
    try {
      dynamic data = await FetchApi().fetchDataByName(widget.recipeName);
      t = Timer(const Duration(seconds: 10), () {
        setState(() {
          isError = true;
        });
      });
      if (data != null) {
        setState(() {
          recipeDetails = data["meals"];
        });
      } else if (data == false) {
        setState(() {
          isError = true;
        });
      }
    } catch (e) {
      setState(() {
        isError = true;
      });
    }
  }

  @override
  void dispose() {
    t.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.backgroundColor,
      body: Platform.isAndroid || Platform.isIOS
          ? Column(
              children: [mobileView()],
            )
          : Column(children: [
              TitleBarNew().mainAppBar(context),
              Expanded(
                child: desktopView(),
              )
            ]),
    );
  }

  desktopView() {
    return recipeDetails == null
        ? SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Center(
                child: isError
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset("assets/images/NotConnected.png"),
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Text(
                              "Slow Connection or Nothing Found",
                              style: TextStyle(color: Color.textColor),
                            ),
                          )
                        ],
                      )
                    : Image.asset("assets/gifs/loader.gif")),
          )
        : Center(
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(dragDevices: {
                PointerDeviceKind.touch,
                PointerDeviceKind.mouse
              }),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height,
                child: MainCard(
                  img: ClipRRect(
                      borderRadius: BorderRadius.circular(14.0),
                      child: FadeInImage.assetNetwork(
                        image: recipeDetails[0]["strMealThumb"],
                        placeholder: 'assets/gifs/loader.gif',
                      )),
                  data: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: Center(
                            child: Text(recipeDetails[0]["strMeal"],
                                style: TextStyle(
                                    fontSize: Sizes.lg,
                                    color: Color.headingColor)),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 15.0, right: 15.0),
                          child: Text("Ingridients Required",
                              style: TextStyle(
                                  fontSize: Sizes.lg,
                                  color: Color.headingColor)),
                        ),
                        Padding(
                            padding:
                                const EdgeInsets.only(top: 15.0, right: 15.0),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.6,
                              height: 40,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: List.generate(21, (index) {
                                  if (index == 0 ||
                                      recipeDetails[0]["strIngredient$index"] ==
                                          "" ||
                                      recipeDetails[0]["strIngredient$index"] ==
                                          null) {
                                    return const Text("");
                                  } else {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Text(
                                        recipeDetails[0]["strIngredient$index"],
                                        style: TextStyle(
                                            fontSize: Sizes.lg,
                                            color: Color.textColor),
                                      ),
                                    );
                                  }
                                }),
                              ),
                            )),
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 15.0, right: 15.0),
                          child: Text("Instructions for Cooking",
                              style: TextStyle(
                                  fontSize: Sizes.lg,
                                  color: Color.headingColor)),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 15.0, right: 15.0),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.6,
                            height: 250,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Text(recipeDetails[0]["strInstructions"],
                                  style: TextStyle(
                                      fontSize: Sizes.sm,
                                      color: Color.simpleColor)),
                            ),
                          ),
                        ),
                      ]),
                ),
              ),
            ),
          );
  }

  mobileView() {
    return recipeDetails == null
        ? SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Center(
                child: isError
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset("assets/images/NotConnected.png"),
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Text(
                              "Slow Connection or Nothing Found",
                              style: TextStyle(color: Color.textColor),
                            ),
                          )
                        ],
                      )
                    : Image.asset("assets/gifs/loader.gif")),
          )
        : SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
                child: Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).viewPadding.top + 20.0),
              child: Column(
                children: [
                  Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Color.foregroundColor,
                              borderRadius: BorderRadius.circular(14.0)),
                          height: 120,
                          width: 120,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0)),
                            child: FadeInImage(
                                image: NetworkImage(
                                  recipeDetails[0]["strMealThumb"],
                                ),
                                placeholder:
                                    const AssetImage("assets/gifs/loader.gif")),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14.0),
                          color: Color.foregroundColor),
                      height: 60,
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            Center(
                                child: Text(
                              recipeDetails[0]["strMeal"],
                              style: TextStyle(
                                  color: Color.headingColor,
                                  fontSize: Sizes.mainHeadings),
                            ))
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14.0),
                          color: Color.foregroundColor),
                      height: 100,
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 18.0),
                              child: Text("All Ingredients",
                                  style: TextStyle(
                                    color: Color.simpleColor,
                                    fontSize: Sizes.headings,
                                  )),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: 30,
                              child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: List.generate(21, ((index) {
                                    if (index == 0 ||
                                        recipeDetails[0]
                                                ["strIngredient$index"] ==
                                            "" ||
                                        recipeDetails[0]
                                                ["strIngredient$index"] ==
                                            null) {
                                      return const Text("");
                                    } else {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Text(
                                          recipeDetails[0]
                                              ["strIngredient$index"],
                                          style: TextStyle(
                                              fontSize: Sizes.lg,
                                              color: Color.textColor),
                                        ),
                                      );
                                    }
                                  }))),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14.0),
                          color: Color.foregroundColor),
                      height: 450,
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 18.0),
                                child: Text("Instructions",
                                    style: TextStyle(
                                      color: Color.simpleColor,
                                      fontSize: Sizes.headings,
                                    )),
                              ),
                              Center(
                                  child: Text(
                                recipeDetails[0]["strInstructions"],
                                style: TextStyle(
                                    color: Color.textColor, fontSize: Sizes.lg),
                              ))
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )),
          );
  }
}
