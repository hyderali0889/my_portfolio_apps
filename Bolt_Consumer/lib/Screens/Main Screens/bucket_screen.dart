import 'package:bolt/Components/fragments.dart';
import 'package:bolt/Controllers/main_menu_controller.dart';
import 'package:bolt/Theme/colors.dart';
import 'package:bolt/Theme/font_family.dart';
import 'package:bolt/Theme/font_sizes.dart';
import 'package:bolt/Utils/firebase_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';

import '../../Constants/firebase_const.dart';
import '../Auth Screens/error_screen.dart';
import '../Others Screen/order_details.dart';

class BucketScreen extends StatefulWidget {
  const BucketScreen({super.key});

  @override
  State<BucketScreen> createState() => _BucketScreenState();
}

class _BucketScreenState extends State<BucketScreen> {
  TextEditingController textcontroller = TextEditingController();
  dynamic bucket;
  @override
  void initState() {
    super.initState();

    getBucketData();
    getUserData();
    Get.put(MainMenuController());
  }

  @override
  void dispose() {
    textcontroller.dispose();
    addressController.dispose();
    cardNumController.dispose();
    cardCVCController.dispose();
    cardCompanyController.dispose();
    cardExpController.dispose();

    super.dispose();
  }

  int id = 0;
  List queryResult = [];
  bool isSearchBar = false;
  dynamic userData;
  TextEditingController addressController = TextEditingController();
  TextEditingController cardNumController = TextEditingController();
  TextEditingController cardCVCController = TextEditingController();
  TextEditingController cardCompanyController = TextEditingController();
  TextEditingController cardExpController = TextEditingController();
  bool isAddressLoading = false;
  bool isCardLoading = false;
  bool isRemoving = false;

  getBucketData() async {
    dynamic data = await FirebaseFunctions().getBucketData();
    if (!mounted) return;
    setState(() {
      bucket = data;
    });
  }

  getUserData() async {
    dynamic data = await FirebaseFunctions().getUserData();
    if (!mounted) return;
    setState(() {
      userData = data;
    });
  }

