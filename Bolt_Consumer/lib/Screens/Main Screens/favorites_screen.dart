import 'package:bolt/Components/fragments.dart';
import 'package:bolt/Controllers/main_menu_controller.dart';
import 'package:bolt/Theme/colors.dart';
import 'package:bolt/Theme/font_family.dart';
import 'package:bolt/Theme/font_sizes.dart';
import 'package:bolt/Utils/firebase_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';

import '../../Constants/firebase_const.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  TextEditingController textcontroller = TextEditingController();
  dynamic favorites;
  int id = 0;
  List queryResult = [];
  bool isSearchBar = false;
  bool isBucketLoading = false;
  List isInBucket = [];
  @override
  void initState() {
    super.initState();
    if (mounted) {
      Get.put(MainMenuController());
      getFavData();
    }
  }

  getFavData() async {
    dynamic data = await FirebaseFunctions().getFavsData();
    if (!mounted) return;
    getBucketData();
    setState(() {
      favorites = data;
    });
  }

  getBucketData() async {
    dynamic data = await FirebaseFunctions().getBucketData();
    if (!mounted) return;

    if (data != null) {
      data.docs.forEach((ele) {
        favorites.docs.forEach((fav) {
          if (ele[FirebaseConsts().products][ProductModelConsts().id] ==
              fav[FirebaseConsts().products][0]) {
            setState(() {
              isBucketLoading = false;
              isInBucket.add(fav[FirebaseConsts().products][0]);
            });
          }
        });
      });
    }
  }

  getQuery(String st) {
    favorites.docs.forEach((dat) {
      if (dat[FirebaseConsts().products][1].toLowerCase().contains(st)) {
        setState(() {
          queryResult.add(dat);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    MainMenuController controller = Get.find<MainMenuController>();
    return Scaffold(
        backgroundColor: MainColors.mainPageColor,
        body: SizedBox(
          width: size.width,
          height: size.height,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    upperRow(controller, size, favorites),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 40.0, top: 20, right: 10, bottom: 20),
                      child: Fragments().headingText("All Favorites",
                          FontSizes.mainHeading, MainColors.black),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: isSearchBar
                          ? queryResult.isEmpty
                              ? SizedBox(
                                  width: size.width,
                                  height: size.height * 0.6,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        "assets/imgs/Saly-17.png",
                                      ),
                                      Text("Item not found",
                                          style: Fragments().mainTextStyle(
                                            FontSizes.productTitle,
                                            MainColors.black,
                                            FontFamily.bold,
                                          )),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 20.0),
                                        child: Text(
                                            "Try a more generic search term or try \n looking for alternative products.",
                                            style: Fragments().mainTextStyle(
                                                FontSizes.mainText,
                                                MainColors.gray,
                                                FontFamily.regular)),
                                      ),
                                    ],
                                  ),
                                )
                              : SizedBox(
                                  width: size.width,
                                  height: size.height * 0.6,
                                  child: ListView.builder(
                                      itemCount: queryResult.length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          margin: const EdgeInsets.all(20),
                                          width: 250,
                                          height: 400,
                                          decoration: BoxDecoration(
                                              color: MainColors.white,
                                              borderRadius:
                                                  BorderRadius.circular(14.0)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Column(
                                              children: [
                                                Text(
                                                    queryResult[index][
                                                        FirebaseConsts()
                                                            .products][1],
                                                    maxLines: 2,
                                                    style: Fragments()
                                                        .mainTextStyle(
                                                      FontSizes.productTitle,
                                                      MainColors.black,
                                                      FontFamily.bold,
                                                    )),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: SizedBox(
                                                    height: 80,
                                                    child: ListView(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 8.0),
                                                          child: Text(
                                                            queryResult[index][
                                                                FirebaseConsts()
                                                                    .products][2],
                                                            style: Fragments()
                                                                .mainTextStyle(
                                                              FontSizes.subText,
                                                              MainColors.black,
                                                              FontFamily
                                                                  .regular,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8.0),
                                                  child: Text(
                                                    "${queryResult[index][FirebaseConsts().products][3].toString()} \$",
                                                    style: Fragments()
                                                        .mainTextStyle(
                                                      FontSizes.title,
                                                      MainColors.purple,
                                                      FontFamily.semiBold,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10,
                                                          bottom: 20.0),
                                                  child: Fragments().mainButton(
                                                      size,
                                                      id ==
                                                              queryResult[index]
                                                                      [FirebaseConsts().products]
                                                                  [0]
                                                          ? "Loading"
                                                          : "Remove From Favorites",
                                                      id ==
                                                              queryResult[index]
                                                                      [FirebaseConsts().products]
                                                                  [0]
                                                          ? MainColors.gray
                                                          : MainColors.purple,
                                                      FontSizes.buttonTitle,
                                                      id ==
                                                              queryResult[index]
                                                                      [
                                                                      FirebaseConsts()
                                                                          .products]
                                                                  [0]
                                                          ? MainColors.purple
                                                          : MainColors.white,
                                                      id ==
                                                              queryResult[index]
                                                                  [
                                                                  FirebaseConsts()
                                                                      .products][0]
                                                          ? () {}
                                                          : () {
                                                              setState(() {
                                                                id = queryResult[
                                                                        index][
                                                                    FirebaseConsts()
                                                                        .products][0];
                                                              });
                                                              FirebaseFunctions()
                                                                  .removefromfavs(
                                                                      queryResult,
                                                                      index);
                                                            }),
                                                ),
                                                Fragments().mainButton(
                                                    size,
                                                    isInBucket.contains(
                                                            queryResult[index]
                                                                    [FirebaseConsts().products]
                                                                [0])
                                                        ? "Already Added"
                                                        : isBucketLoading
                                                            ? "Loading..."
                                                            : "Add To Bucket",
                                                    isInBucket.contains(
                                                            queryResult[index]
                                                                    [FirebaseConsts().products]
                                                                [0])
                                                        ? MainColors.gray
                                                        : isBucketLoading
                                                            ? MainColors.gray
                                                            : MainColors.purple,
                                                    FontSizes.buttonTitle,
                                                    isBucketLoading
                                                        ? MainColors.purple
                                                        : MainColors.white,
                                                    isInBucket.contains(
                                                            queryResult[index][
                                                                FirebaseConsts()
                                                                    .products][0])
                                                        ? () {}
                                                        : () {
                                                            setState(() {
                                                              isBucketLoading =
                                                                  true;
                                                            });
                                                            FirebaseFunctions()
                                                                .addToBucket([
                                                              queryResult[index]
                                                                  [
                                                                  FirebaseConsts()
                                                                      .products][0],
                                                              queryResult[index]
                                                                  [
                                                                  FirebaseConsts()
                                                                      .products][1],
                                                              queryResult[index]
                                                                  [
                                                                  FirebaseConsts()
                                                                      .products][2],
                                                              queryResult[index]
                                                                  [
                                                                  FirebaseConsts()
                                                                      .products][3],
                                                              queryResult[index]
                                                                  [
                                                                  FirebaseConsts()
                                                                      .products][4],
                                                              queryResult[index]
                                                                  [
                                                                  FirebaseConsts()
                                                                      .products][5],
                                                              0
                                                            ]);
                                                          })
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                )
                          : SizedBox(
                              width: size.width,
                              height: size.height * 0.6,
                              child: favorites == null
                                  ? Center(
                                      child: CircularProgressIndicator(
                                        color: MainColors.purple,
                                      ),
                                    )
                                  : favorites.docs.length == 0
                                      ? SizedBox(
                                          width: size.width,
                                          height: size.height,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                "assets/imgs/Sally-4.png",
                                              ),
                                              Text("Nothing in your Favorites",
                                                  style:
                                                      Fragments().mainTextStyle(
                                                    FontSizes.productTitle,
                                                    MainColors.black,
                                                    FontFamily.bold,
                                                  )),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10.0),
                                                child: Text(
                                                    "Try adding a new Product into your Favorites",
                                                    style: Fragments()
                                                        .mainTextStyle(
                                                            FontSizes.mainText,
                                                            MainColors.gray,
                                                            FontFamily
                                                                .regular)),
                                              ),
                                            ],
                                          ),
                                        )
                                      : mainView(favorites.docs, size,
                                          "Remove From Favs")),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }

  /*
 ! Yb        dP 88 8888b.   dP""b8 888888 888888 .dP"Y8     .dP"Y8 888888  dP""b8 888888 88  dP"Yb  88b 88
 !  Yb  db  dP  88  8I  Yb dP   `" 88__     88   `Ybo."     `Ybo." 88__   dP   `"   88   88 dP   Yb 88Yb88
 !   YbdPYbdP   88  8I  dY Yb  "88 88""     88   o.`Y8b     o.`Y8b 88""   Yb        88   88 Yb   dP 88 Y88
 !    YP  YP    88 8888Y"   YboodP 888888   88   8bodP'     8bodP' 888888  YboodP   88   88  YbodP  88  Y8
  */

  /*
 ? Yb        dP 88 8888b.   dP""b8 888888 888888      dP"Yb  88b 88 888888
 ?  Yb  db  dP  88  8I  Yb dP   `" 88__     88       dP   Yb 88Yb88 88__
 ?   YbdPYbdP   88  8I  dY Yb  "88 88""     88       Yb   dP 88 Y88 88""
 ?    YP  YP    88 8888Y"   YboodP 888888   88        YbodP  88  Y8 888888
  */

  upperRow(controller, size, allData) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 30.0),
          child: IconButton(
              onPressed: () {
                controller.changeIsExpanded(!controller.isExpanded.value);
              },
              icon: Icon(
                FeatherIcons.alignLeft,
                color: MainColors.black,
              )),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 40.0),
          child: SizedBox(
            width: allData != null ? size.width * 0.7 : 40,
            child: searchField(textcontroller, allData),
          ),
        )
      ],
    );
  }

  /*
 ? Yb        dP 88 8888b.   dP""b8 888888 888888     888888 Yb        dP  dP"Yb
 ?  Yb  db  dP  88  8I  Yb dP   `" 88__     88         88    Yb  db  dP  dP   Yb
 ?   YbdPYbdP   88  8I  dY Yb  "88 88""     88         88     YbdPYbdP   Yb   dP
 ?    YP  YP    88 8888Y"   YboodP 888888   88         88      YP  YP     YbodP
  */

  searchField(TextEditingController controller, allData) {
    return allData == null
        ? CircularProgressIndicator(
            color: MainColors.purple,
          )
        : TextField(
            controller: controller,
            onChanged: (st) {
              setState(() {
                queryResult = [];
              });
              if (st.isEmpty) {
                setState(() {
                  isSearchBar = false;
                });
              } else {
                setState(() {
                  isSearchBar = true;
                });
                favorites != null && textcontroller.text.isNotEmpty
                    ? getQuery(st)
                    : null;
              }
            },
            decoration: InputDecoration(
                prefixIcon: const Icon(FeatherIcons.search),
                hintText: "Search",
                hintStyle: Fragments().mainTextStyle(
                    FontSizes.mainText, MainColors.black, FontFamily.regular),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                )),
          );
  }

