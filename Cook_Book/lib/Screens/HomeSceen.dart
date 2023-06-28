// ignore_for_file: file_names, avoid_print, unnecessary_const
import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:cook_book/Screens/AllRecipes.dart';
import 'package:cook_book/Screens/RecipeDetails.dart';
import 'package:cook_book/Theme/Sizes.dart';
import 'package:cook_book/Theme/Spacing.dart';
import 'package:cook_book/components/Card.dart';
import 'package:cook_book/components/MobileIngredientCard.dart';
import 'package:flutter/material.dart';
import '../Theme/Colors.dart';
import '../Utils/ApiCall.dart';
import '../components/ComponentCard.dart';
import '../components/IngredientsCard.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  dynamic allCategories;
  dynamic allAreas;
  dynamic allIngredients;
  dynamic aRandomRecipe;
  bool isError1 = false;
  bool isError2 = false;
  bool isError3 = false;
  bool isError4 = false;

  @override
  void initState() {
    super.initState();

    getListOfallCategories();
    getListOfallAreas();
    getListOfallIngredients();
    getaRandomRecipe();
  }

  getListOfallCategories() async {
    try {
      dynamic dat = await FetchApi().fetchListOfAllCategory();

      if (dat != null) {
        setState(() {
          allCategories = dat["meals"];
        });
      } else if (dat == false) {
        setState(() {
          isError1 = true;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  getListOfallAreas() async {
    try {
      dynamic dat = await FetchApi().fetchListOfAllAreas();

      if (dat != null) {
        setState(() {
          allAreas = dat["meals"];
        });
      } else if (dat == false) {
        setState(() {
          isError2 = true;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  getListOfallIngredients() async {
    try {
      dynamic dat = await FetchApi().fetchListOfAllIngredients();

      if (dat != null) {
        setState(() {
          allIngredients = dat["meals"];
        });
      } else if (dat == false) {
        setState(() {
          isError3 = true;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  getaRandomRecipe() async {
    try {
      dynamic dat = await FetchApi().fetchARandomRecipe();

      if (dat != null) {
        setState(() {
          aRandomRecipe = dat["meals"];
        });
      } else if (dat == false) {
        setState(() {
          isError4 = true;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.backgroundColor,
      body: ListView(shrinkWrap: true, children: [mobileView()]),
    );
  }

  Widget mobileView() {
    return Padding(
      padding: EdgeInsets.only(left: Spacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: Spacing.md),
            child: Center(
              child: Text(
                "Welcome To Cookbook",
                style: TextStyle(
                    fontSize: Sizes.mainHeadings, color: Color.headingColor),
              ),
            ),
          ),
//
// ──────────────────────────────────────────────────────── I ──────────
//   :::::: P A R T   O N E : :  :   :    :     :        :          :
// ──────────────────────────────────────────────────────────────────
//

          Padding(
            padding: EdgeInsets.only(bottom: Spacing.md),
            child: Text("Explore All Categories",
                style: TextStyle(
                    fontSize: Sizes.headings, color: Color.textColor)),
          ),
          allCategories == null
              ? Center(
                  child: isError1
                      ? Column(
                          children: [
                            Image.asset('assets/images/NotConnected.png'),
                            Padding(
                              padding: const EdgeInsets.only(top: 40),
                              child: Text(
                                "Not Connected",
                                style: TextStyle(color: Color.textColor),
                              ),
                            )
                          ],
                        )
                      : Image.asset("assets/gifs/loader.gif"),
                )
              : ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context).copyWith(
                      dragDevices: {
                        PointerDeviceKind.touch,
                        PointerDeviceKind.mouse
                      }),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 75,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: allCategories.length,
                      itemBuilder: (BuildContext context, int index) {
                        return allCategories[index]["strCategory"] == "Pork"
                            ? const Center(
                                child: Text(" "),
                              )
                            : ComponentCard(
                                text: allCategories[index]["strCategory"],
                                func: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: ((context) => AllRecipes(
                                                data: allCategories[index]
                                                    ["strCategory"],
                                                selectedCt: "Category",
                                              ))));
                                });
                      },
                    ),
                  ),
                ),

//
// ──────────────────────────────────────────────────────── II ──────────
//   :::::: P A R T   T W O : :  :   :    :     :        :          :
// ──────────────────────────────────────────────────────────────────
//

          Padding(
            padding: EdgeInsets.symmetric(vertical: Spacing.md),
            child: Text("Explore All Areas",
                style: TextStyle(
                    fontSize: Sizes.headings, color: Color.textColor)),
          ),
          allAreas == null
              ? Center(
                  child: isError2
                      ? Column(
                          children: [
                            Image.asset('assets/images/NotConnected.png'),
                            Padding(
                              padding: const EdgeInsets.only(top: 40),
                              child: Text("Not Connected",
                                  style: TextStyle(color: Color.textColor)),
                            )
                          ],
                        )
                      : Image.asset("assets/gifs/loader.gif"),
                )
              : ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context).copyWith(
                      dragDevices: {
                        PointerDeviceKind.touch,
                        PointerDeviceKind.mouse
                      }),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 75,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: allAreas.length,
                      itemBuilder: (BuildContext context, int index) {
                        return allAreas[index]["strArea"] == "Unknown"
                            ? const Center(
                                child: Text(" "),
                              )
                            : ComponentCard(
                                text: allAreas[index]["strArea"],
                                func: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: ((context) => AllRecipes(
                                                data: allAreas[index]
                                                    ["strArea"],
                                                selectedCt: "Area",
                                              ))));
                                });
                      },
                    ),
                  ),
                ),

//
// ──────────────────────────────────────────────────────────── III ──────────
//   :::::: P A R T   T H R E E : :  :   :    :     :        :          :
// ──────────────────────────────────────────────────────────────────────
//

          Padding(
            padding: EdgeInsets.symmetric(vertical: Spacing.md),
            child: Text("Explore All Ingredients",
                style: TextStyle(
                    fontSize: Sizes.headings, color: Color.textColor)),
          ),
          allIngredients == null
              ? Center(
                  child: isError3
                      ? Column(
                          children: [
                            Image.asset('assets/images/NotConnected.png'),
                            Padding(
                              padding: const EdgeInsets.only(top: 40),
                              child: Text("Not Connected",
                                  style: TextStyle(color: Color.textColor)),
                            )
                          ],
                        )
                      : Image.asset("assets/gifs/loader.gif"),
                )
              : ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context).copyWith(
                      dragDevices: {
                        PointerDeviceKind.touch,
                        PointerDeviceKind.mouse
                      }),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 300,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: allIngredients.length,
                      itemBuilder: (BuildContext context, int index) {
                        return allIngredients[index]["strIngredient"] == "Pork"
                            ? const Center(
                                child: Text(" "),
                              )
                            : IngredientsCard(
                                headingText: allIngredients[index]
                                    ["strIngredient"],
                                text: allIngredients[index]["strDescription"],
                                func: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: ((context) => AllRecipes(
                                                data: allIngredients[index]
                                                    ["strIngredient"],
                                                selectedCt: "Ingredient",
                                              ))));
                                });
                      },
                    ),
                  ),
                ),
