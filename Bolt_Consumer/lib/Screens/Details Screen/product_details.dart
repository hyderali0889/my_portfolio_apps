import 'package:bolt/Components/fragments.dart';
import 'package:bolt/Theme/font_family.dart';
import 'package:bolt/Theme/font_sizes.dart';
import 'package:bolt/Utils/firebase_functions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';

import '../../Constants/firebase_const.dart';
import '../../Theme/colors.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key, this.data});

  final dynamic data;

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int activeChip = 0;
  bool openDescription = false;
  List colors = ["red", "green", "blue"];
  dynamic userData;
  List<MaterialColor> clr = [Colors.red, Colors.green, Colors.blue];
  dynamic favorites;
  dynamic bucket;
  bool isFav = false;
  bool isInBucket = false;
  bool isLoading = false;
  bool isFavLoading = false;

  @override
  void initState() {
    super.initState();
    getFavData();
    getBucketData();
  }

  getFavData() async {
    dynamic data = await FirebaseFunctions().getFavsData();
    setState(() {
      favorites = data;
    });
    if (data != null) {
      data.docs.forEach((ele) {
        if (ele[FirebaseConsts().products][0] == widget.data["id"]) {
          setState(() {
            isFavLoading = false;
            isFav = true;
          });
        }
      });
    }
  }

  getBucketData() async {
    dynamic data = await FirebaseFunctions().getBucketData();
    setState(() {
      bucket = data;
    });
    if (data != null) {
      data.docs.forEach((ele) {
        if (ele[FirebaseConsts().products][ProductModelConsts().id] ==
            widget.data["id"]) {
          setState(() {
            isLoading = false;
            isInBucket = true;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: MainColors.mainPageColor,
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Column(
          children: [
            upperRow(),
            mainImg(),
            Expanded(
              child: productDetails(size),
            ),
          ],
        ),
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
  !  b        dP 88 8888b.   dP""b8 888888 888888      dP"Yb  88b 88 888888
  !  Yb  db  dP  88  8I  Yb dP   `" 88__     88       dP   Yb 88Yb88 88__
  !   YbdPYbdP   88  8I  dY Yb  "88 88""     88       Yb   dP 88 Y88 88""
  !    YP  YP    88 8888Y"   YboodP 888888   88        YbodP  88  Y8 888888
*/

  mainImg() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Hero(
        tag: widget.data["id"],
        child: CachedNetworkImage(
          height: 250,
          width: 250,
          placeholder: (context, url) => const SizedBox(
              height: 50,
              width: 50,
              child: Center(child: CircularProgressIndicator())),
          errorWidget: (context, url, error) => Icon(
            FeatherIcons.alertTriangle,
            color: MainColors.purple,
          ),
          imageUrl: widget.data["ImageUrl"],
        ),
      ),
    );
  }

/*
   !     Yb        dP 88 8888b.   dP""b8 888888 888888 888888     888888 Yb        dP  dP"Yb
   !      Yb  db  dP  88  8I  Yb dP   `" 88__     88     88         88    Yb  db  dP  dP   Yb
   !       YbdPYbdP   88  8I  dY Yb  "88 88""     88     88         88     YbdPYbdP   Yb   dP
   !        YP  YP    88 8888Y"   YboodP 888888   88     88         88      YP  YP     YbodP
*/

  upperRow() {
    return Padding(
      padding: const EdgeInsets.only(top: 40, right: 20, left: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                FeatherIcons.arrowLeft,
                color: MainColors.black,
              )),
          isFavLoading
              ? SizedBox(
                  width: 30,
                  height: 30,
                  child: Center(
                    child: CircularProgressIndicator(color: MainColors.purple),
                  ),
                )
              : IconButton(
                  onPressed: isFav
                      ? () {}
                      : () {
                          FirebaseFunctions().addToFavorites([
                            widget.data["id"],
                            widget.data["Name"],
                            widget.data["Description"],
                            widget.data["Price"],
                            widget.data["Label"],
                            colors[activeChip],
                          ]);
                        },
                  icon: isFav
                      ? Icon(
                          FeatherIcons.thumbsUp,
                          color: MainColors.purple,
                        )
                      : Icon(
                          FeatherIcons.heart,
                          color: MainColors.gray,
                        ))
        ],
      ),
    );
  }

/*
  !      Yb        dP 88 8888b.   dP""b8 888888 888888     888888 88  88 88""Yb 888888 888888
  !       Yb  db  dP  88  8I  Yb dP   `" 88__     88         88   88  88 88__dP 88__   88__
  !        YbdPYbdP   88  8I  dY Yb  "88 88""     88         88   888888 88"Yb  88""   88""
  !         YP  YP    88 8888Y"   YboodP 888888   88         88   88  88 88  Yb 888888 888888
*/

  productDetails(size) {
    return Container(
        margin: const EdgeInsets.only(top: 20),
        decoration: BoxDecoration(
            color: MainColors.white,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24.0),
                topRight: Radius.circular(24.0))),
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0),
          child: ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Fragments().headingText(
                      widget.data["Name"], FontSizes.title, MainColors.black),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Fragments().headingText(
                        "Colors", FontSizes.subTitle, MainColors.black),
                  ),
                  colorChips(size),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Fragments().headingText(
                        "Description", FontSizes.subTitle, MainColors.black),
                  ),
                  descriptionBar(size),
                  totalCost(size)
                ],
              ),
            ],
          ),
        ));
  }