  getQuery(String st) {
    bucket.docs.forEach((dat) {
      if (dat[FirebaseConsts().products][ProductModelConsts().name]
          .toLowerCase()
          .contains(st)) {
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
                  children: [
                    upperRow(controller, size, bucket),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 40.0, top: 20, right: 10, bottom: 20),
                      child: Fragments().headingText(
                          "My Bucket", FontSizes.mainHeading, MainColors.black),
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
                                          height: 300,
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
                                                                .products][
                                                        ProductModelConsts()
                                                            .name],
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
                                                                        .products]
                                                                [
                                                                ProductModelConsts()
                                                                    .desc],
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
                                                    "${queryResult[index][FirebaseConsts().products][ProductModelConsts().price].toString()} \$",
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
                                                          top: 10),
                                                  child: Fragments().mainButton(
                                                      size,
                                                      id == queryResult[index][FirebaseConsts().products][ProductModelConsts().id] ||
                                                              isRemoving
                                                          ? "Loading"
                                                          : "Remove From Bucket",
                                                      id ==
                                                              queryResult[index]
                                                                      [FirebaseConsts().products]
                                                                  [
                                                                  ProductModelConsts()
                                                                      .id]
                                                          ? MainColors.gray
                                                          : MainColors.purple,
                                                      FontSizes.buttonTitle,
                                                      id ==
                                                              queryResult[index]
                                                                      [FirebaseConsts().products]
                                                                  [
                                                                  ProductModelConsts()
                                                                      .id]
                                                          ? MainColors.purple
                                                          : MainColors.white,
                                                      id ==
                                                              queryResult[index]
                                                                      [FirebaseConsts().products]
                                                                  [ProductModelConsts().id]
                                                          ? () {}
                                                          : () {
                                                              setState(() {
                                                                id = queryResult[
                                                                            index]
                                                                        [
                                                                        FirebaseConsts()
                                                                            .products]
                                                                    [
                                                                    ProductModelConsts()
                                                                        .id];
                                                              });
                                                              FirebaseFunctions()
                                                                  .removefromfavs(
                                                                      queryResult,
                                                                      index);
                                                            }),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                )
                          : SizedBox(
                              width: size.width,
                              height: size.height * 0.6,
                              child: bucket == null
                                  ? Center(
                                      child: CircularProgressIndicator(
                                        color: MainColors.purple,
                                      ),
                                    )
                                  : bucket.docs.length == 0
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
                                                "assets/imgs/Saly-6.png",
                                              ),
                                              Text("Empty Bucket",
                                                  style:
                                                      Fragments().mainTextStyle(
                                                    FontSizes.productTitle,
                                                    MainColors.black,
                                                    FontFamily.bold,
                                                  )),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 15.0),
                                                child: Text(
                                                    "Try adding a new Product into your Bucket",
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
                                      : Column(
                                          children: [
                                            mainView(bucket.docs, size,
                                                "Remove From Bucket"),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20.0),
                                              child: SizedBox(
                                                  width: size.width * 0.8,
                                                  height: size.height * 0.07,
                                                  child: Fragments().mainButton(
                                                      size,
                                                      userData != null &&
                                                              !isRemoving
                                                          ? "Buy All"
                                                          : 'Loading ...',
                                                      userData != null &&
                                                              !isRemoving
                                                          ? MainColors.purple
                                                          : MainColors.gray,
                                                      FontSizes.buttonTitle,
                                                      userData != null &&
                                                              !isRemoving
                                                          ? MainColors.white
                                                          : MainColors.purple,
                                                      () {
                                                    userData == null &&
                                                            isRemoving
                                                        ? () {}
                                                        : userData[FirebaseConsts()
                                                                        .address] !=
                                                                    "" &&
                                                                userData[FirebaseConsts()
                                                                        .cardNum] !=
                                                                    ""
                                                            ? Get.to(() =>
                                                                const OrderDetails())
                                                            : userData[FirebaseConsts()
                                                                            .cardNum] !=
                                                                        "" ||
                                                                    userData[FirebaseConsts()
                                                                            .address] !=
                                                                        ""
                                                                ? userData[FirebaseConsts()
                                                                            .address] ==
                                                                        ""
                                                                    ? showAddressBottomSheet(
                                                                        size)
                                                                    : showCardBottomSheet(
                                                                        size)
                                                                : showCardandAddressBottomSheet(
                                                                    size);
                                                  })),
                                            )
                                          ],
                                        )),
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

  upperRow(controller, size, bucket) {
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
            width: bucket == null ? 30 : size.width * 0.7,
            child: searchField(textcontroller, bucket),
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

  searchField(TextEditingController controller, bucket) {
    return bucket == null
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
                bucket != null && textcontroller.text.isNotEmpty
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
    return SizedBox(
      width: size.width,
      height: size.height * 0.53,
      child: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.all(20),
              width: 250,
              height: 300,
              decoration: BoxDecoration(
                  color: MainColors.white,
                  borderRadius: BorderRadius.circular(14.0)),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Text(
                        data[index][FirebaseConsts().products]
                            [ProductModelConsts().name],
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
                                data[index][FirebaseConsts().products]
                                    [ProductModelConsts().desc],
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
                        "${data[index][FirebaseConsts().products][ProductModelConsts().price].toString()} \$",
                        style: Fragments().mainTextStyle(
                          FontSizes.title,
                          MainColors.purple,
                          FontFamily.semiBold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Fragments().mainButton(
                          size,
                          id ==
                                  data[index][FirebaseConsts().products]
                                      [ProductModelConsts().id]
                              ? "Loading"
                              : text,
                          id ==
                                  data[index][FirebaseConsts().products]
                                      [ProductModelConsts().id]
                              ? MainColors.gray
                              : MainColors.purple,
                          FontSizes.buttonTitle,
                          id ==
                                  data[index][FirebaseConsts().products]
                                      [ProductModelConsts().id]
                              ? MainColors.purple
                              : MainColors.white,
                          id ==
                                  data[index][FirebaseConsts().products]
                                      [ProductModelConsts().id]
                              ? () {}
                              : () {
                                  if (!mounted) return;
                                  setState(() {
                                    isRemoving = true;

                                    id = data[index][FirebaseConsts().products]
                                        [ProductModelConsts().id];
                                  });
                                  FirebaseFunctions()
                                      .removefromfavs(data, index);
                                }),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }

/*
 ! Yb        dP 88 8888b.   dP""b8 888888 888888     888888  dP"Yb  88   88 88""Yb
 !  Yb  db  dP  88  8I  Yb dP   `" 88__     88       88__   dP   Yb 88   88 88__dP
 !   YbdPYbdP   88  8I  dY Yb  "88 88""     88       88""   Yb   dP Y8   8P 88"Yb
 !    YP  YP    88 8888Y"   YboodP 888888   88       88      YbodP  `YbodP' 88  Yb
*/

  showAddressBottomSheet(size) {
    showModalBottomSheet(
        backgroundColor: MainColors.white,
        enableDrag: true,
        context: context,
        builder: (context) {
          return Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(40)),
            child: userData != null
                ? ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: SizedBox(
                          height: 200,
                          width: size.width * 0.8,
                          child: TextField(
                            maxLines: 7,
                            maxLength: 62,
                            controller: addressController,
                            style: Fragments().mainTextStyle(
                              FontSizes.smText,
                              MainColors.black,
                              FontFamily.semiBold,
                            ),
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14.0),
                                  borderSide: BorderSide(
                                      color: MainColors.gray, width: 1.0)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14.0),
                                  borderSide: BorderSide(
                                      color: MainColors.gray, width: 1.0)),
                              hintText: 'Enter Shipping Address',
                              hintStyle: Fragments().mainTextStyle(
                                  FontSizes.mainText,
                                  MainColors.gray,
                                  FontFamily.semiBold),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: Fragments().mainButton(
                            size,
                            isAddressLoading ? "Loading" : "Change Address",
                            isAddressLoading
                                ? MainColors.gray
                                : MainColors.purple,
                            FontSizes.buttonTitle,
                            MainColors.white,
                            isAddressLoading
                                ? () {}
                                : () {
                                    if (addressController.text.isNotEmpty) {
                                      setState(() {
                                        isAddressLoading = true;
                                      });
                                      FirebaseFunctions().updateUserAddress(
                                          addressController.text.trim());
                                    } else {
                                      setState(() {
                                        isAddressLoading = false;
                                      });
                                      Get.to(const ErrorScreen(
                                          message: "Address is Mandatory"));
                                    }
                                  }),
                      )
                    ],
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
          );
        });
  }

