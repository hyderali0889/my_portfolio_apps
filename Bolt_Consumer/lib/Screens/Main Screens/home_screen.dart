import 'package:bolt/Components/fragments.dart';
import 'package:bolt/Controllers/main_menu_controller.dart';
import 'package:bolt/Screens/Details%20Screen/category_details.dart';
import 'package:bolt/Theme/colors.dart';
import 'package:bolt/Theme/font_family.dart';
import 'package:bolt/Theme/font_sizes.dart';
import 'package:bolt/Utils/firebase_functions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import '../../Controllers/home_screen_controller.dart';
import '../Details Screen/product_details.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController textcontroller = TextEditingController();
  List<String> categories = ["Wearables", "Phones", "Laptops", "Drones"];
  dynamic allData;
  bool refresh = true;
  List queryResult = [];
  @override
  void initState() {
    super.initState();

    Get.put(MainMenuController());
    Get.put(HomeController());
    getFirestoreData();
  }

  getQuery(String st) {
    allData.docs.forEach((dat) {
      if (dat["Label"].toLowerCase().contains(st)) {
        setState(() {
          queryResult.add(dat);
        });
      }
    });
  }

  getFirestoreData() async {
    dynamic data = await FirebaseFunctions().getFirestoreData();
    if (!mounted) return;
    setState(() {
      allData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    MainMenuController controller = Get.find<MainMenuController>();
    HomeController homeController = Get.find<HomeController>();

    return Scaffold(
        backgroundColor: MainColors.mainPageColor,
        body: SizedBox(
          width: size.width,
          height: size.height,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    upperRow(controller, size, homeController , allData),
                    Obx(
                      () => homeController.isSearchBarActive.value
                          ? allData == null
                              ? SizedBox(
                                  width: size.width,
                                  height: size.height,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                        color: MainColors.purple),
                                  ),
                                )
                              : queryResult.isEmpty
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
                                            "assets/imgs/Saly-17.png",
                                          ),
                                          Text("Item not found",
                                              style: Fragments().mainTextStyle(
                                                FontSizes.productTitle,
                                                MainColors.black,
                                                FontFamily.bold,
                                              )),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 20.0),
                                            child: Text(
                                                "Try a more generic search term or try \n looking for alternative products.",
                                                style: Fragments()
                                                    .mainTextStyle(
                                                        FontSizes.mainText,
                                                        MainColors.gray,
                                                        FontFamily.regular)),
                                          ),
                                        ],
                                      ),
                                    )
                                  : SizedBox(
                                      width: size.width,
                                      height: size.height,
                                      child: ListView.builder(
                                        itemCount: queryResult.length,
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                            onTap: () {
                                              Get.to(() => ProductDetails(
                                                    data: queryResult[index],
                                                  ));
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(25.0),
                                              child: Container(
                                                  width: 150,
                                                  height: 280,
                                                  decoration: BoxDecoration(
                                                      color: MainColors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              24.0)),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            20.0),
                                                    child: Column(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  vertical:
                                                                      20.0),
                                                          child: Center(
                                                            child: Hero(
                                                              tag: queryResult[
                                                                  index]["id"],
                                                              child:
                                                                  CachedNetworkImage(
                                                                height: 100,
                                                                width: 240,
                                                                placeholder: (context,
                                                                        url) =>
                                                                    const SizedBox(
                                                                        height:
                                                                            50,
                                                                        width:
                                                                            50,
                                                                        child: Center(
                                                                            child:
                                                                                CircularProgressIndicator())),
                                                                errorWidget:
                                                                    (context,
                                                                            url,
                                                                            error) =>
                                                                        Icon(
                                                                  FeatherIcons
                                                                      .alertTriangle,
                                                                  color:
                                                                      MainColors
                                                                          .purple,
                                                                ),
                                                                imageUrl: queryResult[
                                                                        index][
                                                                    "ImageUrl"],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Text(
                                                          queryResult[index]
                                                              ["Name"],
                                                          maxLines: 2,
                                                          style: TextStyle(
                                                              color: MainColors
                                                                  .black,
                                                              fontSize: FontSizes
                                                                  .productTitle),
                                                        ),
                                                        Text(
                                                          queryResult[index]
                                                                  ["Price"]
                                                              .toString(),
                                                          style: TextStyle(
                                                              color: MainColors
                                                                  .purple,
                                                              fontSize: FontSizes
                                                                  .subTitle),
                                                        ),
                                                      ],
                                                    ),
                                                  )),
                                            ),
                                          );
                                        },
                                      ))
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 50,
                                  ),
                                  child: mainHeading(),
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(
                                      top: 50,
                                    ),
                                    child: SizedBox(
                                      height: 50,
                                      child: listTiles(homeController),
                                    )),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 50.0, right: 30),
                                  child: SizedBox(
                                    width: size.width,
                                    height: 370,
                                    child: allData != null
                                        ? productsList(
                                            allData.docs,
                                            categories[homeController
                                                    .selectedCat.value]
                                                .toLowerCase())
                                        : Center(
                                            child: CircularProgressIndicator(
                                            color: MainColors.purple,
                                          )),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10.0, right: 30),
                                  child: SizedBox(
                                    width: size.width,
                                    height: 50,
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(),
                                          InkWell(
                                              onTap: () {
                                                Get.to(() => CategoryDetails(
                                                    data: allData.docs,
                                                    cat: categories[
                                                            homeController
                                                                .selectedCat
                                                                .value]
                                                        .toLowerCase()));
                                              },
                                              child: allData != null
                                                  ? Row(
                                                      children: [
                                                        Text(
                                                          " See More",
                                                          style: Fragments()
                                                              .mainTextStyle(
                                                                  FontSizes
                                                                      .smText,
                                                                  MainColors
                                                                      .purple,
                                                                  FontFamily
                                                                      .bold),
                                                        ),
                                                        Icon(
                                                          FeatherIcons
                                                              .arrowRight,
                                                          color:
                                                              MainColors.purple,
                                                          size:
                                                              FontSizes.smText,
                                                        )
                                                      ],
                                                    )
                                                  : SizedBox(
                                                      width: 30,
                                                      height: 30,
                                                      child:
                                                          CircularProgressIndicator(
                                                              color: MainColors
                                                                  .purple)))
                                        ]),
                                  ),
                                )
                              ],
                            ),
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

  upperRow(controller, size, homeController , allData) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
            onPressed: () {
              controller.changeIsExpanded(!controller.isExpanded.value);
            },
            icon: Icon(
              FeatherIcons.alignLeft,
              color: MainColors.black,
            )),
        Padding(
          padding: const EdgeInsets.only(right: 40.0),
          child: SizedBox(
            width:allData !=null ? size.width * 0.7:40,
            child: searchField(textcontroller, homeController , allData),
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

  searchField(TextEditingController controller, HomeController homeController , allData) {
    return allData == null ?
    CircularProgressIndicator(color: MainColors.purple,) : TextField(
      onChanged: (st) {
        setState(() {
          queryResult = [];
        });
        if (st.isEmpty) {
          homeController.makeSearchBarActive(false);
        } else {
          homeController.makeSearchBarActive(true);

          allData != null && textcontroller.text.isNotEmpty
              ? getQuery(st)
              : null;
        }
      },
      controller: controller,
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
   ?     Yb        dP 88 8888b.   dP""b8 888888 888888     888888 88  88 88""Yb 888888 888888
   ?      Yb  db  dP  88  8I  Yb dP   `" 88__     88         88   88  88 88__dP 88__   88__
   ?       YbdPYbdP   88  8I  dY Yb  "88 88""     88         88   888888 88"Yb  88""   88""
   ?        YP  YP    88 8888Y"   YboodP 888888   88         88   88  88 88  Yb 888888 888888
*/

  mainHeading() {
    return Fragments().headingText("Order online \ncollect in store",
        FontSizes.mainHeading, MainColors.black);
  }

/*
   ?     Yb        dP 88 8888b.   dP""b8 888888 888888     888888  dP"Yb  88   88 88""Yb
   ?      Yb  db  dP  88  8I  Yb dP   `" 88__     88       88__   dP   Yb 88   88 88__dP
   ?       YbdPYbdP   88  8I  dY Yb  "88 88""     88       88""   Yb   dP Y8   8P 88"Yb
   ?        YP  YP    88 8888Y"   YboodP 888888   88       88      YbodP  `YbodP' 88  Yb
*/

  listTiles(HomeController homeController) {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: ((context, index) {
          return TextButton(
              onPressed: () {
                switch (index) {
                  case 0:
                    changeCat(0, homeController);
                    break;
                  case 1:
                    changeCat(1, homeController);
                    break;
                  case 2:
                    changeCat(2, homeController);

                    break;
                  case 3:
                    changeCat(3, homeController);

                    break;
                  default:
                    changeCat(0, homeController);

                    break;
                }
              },
              child: Obx(
                () => Column(
                  children: [
                    Text(categories[index],
                        style: TextStyle(
                          fontFamily: FontFamily.semiBold,
                          fontSize: FontSizes.subTitle,
                          color: index == homeController.selectedCat.value
                              ? MainColors.purple
                              : MainColors.black,
                        )),
                    Container(
                      width: 50,
                      margin: const EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: index == homeController.selectedCat.value
                                  ? BorderSide(
                                      color: MainColors.purple, width: 2)
                                  : const BorderSide(
                                      color: Colors.transparent))),
                    )
                  ],
                ),
              ));
        }));
  }

  /*
  ?  Yb        dP 88 8888b.   dP""b8 888888 888888     888888  dP"Yb  88   88 88""Yb
  ?   Yb  db  dP  88  8I  Yb dP   `" 88__     88       88__   dP   Yb 88   88 88__dP
  ?    YbdPYbdP   88  8I  dY Yb  "88 88""     88       88""   Yb   dP Y8   8P 88"Yb
  ?     YP  YP    88 8888Y"   YboodP 888888   88       88      YbodP  `YbodP' 88  Yb
    */

  productsList(data, type) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: data.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Get.to(() => ProductDetails(data: data[index]));
            },
            child: Fragments().mainProductCard(data, index, type),
          );
        });
  }

  /*
  Todo   888888 88   88 88b 88  dP""b8 888888 88  dP"Yb  88b 88 .dP"Y8     .dP"Y8 888888  dP""b8 888888 88  dP"Yb  88b 88
  Todo   88__   88   88 88Yb88 dP   `"   88   88 dP   Yb 88Yb88 `Ybo."     `Ybo." 88__   dP   `"   88   88 dP   Yb 88Yb88
  Todo   88""   Y8   8P 88 Y88 Yb        88   88 Yb   dP 88 Y88 o.`Y8b     o.`Y8b 88""   Yb        88   88 Yb   dP 88 Y88
  Todo   88     `YbodP' 88  Y8  YboodP   88   88  YbodP  88  Y8 8bodP'     8bodP' 888888  YboodP   88   88  YbodP  88  Y8
 */

/*
*  888888 88   88 88b 88  dP""b8 888888 88  dP"Yb  88b 88      dP"Yb  88b 88 888888
*  88__   88   88 88Yb88 dP   `"   88   88 dP   Yb 88Yb88     dP   Yb 88Yb88 88__
*  88""   Y8   8P 88 Y88 Yb        88   88 Yb   dP 88 Y88     Yb   dP 88 Y88 88""
*  88     `YbodP' 88  Y8  YboodP   88   88  YbodP  88  Y8      YbodP  88  Y8 888888
*/

  changeCat(int num, HomeController homeController) {
    homeController.changeSelectedCat(num);
  }

/*
  << 888888 88b 88 8888b.       dP"Yb  888888      dP""b8 88        db    .dP"Y8 .dP"Y8
  << 88__   88Yb88  8I  Yb     dP   Yb 88__       dP   `" 88       dPYb   `Ybo." `Ybo."
  << 88""   88 Y88  8I  dY     Yb   dP 88""       Yb      88  .o  dP__Yb  o.`Y8b o.`Y8b
  << 888888 88  Y8 8888Y"       YbodP  88          YboodP 88ood8 dP""""Yb 8bodP' 8bodP'
*/
}