/*
!     Yb        dP 88 8888b.   dP""b8 888888 888888     888888  dP"Yb  88   88 88""Yb
!      Yb  db  dP  88  8I  Yb dP   `" 88__     88       88__   dP   Yb 88   88 88__dP
!       YbdPYbdP   88  8I  dY Yb  "88 88""     88       88""   Yb   dP Y8   8P 88"Yb
!        YP  YP    88 8888Y"   YboodP 888888   88       88      YbodP  `YbodP' 88  Yb
*/

  colorChips(size) {
    return SizedBox(
        height: 55,
        width: size.width,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: colors.length,
            itemBuilder: (context, index) {
              return Padding(
                padding:
                    const EdgeInsets.only(right: 10.0, left: 10.0, top: 10.0),
                child: Container(
                  height: 10,
                  width: 110,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(
                          width: activeChip == index ? 3 : 1,
                          color: activeChip == index
                              ? MainColors.purple
                              : MainColors.black)),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        activeChip = index;
                      });
                    },
                    child: Chip(
                      padding: EdgeInsets.zero,
                      backgroundColor: MainColors.white,
                      shadowColor: MainColors.black,
                      label: Row(
                        children: [
                          Container(
                            width: 18,
                            height: 18,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: clr[index],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              colors[index].toUpperCase(),
                              style: Fragments().mainTextStyle(FontSizes.smText,
                                  MainColors.black, FontFamily.semiBold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }));
  }

/*
! Yb        dP 88 8888b.   dP""b8 888888 888888     888888 88 Yb    dP 888888
!  Yb  db  dP  88  8I  Yb dP   `" 88__     88       88__   88  Yb  dP  88__
!   YbdPYbdP   88  8I  dY Yb  "88 88""     88       88""   88   YbdP   88""
!    YP  YP    88 8888Y"   YboodP 888888   88       88     88    YP    888888
*/

  descriptionBar(size) {
    return SizedBox(
      height: 150,
      width: size.width,
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0, right: 30.0, left: 30.0),
        child: ListView(
          children: [
            Text(
              widget.data["Description"],
              maxLines: openDescription ? 15 : 3,
            ),
            openDescription
                ? Container()
                : Padding(
                    padding: const EdgeInsets.only(top: 10.0, right: 30),
                    child: SizedBox(
                        width: size.width,
                        height: 50,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              openDescription = true;
                            });
                          },
                          child: Row(
                            children: [
                              Text(
                                "Full Description",
                                style: Fragments().mainTextStyle(
                                    FontSizes.smText,
                                    MainColors.purple,
                                    FontFamily.bold),
                              ),
                              Icon(
                                FeatherIcons.arrowRight,
                                color: MainColors.purple,
                                size: FontSizes.smText,
                              )
                            ],
                          ),
                        )),
                  )
          ],
        ),
      ),
    );
  }

  totalCost(size) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 30.0, right: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total",
                  style: Fragments().mainTextStyle(
                      FontSizes.title, MainColors.black, FontFamily.semiBold),
                ),
                Text(
                  "\$ ${widget.data["Price"]}",
                  style: Fragments().mainTextStyle(
                      FontSizes.title, MainColors.purple, FontFamily.semiBold),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: isLoading
                ? SizedBox(
                    width: size.width,
                    height: 50,
                    child: Center(
                        child: CircularProgressIndicator(
                            color: MainColors.purple)),
                  )
                : Fragments().mainButton(
                    size,
                    isInBucket ? "Already Added" : "Add to Bucket",
                    isInBucket ? MainColors.gray : MainColors.purple,
                    FontSizes.buttonTitle,
                    MainColors.white,
                    isInBucket
                        ? () {}
                        : () {
                            setState(() {
                              isLoading = true;
                            });
                            FirebaseFunctions().addToBucket([
                              widget.data["id"],
                              widget.data["Name"],
                              widget.data["Description"],
                              widget.data["Price"],
                              widget.data["Label"],
                              colors[activeChip],
                              1
                            ]);
                          }),
          )
        ],
      ),
    );
  }

/*
 << 888888 88b 88 8888b.       dP"Yb  888888      dP""b8 88        db    .dP"Y8 .dP"Y8
 << 88__   88Yb88  8I  Yb     dP   Yb 88__       dP   `" 88       dPYb   `Ybo." `Ybo."
 << 88""   88 Y88  8I  dY     Yb   dP 88""       Yb      88  .o  dP__Yb  o.`Y8b o.`Y8b
 << 888888 88  Y8 8888Y"       YbodP  88          YboodP 88ood8 dP""""Yb 8bodP' 8bodP'
*/
}