/*
! Yb        dP 88 8888b.   dP""b8 888888 888888     888888 88 Yb    dP 888888
!  Yb  db  dP  88  8I  Yb dP   `" 88__     88       88__   88  Yb  dP  88__
!   YbdPYbdP   88  8I  dY Yb  "88 88""     88       88""   88   YbdP   88""
!    YP  YP    88 8888Y"   YboodP 888888   88       88     88    YP    888888
*/

  showCardBottomSheet(size) {
    showModalBottomSheet(
        backgroundColor: MainColors.white,
        enableDrag: true,
        context: context,
        builder: (context) {
          return Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(40)),
            child: userData != null
                ? ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 30.0, left: 30, top: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: Text(
                                  "Card Number",
                                  style: TextStyle(
                                    fontSize: FontSizes.mainText,
                                    color: MainColors.black,
                                    fontFamily: FontFamily.bold,
                                  ),
                                )),
                            SizedBox(
                              height: 80,
                              width: size.width * 0.8,
                              child: TextField(
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                maxLength: 14,
                                controller: cardNumController,
                                style: Fragments().mainTextStyle(
                                  FontSizes.smText,
                                  MainColors.black,
                                  FontFamily.semiBold,
                                ),
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(14.0),
                                      borderSide: BorderSide(
                                          color: MainColors.gray, width: 1.0)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(14.0),
                                      borderSide: BorderSide(
                                          color: MainColors.gray, width: 1.0)),
                                  hintText: 'Enter Card Number',
                                  hintStyle: Fragments().mainTextStyle(
                                      FontSizes.mainText,
                                      MainColors.gray,
                                      FontFamily.semiBold),
                                ),
                              ),
                            ),
                            Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: Text(
                                  "Card Campany",
                                  style: TextStyle(
                                    fontSize: FontSizes.mainText,
                                    color: MainColors.black,
                                    fontFamily: FontFamily.bold,
                                  ),
                                )),
                            SizedBox(
                              height: 80,
                              width: size.width * 0.8,
                              child: TextField(
                                maxLength: 8,
                                controller: cardCompanyController,
                                style: Fragments().mainTextStyle(
                                  FontSizes.smText,
                                  MainColors.black,
                                  FontFamily.semiBold,
                                ),
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(14.0),
                                      borderSide: BorderSide(
                                          color: MainColors.gray, width: 1.0)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(14.0),
                                      borderSide: BorderSide(
                                          color: MainColors.gray, width: 1.0)),
                                  hintText: 'Enter Card Company',
                                  hintStyle: Fragments().mainTextStyle(
                                      FontSizes.mainText,
                                      MainColors.gray,
                                      FontFamily.semiBold),
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 15),
                                      child: Text("Card Expiry",
                                          style: TextStyle(
                                            fontSize: FontSizes.mainText,
                                            color: MainColors.black,
                                            fontFamily: FontFamily.bold,
                                          )),
                                    ),
                                    SizedBox(
                                      height: 80,
                                      width: size.width * 0.4,
                                      child: TextField(
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter
                                              .digitsOnly,
                                        ],
                                        maxLength: 4,
                                        controller: cardExpController,
                                        style: Fragments().mainTextStyle(
                                          FontSizes.smText,
                                          MainColors.black,
                                          FontFamily.semiBold,
                                        ),
                                        decoration: InputDecoration(
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(14.0),
                                              borderSide: BorderSide(
                                                  color: MainColors.gray,
                                                  width: 1.0)),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(14.0),
                                              borderSide: BorderSide(
                                                  color: MainColors.gray,
                                                  width: 1.0)),
                                          hintText: 'Enter Card Exp',
                                          hintStyle: Fragments().mainTextStyle(
                                              FontSizes.mainText,
                                              MainColors.gray,
                                              FontFamily.semiBold),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 15),
                                      child: Text(
                                        "Card CVC",
                                        style: TextStyle(
                                            fontSize: FontSizes.mainText,
                                            color: MainColors.black,
                                            fontFamily: FontFamily.bold),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15.0),
                                      child: SizedBox(
                                        height: 80,
                                        width: size.width * 0.35,
                                        child: TextField(
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                          ],
                                          maxLength: 3,
                                          controller: cardCVCController,
                                          style: Fragments().mainTextStyle(
                                            FontSizes.smText,
                                            MainColors.black,
                                            FontFamily.semiBold,
                                          ),
                                          decoration: InputDecoration(
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(14.0),
                                                borderSide: BorderSide(
                                                    color: MainColors.gray,
                                                    width: 1.0)),
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(14.0),
                                                borderSide: BorderSide(
                                                    color: MainColors.gray,
                                                    width: 1.0)),
                                            hintText: 'Enter Card CVC',
                                            hintStyle: Fragments()
                                                .mainTextStyle(
                                                    FontSizes.mainText,
                                                    MainColors.gray,
                                                    FontFamily.semiBold),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Fragments().mainButton(
                                  size,
                                  isCardLoading
                                      ? "Loading"
                                      : "Change Card Info",
                                  isCardLoading
                                      ? MainColors.gray
                                      : MainColors.purple,
                                  FontSizes.buttonTitle,
                                  MainColors.white,
                                  isCardLoading
                                      ? () {}
                                      : () {
                                          if (cardCVCController.text.isNotEmpty &&
                                              cardNumController
                                                  .text.isNotEmpty &&
                                              cardExpController
                                                  .text.isNotEmpty &&
                                              cardCompanyController
                                                  .text.isNotEmpty) {
                                            setState(() {
                                              isCardLoading = true;
                                            });
                                            FirebaseFunctions()
                                                .updateUserCardInfo(
                                                    cardNumController.text
                                                        .trim(),
                                                    cardCVCController.text
                                                        .trim(),
                                                    cardExpController.text
                                                        .trim(),
                                                    cardCompanyController.text
                                                        .trim());
                                          } else {
                                            setState(() {
                                              isCardLoading = false;
                                            });
                                            Get.to(const ErrorScreen(
                                                message:
                                                    "All Fields are Mandatory"));
                                          }
                                        }),
                            )
                          ],
                        ),
                      )
                    ],
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
          );
        });
  }

