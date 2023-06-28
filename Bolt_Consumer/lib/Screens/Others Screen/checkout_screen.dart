import 'package:bolt/Components/fragments.dart';
import 'package:bolt/Constants/firebase_const.dart';
import 'package:bolt/Controllers/notification_controller.dart';
import 'package:bolt/Theme/colors.dart';
import 'package:bolt/Theme/font_family.dart';
import 'package:bolt/Theme/font_sizes.dart';
import 'package:bolt/Utils/firebase_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';

import '../../Controllers/order_details_controller.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({super.key});

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

dynamic userData;

class _CheckOutScreenState extends State<CheckOutScreen> {
  @override
  void initState() {
    super.initState();
    Get.put(OrderDetailsController());
    getUserData();
  }

  getUserData() async {
    dynamic data = await FirebaseFunctions().getUserData();

    setState(() {
      userData = data;
    });
  }

  bool isAddressOpen = false;
  bool iscardOpen = false;
  bool isBuyLoading = false;

  @override
  Widget build(BuildContext context) {
    OrderDetailsController controller = Get.find<OrderDetailsController>();
    NotificationController notController = Get.find<NotificationController>();

    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: MainColors.mainPageColor,
        body: SizedBox(
          width: size.width,
          height: size.height,
          child: ListView(
            children: [
              upperRow(size),
              Padding(
                padding: const EdgeInsets.only(left: 40),
                child: Fragments().headingText(
                    "Order Details", FontSizes.mainHeading, MainColors.black),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: SizedBox(
                  width: size.width,
                  height: size.height * 0.43,
                  child: Column(
                    children: [
                      SizedBox(
                        width: size.width,
                        height: size.height * 0.4,
                        child: ListView.builder(
                          itemCount: controller.products.length,
                          itemBuilder: (context, index) {
                            return productCard(
                                size, controller.products, index);
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total Cost",
                              style: TextStyle(
                                  color: MainColors.black,
                                  fontFamily: FontFamily.bold),
                            ),
                            Text(
                              "${controller.sum} \$",
                              style: TextStyle(
                                  color: MainColors.black,
                                  fontFamily: FontFamily.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 200,
                height: isAddressOpen ? 200 : 130,
                child: addressDropDown(),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 200,
                height: iscardOpen ? 300 : 130,
                child: cardDropDown(),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Fragments().mainButton(
                    size,
                    isBuyLoading ? "Loading..." : "Buy All",
                    isBuyLoading ? MainColors.gray : MainColors.purple,
                    FontSizes.buttonTitle,
                    MainColors.white,
                    isBuyLoading
                        ? () {}
                        : () {
                            try {
                              setState(() {
                                isBuyLoading = true;
                              });
                               notController.addNotifications(controller.products);
                              FirebaseFunctions()
                                  .buyProducts(controller.products);
                            } catch (e) {
                              setState(() {
                                isBuyLoading = false;
                              });
                            }
                          }),
              )
            ],
          ),
        ));
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
          padding: const EdgeInsets.only(left: 30.0),
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

  /*
 ! Yb        dP 88 8888b.   dP""b8 888888 888888     888888 Yb        dP  dP"Yb
 !  Yb  db  dP  88  8I  Yb dP   `" 88__     88         88    Yb  db  dP  dP   Yb
 !   YbdPYbdP   88  8I  dY Yb  "88 88""     88         88     YbdPYbdP   Yb   dP
 !    YP  YP    88 8888Y"   YboodP 888888   88         88      YP  YP     YbodP
  */

  productCard(size, data, index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: MainColors.white),
        width: size.width * 0.8,
        height: 120,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: size.width * 0.6,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 300,
                      child: Text(
                        "${data[index][ProductModelConsts().name]}",
                        maxLines: 2,
                        style: TextStyle(
                            color: MainColors.black,
                            fontFamily: FontFamily.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Quantity : ",
                            overflow: TextOverflow.fade,
                            style: TextStyle(
                                color: MainColors.black,
                                fontFamily: FontFamily.regular),
                          ),
                          Text(
                            "${data[index][ProductModelConsts().quantity]}",
                            overflow: TextOverflow.fade,
                            style: TextStyle(
                                color: MainColors.black,
                                fontFamily: FontFamily.regular),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "${(data[index][ProductModelConsts().price] * data[index][ProductModelConsts().quantity])} \$",
                overflow: TextOverflow.fade,
                style: TextStyle(
                    color: MainColors.purple,
                    fontFamily: FontFamily.bold,
                    fontSize: FontSizes.mainText),
              ),
            ],
          ),
        ),
      ),
    );
  }

/*
 !       Yb        dP 88 8888b.   dP""b8 888888 888888     888888 88  88 88""Yb 888888 888888
 !        Yb  db  dP  88  8I  Yb dP   `" 88__     88         88   88  88 88__dP 88__   88__
 !         YbdPYbdP   88  8I  dY Yb  "88 88""     88         88   888888 88"Yb  88""   88""
 !          YP  YP    88 8888Y"   YboodP 888888   88         88   88  88 88  Yb 888888 888888
*/

  addressDropDown() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 200,
          decoration: BoxDecoration(
              color: isAddressOpen ? MainColors.turquiose : MainColors.white,
              borderRadius: BorderRadius.circular(14.0)),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        "Address Details",
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                            color: MainColors.black,
                            fontFamily: FontFamily.bold),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            isAddressOpen = !isAddressOpen;
                          });
                        },
                        icon: const Icon(FeatherIcons.arrowDown)),
                  ],
                ),
              ),
              !isAddressOpen
                  ? Container()
                  : userData == null
                      ? CircularProgressIndicator(
                          color: MainColors.purple,
                        )
                      : Column(
                          children: [
                            Text(userData[FirebaseConsts().address],
                                style: TextStyle(
                                    color: MainColors.white,
                                    fontSize: FontSizes.mainText,
                                    fontFamily: FontFamily.bold)),
                          ],
                        )
            ],
          )),
    );
  }

  cardDropDown() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 200,
          decoration: BoxDecoration(
              color: iscardOpen ? MainColors.lightPurple : MainColors.white,
              borderRadius: BorderRadius.circular(14.0)),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        "Card Details",
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                            color: MainColors.black,
                            fontFamily: FontFamily.bold),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            iscardOpen = !iscardOpen;
                          });
                        },
                        icon: const Icon(FeatherIcons.arrowDown)),
                  ],
                ),
              ),
              !iscardOpen
                  ? Container()
                  : userData == null
                      ? CircularProgressIndicator(
                          color: MainColors.purple,
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text("Card Number : ",
                                      style: TextStyle(
                                          color: MainColors.white,
                                          fontSize: FontSizes.mainText,
                                          fontFamily: FontFamily.semiBold)),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20.0),
                                    child: Text(
                                        userData[FirebaseConsts().cardNum],
                                        style: TextStyle(
                                            color: MainColors.white,
                                            fontSize: FontSizes.mainText,
                                            fontFamily: FontFamily.bold)),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("Card Company : ",
                                      style: TextStyle(
                                          color: MainColors.white,
                                          fontSize: FontSizes.mainText,
                                          fontFamily: FontFamily.semiBold)),
                                  Text(
                                      userData[FirebaseConsts().cardCompany]
                                          .toUpperCase(),
                                      style: TextStyle(
                                          color: MainColors.white,
                                          fontSize: FontSizes.mainText,
                                          fontFamily: FontFamily.bold)),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("Card Expiry : ",
                                      style: TextStyle(
                                          color: MainColors.white,
                                          fontSize: FontSizes.mainText,
                                          fontFamily: FontFamily.semiBold)),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20.0),
                                    child: Text(
                                        userData[FirebaseConsts().cardExp],
                                        style: TextStyle(
                                            color: MainColors.white,
                                            fontSize: FontSizes.mainText,
                                            fontFamily: FontFamily.bold)),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("Card CVC : ",
                                      style: TextStyle(
                                          color: MainColors.white,
                                          fontSize: FontSizes.mainText,
                                          fontFamily: FontFamily.semiBold)),
                                  Text(userData[FirebaseConsts().cardCVC],
                                      style: TextStyle(
                                          color: MainColors.white,
                                          fontSize: FontSizes.mainText,
                                          fontFamily: FontFamily.bold)),
                                ],
                              ),
                            ],
                          ),
                        )
            ],
          )),
    );
  }

  /*
 ! Yb        dP 88 8888b.   dP""b8 888888 888888     888888  dP"Yb  88   88 88""Yb
 !  Yb  db  dP  88  8I  Yb dP   `" 88__     88       88__   dP   Yb 88   88 88__dP
 !   YbdPYbdP   88  8I  dY Yb  "88 88""     88       88""   Yb   dP Y8   8P 88"Yb
 !    YP  YP    88 8888Y"   YboodP 888888   88       88      YbodP  `YbodP' 88  Yb
  */

  /*
 << 888888 88b 88 8888b.       dP"Yb  888888      dP""b8 88        db    .dP"Y8 .dP"Y8
 << 88__   88Yb88  8I  Yb     dP   Yb 88__       dP   `" 88       dPYb   `Ybo." `Ybo."
 << 88""   88 Y88  8I  dY     Yb   dP 88""       Yb      88  .o  dP__Yb  o.`Y8b o.`Y8b
 << 888888 88  Y8 8888Y"       YbodP  88          YboodP 88ood8 dP""""Yb 8bodP' 8bodP'
  */
}
