// ignore_for_file: file_names

import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:advance_notification/advance_notification.dart';
import 'package:cook_book/Screens/RecipeDetails.dart';
import 'package:cook_book/Theme/Sizes.dart';
import 'package:cook_book/Utils/ApiCall.dart';
import 'package:cook_book/components/AppBarWithBackButton.dart';
import 'package:flutter/material.dart';
import '../Theme/Colors.dart';

class AllRecipes extends StatefulWidget {
  final String data;
  final String selectedCt;

  const AllRecipes({Key? key, required this.data, required this.selectedCt})
      : super(key: key);

  @override
  State<AllRecipes> createState() => _AllRecipesState();
}

class _AllRecipesState extends State<AllRecipes> {
  dynamic allRecipes;
  bool isError1 = false;
  bool isError2 = false;
  bool isError3 = false;

  @override
  void initState() {
    super.initState();
    if (widget.selectedCt == "Category") {
      try {
        getAllRecipes();
      } catch (e) {
        const AdvanceSnackBar(
          message: "An Error Occured , Please Check Your Internet Connection",
          mode: Mode.ADVANCE,
          type: sType.DARK,
          duration: Duration(seconds: 5),
        ).show(context);
      }
    } else if (widget.selectedCt == "Area") {
      try {
        getAllAreas();
      } catch (e) {
        const AdvanceSnackBar(
          message: "An Error Occured , Please Check Your Internet Connection",
          mode: Mode.ADVANCE,
          type: sType.DARK,
          duration: Duration(seconds: 5),
        ).show(context);
      }
    } else {
      try {
        getAllIngredients();
      } catch (e) {
        const AdvanceSnackBar(
          message: "An Error Occured , Please Check Your Internet Connection",
          mode: Mode.ADVANCE,
          type: sType.DARK,
          duration: Duration(seconds: 5),
        ).show(context);
      }
    }
  }

  getAllRecipes() async {
    if (widget.data.isNotEmpty) {
      try {
        dynamic data = await FetchApi().fetchDataByCategory(widget.data);


        if (data != null) {
          setState(() {
            allRecipes = data['meals'];
          });
        } else if (data == false) {
          setState(() {
            isError1 = true;
          });
        }
      } catch (e) {
        print(e);
      }
    }
  }

  getAllAreas() async {
    try {
      if (widget.data.isNotEmpty) {
        dynamic data =
            await FetchApi().fetchDataForASpecificCountry(widget.data);

        if (data != null) {
          setState(() {
            allRecipes = data['meals'];
          });
        } else if (data == false) {
          setState(() {
            isError2 = true;
          });
        }
      }
    } catch (e) {
      print(e);
    }
  }

  getAllIngredients() async {
    try {
      if (widget.data.isNotEmpty) {
        dynamic data = await FetchApi().fetchDataFromAnIngredients(widget.data);

        if (data != null) {
          setState(() {
            allRecipes = data['meals'];
          });
        } else if (data == false) {
          setState(() {
            isError3 = true;
          });
        }
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
   
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.backgroundColor,
      body: Platform.isAndroid || Platform.isIOS
          ?
          //
          // ────────────────────────────────────────────────────────────────── I ──────────
          //   :::::: M O B I L E V E R S I O N : :  :   :    :     :        :          :
          // ────────────────────────────────────────────────────────────────────────────
          //

          Column(
              children: [mobileview()],
            )
          :
          //
          // ────────────────────────────────────────────────────────────────────── I ──────────
          //   :::::: D E S K T O P   V E R S I O N : :  :   :    :     :        :          :
          // ────────────────────────────────────────────────────────────────────────────────
          //

          Column(
              children: [
                TitleBarNew().mainAppBar(context),
                Expanded(child: mobileview())
              ],
            ),
    );
  }

  mobileview() {
    return allRecipes != null
        ? SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: ScrollConfiguration(
                behavior: ScrollConfiguration.of(context).copyWith(
                    dragDevices: {
                      PointerDeviceKind.touch,
                      PointerDeviceKind.mouse
                    }),
                child: Padding(
                  padding: Platform.isAndroid || Platform.isIOS
                      ? EdgeInsets.fromLTRB(
                          15.0,
                          MediaQuery.of(context).viewPadding.top + 15.0,
                          15.0,
                          15.0)
                      : const EdgeInsets.all(15.0),
                  child: CustomScrollView(
                    slivers: [
                      SliverGrid(
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200.0,
                          mainAxisSpacing: 10.0,
                          crossAxisSpacing: 20.0,
                          childAspectRatio: 1.0,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => RecipeDetails(
                                            recipeName: allRecipes[index]
                                                ["strMeal"])));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Color.foregroundColor,
                                    borderRadius: BorderRadius.circular(5.0)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        SizedBox(
                                            width: 100,
                                            height: 100,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(14.0),
                                              child: FadeInImage(
                                                  placeholder: const AssetImage(
                                                      "assets/gifs/loader.gif"),
                                                  image: NetworkImage(
                                                      allRecipes[index]
                                                          ["strMealThumb"])),
                                            )),
                                        Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Center(
                                            child: Text(
                                              allRecipes[index]["strMeal"],
                                              style: TextStyle(
                                                  color: Color.simpleColor,
                                                  fontSize: Sizes.md,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          childCount: allRecipes.length,
                        ),
                      )
                    ],
                  ),
                )))
        : SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 31,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                    child: isError1 || isError2 || isError3
                        ? Column(
                            children: [
                              Image.asset(
                                "assets/images/NotConnected.png",
                                width: 400,
                                height: 400,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Text(
                                  "Not Connected",
                                  style: TextStyle(color: Color.textColor),
                                ),
                              )
                            ],
                          )
                        : Image.asset("assets/gifs/loader.gif")),
              ],
            ));
  }
}
