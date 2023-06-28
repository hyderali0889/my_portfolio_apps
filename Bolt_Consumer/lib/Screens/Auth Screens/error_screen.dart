import 'package:bolt/Components/fragments.dart';
import 'package:bolt/Controllers/error_screen_controller.dart';
import 'package:bolt/Theme/colors.dart';
import 'package:bolt/Theme/font_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';

class ErrorScreen extends StatefulWidget {
  const ErrorScreen({super.key, required this.message});

  final String message;

  @override
  State<ErrorScreen> createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
  @override
  void initState() {
    super.initState();

    Get.put(ErrorController());
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ErrorController controller = Get.find<ErrorController>();

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            SizedBox(
              width: size.width,
              height: size.height,
              child: const Opacity(
                opacity: 1,
              ),
            ),
            Center(
              child: Container(
                height: 300,
                width: 400,
                decoration: BoxDecoration(
                  color: MainColors.lightPurple,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top:10.0),
                      child: Row(
                        children: [
                          const Spacer(),
                          IconButton(
                            onPressed: () {
                              Get.back();
                              controller.changeError(true);
                            },
                            icon: Icon(
                              FeatherIcons.x,
                              color: MainColors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: MainColors.black, width: 1.0))),
                      child: Fragments().headingText("An Error Occured",
                          FontSizes.mainHeading, MainColors.black),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Fragments().headingText(widget.message,
                          FontSizes.productTitle, MainColors.offWhite2),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
