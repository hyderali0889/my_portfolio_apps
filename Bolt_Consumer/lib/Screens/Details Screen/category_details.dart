import 'package:bolt/Screens/Details%20Screen/product_details.dart';
import 'package:bolt/Screens/Nav%20Screens/main_menu.dart';
import 'package:bolt/Theme/colors.dart';
import 'package:bolt/Theme/font_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import '../../Components/fragments.dart';
import '../../Controllers/main_menu_controller.dart';

class CategoryDetails extends StatefulWidget {
  const CategoryDetails({super.key, required this.cat, required this.data});
  final dynamic data;
  final String cat;

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  @override
  Widget build(BuildContext context) {
   
    MainMenuController controller = Get.find<MainMenuController>();
    return Scaffold(
        body: SafeArea(
            child: Column(
      children: [
        upperRow(controller),
        Expanded(
          child: ListView.builder(
              itemCount: widget.data.length,
              itemBuilder: (context, index) {
                return widget.data[index]["Type"] == widget.cat
                    ? Center(
                        child: SizedBox(
                          height: 350,
                          child: InkWell(
                            onTap: () {
                              Get.to(() =>
                                  ProductDetails(data: widget.data[index]));
                            },
                            child: Fragments().mainProductCard(
                                widget.data, index, widget.cat),
                          ),
                        ),
                      )
                    : Container();
              }),
        ),
      ],
    )));
  }

/*
 ?  Yb        dP 88 8888b.   dP""b8 888888 888888 .dP"Y8     .dP"Y8 888888  dP""b8 888888 88  dP"Yb  88b 88 .dP"Y8
 ?   Yb  db  dP  88  8I  Yb dP   `" 88__     88   `Ybo."     `Ybo." 88__   dP   `"   88   88 dP   Yb 88Yb88 `Ybo."
 ?    YbdPYbdP   88  8I  dY Yb  "88 88""     88   o.`Y8b     o.`Y8b 88""   Yb        88   88 Yb   dP 88 Y88 o.`Y8b
 ?     YP  YP    88 8888Y"   YboodP 888888   88   8bodP'     8bodP' 888888  YboodP   88   88  YbodP  88  Y8 8bodP'
*/

/*
! Yb        dP 88 8888b.   dP""b8 888888 888888      dP"Yb  88b 88 888888
!  Yb  db  dP  88  8I  Yb dP   `" 88__     88       dP   Yb 88Yb88 88__
!   YbdPYbdP   88  8I  dY Yb  "88 88""     88       Yb   dP 88 Y88 88""
!    YP  YP    88 8888Y"   YboodP 888888   88        YbodP  88  Y8 888888
*/

  upperRow(controller) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
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
          Fragments().headingText(
              "All Products", FontSizes.mainHeading, MainColors.black),
          IconButton(
              onPressed: () {
                controller.changePage(1);
                Get.to(() => const MainMenu());
              },
              icon: Icon(
                FeatherIcons.shoppingCart,
                color: MainColors.black,
              ))
        ],
      ),
    );
  }
}