//
// ────────────────────────────────────────────────────────── IV ──────────
//   :::::: P A R T   F O U R : :  :   :    :     :        :          :
// ────────────────────────────────────────────────────────────────────
//
//
// ────────────────────────────────────────────────────────────────── VI ──────────
//   :::::: M O B I L E   W I D G E T : :  :   :    :     :        :          :
// ────────────────────────────────────────────────────────────────────────────
//

          Padding(
            padding: EdgeInsets.symmetric(vertical: Spacing.md),
            child: Text("Our Recomendation for today",
                style: TextStyle(
                    fontSize: Sizes.headings, color: Color.textColor)),
          ),
          Platform.isAndroid || Platform.isIOS
              ? aRandomRecipe == null
                  ? Center(
                      child: isError4
                          ? Column(
                              children: [
                                Image.asset('assets/images/NotConnected.png'),
                                Padding(
                                  padding: const EdgeInsets.only(top: 40),
                                  child: Text(
                                    "Not Connected",
                                    style: TextStyle(color: Color.textColor),
                                  ),
                                )
                              ],
                            )
                          : Image.asset("assets/gifs/loader.gif"),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(right: 15.0, bottom: 15.0),
                      child: MobileCard(
                        data: Column(
                          children: [
                            Text(aRandomRecipe[0]["strMeal"],
                                style: TextStyle(
                                    fontSize: Sizes.lg,
                                    color: Color.headingColor)),
                          ],
                        ),
                        fun: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => RecipeDetails(
                                        recipeName: aRandomRecipe[0]["strMeal"],
                                      ))));
                        },
                        img: ClipRRect(
                            borderRadius: BorderRadius.circular(14.0),
                            child: FadeInImage.assetNetwork(
                              image: aRandomRecipe[0]["strMealThumb"],
                              placeholder: 'assets/gifs/loader.gif',
                            )),
                      ),
                    )

