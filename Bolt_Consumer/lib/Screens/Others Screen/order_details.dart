import 'package:bolt/Components/fragments.dart';
import 'package:bolt/Constants/firebase_const.dart';
import 'package:bolt/Controllers/order_details_controller.dart';
import 'package:bolt/Screens/Others%20Screen/checkout_screen.dart';
import 'package:bolt/Theme/colors.dart';
import 'package:bolt/Theme/font_family.dart';
import 'package:bolt/Theme/font_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';

import '../../Utils/firebase_functions.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails({super.key});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  dynamic bucket;
  int quantity = 0;

  @override
  void initState() {
    super.initState();
    Get.put(OrderDetailsController());
    getBucketData();
  }

  getBucketData() async {
    dynamic data = await FirebaseFunctions().getBucketData();
    setState(() {
      bucket = data;
    });

    Get.find<OrderDetailsController>().products.value = [];
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    OrderDetailsController controller = Get.find<OrderDetailsController>();

    return Scaffold(
      backgroundColor: MainColors.mainPageColor,
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: ListView(
          children: [
            upperRow(size),
            SizedBox(
              width: size.width,
              height: size.height * 0.8,
              child: bucket != null
                  ? ListView.builder(
                      itemCount: bucket.docs.length,
                      itemBuilder: (context, index) {
                        return ProductCard(
                          bucket: bucket.docs[index],
                          index: index,
                        );
                      },
                    )
                  : Center(
                      child:
                          CircularProgressIndicator(color: MainColors.purple),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Fragments().mainButton(
                  size,
                  "Proceed To CheckOut",
                  MainColors.purple,
                  FontSizes.buttonTitle,
                  MainColors.white, () {
                controller.concludeSum();
                Get.to(() => const CheckOutScreen());
              }),
            )
          ],
        ),
      ),
    );
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
?  Yb        dP 88 8888b.   dP""b8 888888 888888     888888 Yb        dP  dP"Yb
?   Yb  db  dP  88  8I  Yb dP   `" 88__     88         88    Yb  db  dP  dP   Yb
?    YbdPYbdP   88  8I  dY Yb  "88 88""     88         88     YbdPYbdP   Yb   dP
?     YP  YP    88 8888Y"   YboodP 888888   88         88      YP  YP     YbodP
  */

  /*
 << 888888 88b 88 8888b.       dP"Yb  888888      dP""b8 88        db    .dP"Y8 .dP"Y8
 << 88__   88Yb88  8I  Yb     dP   Yb 88__       dP   `" 88       dPYb   `Ybo." `Ybo."
 << 88""   88 Y88  8I  dY     Yb   dP 88""       Yb      88  .o  dP__Yb  o.`Y8b o.`Y8b
 << 888888 88  Y8 8888Y"       YbodP  88          YboodP 88ood8 dP""""Yb 8bodP' 8bodP'
  */
}

class ProductCard extends StatefulWidget {
  const ProductCard({super.key, required this.bucket, required this.index});

  final dynamic bucket;
  final int index;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  void initState() {
    super.initState();
    Get.put(OrderDetailsController());
    Get.find<OrderDetailsController>().addDataToProductsList({
      ProductModelConsts().name: widget.bucket[FirebaseConsts().products]
          [ProductModelConsts().name],
      ProductModelConsts().price: widget.bucket[FirebaseConsts().products]
          [ProductModelConsts().price],
      ProductModelConsts().quantity: quantity
    });
  }

  int quantity = 1;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        width: size.width * 0.8,
        height: 160,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0), color: MainColors.white),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: size.width * 0.6,
                    height: 60,
                    child: ListView(
                      children: [
                        Text(
                            widget.bucket[FirebaseConsts().products]
                                [ProductModelConsts().name],
                            style: Fragments().mainTextStyle(
                              FontSizes.mainText,
                              MainColors.black,
                              FontFamily.bold,
                            )),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Text(
                        "${widget.bucket[FirebaseConsts().products][ProductModelConsts().price]} \$",
                        style: Fragments().mainTextStyle(
                          FontSizes.subText,
                          MainColors.purple,
                          FontFamily.bold,
                        )),
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        if (quantity <= 1) {
                        } else {
                          setState(() {
                            quantity--;
                          });
                          Get.find<OrderDetailsController>()
                              .updateQuantity(widget.index, quantity);
                        }
                      },
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                            color: MainColors.mainPageColor,
                            borderRadius: BorderRadius.circular(5)),
                        child: const Center(child: Text("-")),
                      ),
                    ),
                  ),
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                        color: MainColors.mainPageColor,
                        borderRadius: BorderRadius.circular(5)),
                    child: Center(child: Text("$quantity")),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        if (quantity <= 0) {
                        } else {
                          setState(() {
                            quantity++;
                          });
                          Get.find<OrderDetailsController>()
                              .updateQuantity(widget.index, quantity);
                        }
                      },
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                            color: MainColors.mainPageColor,
                            borderRadius: BorderRadius.circular(5)),
                        child: const Center(child: Text("+")),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