/*
  !    Yb        dP 88 8888b.   dP""b8 888888 888888     888888 88  88 88""Yb 888888 888888
  !     Yb  db  dP  88  8I  Yb dP   `" 88__     88         88   88  88 88__dP 88__   88__
  !      YbdPYbdP   88  8I  dY Yb  "88 88""     88         88   888888 88"Yb  88""   88""
  !       YP  YP    88 8888Y"   YboodP 888888   88         88   88  88 88  Yb 888888 888888
*/

  mainView(data, size, text) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return InkWell(
            child: Container(
              margin: const EdgeInsets.all(20),
              width: 250,
              height: 400,
              decoration: BoxDecoration(
                  color: MainColors.white,
                  borderRadius: BorderRadius.circular(14.0)),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Text(data[index][FirebaseConsts().products][1],
                        maxLines: 2,
                        style: Fragments().mainTextStyle(
                          FontSizes.productTitle,
                          MainColors.black,
                          FontFamily.bold,
                        )),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 80,
                        child: ListView(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                data[index][FirebaseConsts().products][2],
                                style: Fragments().mainTextStyle(
                                  FontSizes.subText,
                                  MainColors.black,
                                  FontFamily.regular,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        "${data[index][FirebaseConsts().products][3].toString()} \$",
                        style: Fragments().mainTextStyle(
                          FontSizes.title,
                          MainColors.purple,
                          FontFamily.semiBold,
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 20),
                          child: Fragments().mainButton(
                              size,
                              id == data[index][FirebaseConsts().products][0]
                                  ? "Loading"
                                  : text,
                              id == data[index][FirebaseConsts().products][0]
                                  ? MainColors.gray
                                  : MainColors.purple,
                              FontSizes.buttonTitle,
                              id == data[index][FirebaseConsts().products][0]
                                  ? MainColors.purple
                                  : MainColors.white,
                              id == data[index][FirebaseConsts().products][0]
                                  ? () {}
                                  : () {
                                      setState(() {
                                        id = data[index]
                                            [FirebaseConsts().products][0];
                                      });
                                      FirebaseFunctions()
                                          .removefromfavs(data, index);
                                    }),
                        ),
                        Fragments().mainButton(
                            size,
                            isInBucket.contains(
                                    data[index][FirebaseConsts().products][0])
                                ? "Already Added"
                                : isBucketLoading
                                    ? "Loading..."
                                    : "Add To Bucket",
                            isInBucket.contains(
                                    data[index][FirebaseConsts().products][0])
                                ? MainColors.gray
                                : isBucketLoading
                                    ? MainColors.gray
                                    : MainColors.purple,
                            FontSizes.buttonTitle,
                            isBucketLoading
                                ? MainColors.purple
                                : MainColors.white,
                            isInBucket.contains(
                                    data[index][FirebaseConsts().products][0])
                                ? () {}
                                : () {
                                    setState(() {
                                      isBucketLoading = true;
                                    });
                                    FirebaseFunctions().addToBucket([
                                      data[index][FirebaseConsts().products][0],
                                      data[index][FirebaseConsts().products][1],
                                      data[index][FirebaseConsts().products][2],
                                      data[index][FirebaseConsts().products][3],
                                      data[index][FirebaseConsts().products][4],
                                      data[index][FirebaseConsts().products][5],
                                      0
                                    ]);
                                  })
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

/*
 << 888888 88b 88 8888b.       dP"Yb  888888      dP""b8 88        db    .dP"Y8 .dP"Y8
 << 88__   88Yb88  8I  Yb     dP   Yb 88__       dP   `" 88       dPYb   `Ybo." `Ybo."
 << 88""   88 Y88  8I  dY     Yb   dP 88""       Yb      88  .o  dP__Yb  o.`Y8b o.`Y8b
 << 888888 88  Y8 8888Y"       YbodP  88          YboodP 88ood8 dP""""Yb 8bodP' 8bodP'
*/
}