//
// ──────────────────────────────────────────────────────────────────── V ──────────
//   :::::: D E S K T O P   W I D G E T : :  :   :    :     :        :          :
// ──────────────────────────────────────────────────────────────────────────────
//

              : aRandomRecipe == null
                  ? Center(
                      child: isError4
                          ? Column(
                              children: [
                                Image.asset('assets/images/NotConnected.png'),
                                Padding(
                                  padding: const EdgeInsets.only(top: 40),
                                  child: Text(
                                    "Not Connected",
                                    style: TextStyle(color: Color.textColor),
                                  ),
                                )
                              ],
                            )
                          : Image.asset("assets/gifs/loader.gif"),
                    )
                  : ScrollConfiguration(
                      behavior: ScrollConfiguration.of(context).copyWith(
                          dragDevices: {
                            PointerDeviceKind.touch,
                            PointerDeviceKind.mouse
                          }),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: 550,
                        child: MainCard(
                          img: ClipRRect(
                              borderRadius: BorderRadius.circular(14.0),
                              child: FadeInImage.assetNetwork(
                                image: aRandomRecipe[0]["strMealThumb"],
                                placeholder: 'assets/gifs/loader.gif',
                              )),
                          data: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.6,
                                  child: Center(
                                    child: Text(aRandomRecipe[0]["strMeal"],
                                        style: TextStyle(
                                            fontSize: Sizes.lg,
                                            color: Color.headingColor)),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 15.0, right: 15.0),
                                  child: Text("Ingridients Required",
                                      style: TextStyle(
                                          fontSize: Sizes.lg,
                                          color: Color.headingColor)),
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(
                                        top: 15.0, right: 15.0),
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.6,
                                      height: 40,
                                      child: ListView(
                                        scrollDirection: Axis.horizontal,
                                        children: List.generate(21, (index) {
                                          if (index == 0 ||
                                              aRandomRecipe[0]
                                                      ["strIngredient$index"] ==
                                                  "" ||
                                              aRandomRecipe[0]
                                                      ["strIngredient$index"] ==
                                                  null) {
                                            return const Text("");
                                          } else {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0),
                                              child: Text(
                                                aRandomRecipe[0]
                                                    ["strIngredient$index"],
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
                                  padding: const EdgeInsets.only(
                                      top: 15.0, right: 15.0),
                                  child: Text("Instructions for Cooking",
                                      style: TextStyle(
                                          fontSize: Sizes.lg,
                                          color: Color.headingColor)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 15.0, right: 15.0),
                                  child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.6,
                                    height: 250,
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      child: Text(
                                          aRandomRecipe[0]["strInstructions"],
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
        ],
      ),
    );
  }

  randomRecipeIngredients() {
    for (int i = 1; i < 20; i++) {
      return Text("$i");
    }
  }
}