/*
!  Yb        dP 88 8888b.   dP""b8 888888 888888     .dP"Y8 88 Yb  dP
! Yb  db  dP  88  8I  Yb dP   `" 88__     88       `Ybo." 88  YbdP
!  YbdPYbdP   88  8I  dY Yb  "88 88""     88       o.`Y8b 88  dPYb
!   YP  YP    88 8888Y"   YboodP 888888   88       8bodP' 88 dP  Yb
*/
  showCardandAddressBottomSheet(size) {
    showModalBottomSheet(
        backgroundColor: MainColors.white,
        enableDrag: true,
        context: context,
        builder: (context) {
          return Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(40)),
            child: userData != null
                ? ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20, top: 20),
                        child: SizedBox(
                          height: 240,
                          width: size.width * 0.8,
                          child: Column(
                            children: [
                              Padding(
                                  padding: const EdgeInsets.only(bottom: 15),
                                  child: Text(
                                    "Enter Address",
                                    style: TextStyle(
                                      fontSize: FontSizes.mainText,
                                      color: MainColors.black,
                                      fontFamily: FontFamily.bold,
                                    ),
                                  )),
                              TextField(
                                maxLines: 7,
                                maxLength: 62,
                                controller: addressController,
                                style: Fragments().mainTextStyle(
                                  FontSizes.smText,
                                  MainColors.black,
                                  FontFamily.semiBold,
                                ),
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(14.0),
                                      borderSide: BorderSide(
                                          color: MainColors.gray, width: 1.0)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(14.0),
                                      borderSide: BorderSide(
                                          color: MainColors.gray, width: 1.0)),
                                  hintText: 'Enter Shipping Address',
                                  hintStyle: Fragments().mainTextStyle(
                                      FontSizes.mainText,
                                      MainColors.gray,
                                      FontFamily.semiBold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 30.0, left: 30, top: 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: Text(
                                  "Card Number",
                                  style: TextStyle(
                                    fontSize: FontSizes.mainText,
                                    color: MainColors.black,
                                    fontFamily: FontFamily.bold,
                                  ),
                                )),
                            SizedBox(
                              height: 80,
                              width: size.width * 0.8,
                              child: TextField(
                                maxLength: 14,
                                controller: cardNumController,
                                style: Fragments().mainTextStyle(
                                  FontSizes.smText,
                                  MainColors.black,
                                  FontFamily.semiBold,
                                ),
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(14.0),
                                      borderSide: BorderSide(
                                          color: MainColors.gray, width: 1.0)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(14.0),
                                      borderSide: BorderSide(
                                          color: MainColors.gray, width: 1.0)),
                                  hintText: 'Enter Card Number',
                                  hintStyle: Fragments().mainTextStyle(
                                      FontSizes.mainText,
                                      MainColors.gray,
                                      FontFamily.semiBold),
                                ),
                              ),
                            ),
                            Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: Text(
                                  "Card Campany",
                                  style: TextStyle(
                                    fontSize: FontSizes.mainText,
                                    color: MainColors.black,
                                    fontFamily: FontFamily.bold,
                                  ),
                                )),
                            SizedBox(
                              height: 80,
                              width: size.width * 0.8,
                              child: TextField(
                                maxLength: 8,
                                controller: cardCompanyController,
                                style: Fragments().mainTextStyle(
                                  FontSizes.smText,
                                  MainColors.black,
                                  FontFamily.semiBold,
                                ),
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(14.0),
                                      borderSide: BorderSide(
                                          color: MainColors.gray, width: 1.0)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(14.0),
                                      borderSide: BorderSide(
                                          color: MainColors.gray, width: 1.0)),
                                  hintText: 'Enter Card Company',
                                  hintStyle: Fragments().mainTextStyle(
                                      FontSizes.mainText,
                                      MainColors.gray,
                                      FontFamily.semiBold),
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 15),
                                      child: Text("Card Expiry",
                                          style: TextStyle(
                                            fontSize: FontSizes.mainText,
                                            color: MainColors.black,
                                            fontFamily: FontFamily.bold,
                                          )),
                                    ),
                                    SizedBox(
                                      height: 80,
                                      width: size.width * 0.4,
                                      child: TextField(
                                        maxLength: 4,
                                        controller: cardExpController,
                                        style: Fragments().mainTextStyle(
                                          FontSizes.smText,
                                          MainColors.black,
                                          FontFamily.semiBold,
                                        ),
                                        decoration: InputDecoration(
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(14.0),
                                              borderSide: BorderSide(
                                                  color: MainColors.gray,
                                                  width: 1.0)),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(14.0),
                                              borderSide: BorderSide(
                                                  color: MainColors.gray,
                                                  width: 1.0)),
                                          hintText: 'Enter Card Exp',
                                          hintStyle: Fragments().mainTextStyle(
                                              FontSizes.mainText,
                                              MainColors.gray,
                                              FontFamily.semiBold),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 15),
                                      child: Text(
                                        "Card CVC",
                                        style: TextStyle(
                                            fontSize: FontSizes.mainText,
                                            color: MainColors.black,
                                            fontFamily: FontFamily.bold),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15.0),
                                      child: SizedBox(
                                        height: 80,
                                        width: size.width * 0.35,
                                        child: TextField(
                                          maxLength: 3,
                                          controller: cardCVCController,
                                          style: Fragments().mainTextStyle(
                                            FontSizes.smText,
                                            MainColors.black,
                                            FontFamily.semiBold,
                                          ),
                                          decoration: InputDecoration(
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(14.0),
                                                borderSide: BorderSide(
                                                    color: MainColors.gray,
                                                    width: 1.0)),
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(14.0),
                                                borderSide: BorderSide(
                                                    color: MainColors.gray,
                                                    width: 1.0)),
                                            hintText: 'Enter Card CVC',
                                            hintStyle: Fragments()
                                                .mainTextStyle(
                                                    FontSizes.mainText,
                                                    MainColors.gray,
                                                    FontFamily.semiBold),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Fragments().mainButton(
                                  size,
                                  isCardLoading ? "Loading" : "Change Profile",
                                  isCardLoading || isAddressLoading
                                      ? MainColors.gray
                                      : MainColors.purple,
                                  FontSizes.buttonTitle,
                                  MainColors.white,
                                  isCardLoading || isAddressLoading
                                      ? () {}
                                      : () {
                                          if (cardCVCController.text.isNotEmpty &&
                                              cardNumController
                                                  .text.isNotEmpty &&
                                              cardExpController
                                                  .text.isNotEmpty &&
                                              cardCompanyController
                                                  .text.isNotEmpty &&
                                              addressController
                                                  .text.isNotEmpty) {
                                            setState(() {
                                              isCardLoading = true;
                                            });
                                            setState(() {
                                              isAddressLoading = true;
                                            });
                                            FirebaseFunctions()
                                                .updateUserAddress(
                                                    addressController.text
                                                        .trim());
                                            FirebaseFunctions()
                                                .updateUserCardInfo(
                                                    cardNumController.text
                                                        .trim(),
                                                    cardCVCController.text
                                                        .trim(),
                                                    cardExpController.text
                                                        .trim(),
                                                    cardCompanyController.text
                                                        .trim());
                                          } else {
                                            setState(() {
                                              isCardLoading = false;
                                            });
                                            setState(() {
                                              isAddressLoading = false;
                                            });
                                            Get.to(const ErrorScreen(
                                                message:
                                                    "All Fields are Mandatory"));
                                          }
                                        }),
                            )
                          ],
                        ),
                      )
                    ],
                  )
                : const Center(
                    child: CircularProgressIndicator(),
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
