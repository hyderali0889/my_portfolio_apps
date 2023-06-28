import 'package:bolt/Constants/firebase_const.dart';
import 'package:bolt/Theme/colors.dart';
import 'package:bolt/Theme/font_family.dart';
import 'package:bolt/Theme/font_sizes.dart';
import 'package:bolt/Utils/firebase_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';

class AllOrdersScreen extends StatefulWidget {
  const AllOrdersScreen({super.key});

  @override
  State<AllOrdersScreen> createState() => _AllOrdersScreenState();
}

class _AllOrdersScreenState extends State<AllOrdersScreen> {
  dynamic productsData;
  @override
  void initState() {
    super.initState();
    getProductsData();
  }

  getProductsData() async {
    dynamic data = await FirebaseFunctions().getProductsData();

    setState(() {
      productsData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: MainColors.mainPageColor,
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: SafeArea(
            child: productsData == null
                ? Center(
                    child: CircularProgressIndicator(
                      color: MainColors.purple,
                    ),
                  )
                : productsData.docs.length == 0
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              upperRow(size),
                              Text(
                                "Order Details Screen",
                                style: TextStyle(
                                    color: MainColors.black,
                                    fontFamily: FontFamily.bold,
                                    fontSize: FontSizes.mainText),
                              ),
                              Container()
                            ],
                          ),
                          Column(
                            children: [
                              Image.asset(
                                'assets/imgs/Saly-11.png',
                                height: 350,
                                width: 350,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(30.0),
                                child: Text(
                                  "No Orders Yet, Book an Order from us to see it here.",
                                  style: TextStyle(
                                      color: MainColors.black,
                                      fontFamily: FontFamily.semiBold,
                                      fontSize: FontSizes.mainText),
                                ),
                              ),
                            ],
                          ),
                          Container()
                        ],
                      )
                    : Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              upperRow(size),
                              Text(
                                "Order Details Screen",
                                style: TextStyle(
                                    color: MainColors.black,
                                    fontFamily: FontFamily.bold,
                                    fontSize: FontSizes.mainText),
                              ),
                              Container()
                            ],
                          ),
                          SizedBox(
                            width: size.width,
                            height: size.height * 0.9,
                            child: ListView.builder(
                                itemCount: productsData.docs.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: MainColors.white),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(
                                                  width: size.width * 0.6,
                                                  child: Text(
                                                    productsData.docs[index]
                                                            ["Items"][0][
                                                        ProductModelConsts()
                                                            .name],
                                                    maxLines: 2,
                                                    style: TextStyle(
                                                        color: MainColors.black,
                                                        fontFamily:
                                                            FontFamily.bold,
                                                        fontSize:
                                                            FontSizes.subText),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: size.width * 0.1,
                                                  child: Text(
                                                    productsData.docs[index]
                                                            ["Items"][0][
                                                            ProductModelConsts()
                                                                .price]
                                                        .toString(),
                                                    style: TextStyle(
                                                        color:
                                                            MainColors.purple,
                                                        fontFamily:
                                                            FontFamily.bold,
                                                        fontSize:
                                                            FontSizes.subText),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              width: size.width * 0.9,
                                              height: 40,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Quantity',
                                                    maxLines: 2,
                                                    style: TextStyle(
                                                        color: MainColors.black,
                                                        fontFamily:
                                                            FontFamily.bold,
                                                        fontSize:
                                                            FontSizes.subText),
                                                  ),
                                                  Text(
                                                    productsData.docs[index]
                                                            ["Items"][0][
                                                            ProductModelConsts()
                                                                .quantity]
                                                        .toString(),
                                                    maxLines: 2,
                                                    style: TextStyle(
                                                        color: MainColors.black,
                                                        fontFamily:
                                                            FontFamily.bold,
                                                        fontSize:
                                                            FontSizes.subText),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          )
                        ],
                      )),
      ),
    );
  }

  /*
 ? Yb        dP 88 8888b.   dP""b8 888888 888888 .dP"Y8     .dP"Y8 888888  dP""b8 888888 88  dP"Yb  88b 88
 ?  Yb  db  dP  88  8I  Yb dP   `" 88__     88   `Ybo."     `Ybo." 88__   dP   `"   88   88 dP   Yb 88Yb88
 ?   YbdPYbdP   88  8I  dY Yb  "88 88""     88   o.`Y8b     o.`Y8b 88""   Yb        88   88 Yb   dP 88 Y88
 ?    YP  YP    88 8888Y"   YboodP 888888   88   8bodP'     8bodP' 888888  YboodP   88   88  YbodP  88  Y8
  */
  /*
 ! Yb        dP 88 8888b.   dP""b8 888888 888888      dP"Yb  88b 88 888888
 !  Yb  db  dP  88  8I  Yb dP   `" 88__     88       dP   Yb 88Yb88 88__
 !   YbdPYbdP   88  8I  dY Yb  "88 88""     88       Yb   dP 88 Y88 88""
 !    YP  YP    88 8888Y"   YboodP 888888   88        YbodP  88  Y8 888888
  */

  upperRow(size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                FeatherIcons.arrowLeft,
                color: MainColors.black,
              )),
        ),
        Container()
      ],
    );
  }
}
