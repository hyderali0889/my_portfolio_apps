import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:house_cleaning/Routes/page_routes.dart';
import 'package:house_cleaning/utils/font_names.dart';
import 'package:house_cleaning/utils/main_colors.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: MainColors().textWhite,
      body: SafeArea(
          child: SizedBox(
        width: size.width,
        height: size.height,
        child: Column(
          children: [
            SizedBox(
              width: size.width,
              height: size.height * 0.54,
              child: Stack(
                children: [
                  Positioned(
                    right: -238,
                    top: 100,
                    child: Container(
                      width: 520,
                      height: 305,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                'assets/icons/main.png',
                              ))),
                    ),
                  ),
                ],
              ),
            ),
            Container(
                width: size.width,
                height: size.height * 0.429,
                decoration: BoxDecoration(
                    color: MainColors().backgroundPurple,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Cleaning On Demand",
                                style: context.textTheme.bodyMedium!.copyWith(
                                    fontFamily: FontNames().monst["bold"])),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text(
                                  textAlign: TextAlign.center,
                                  "Book an appointment in \n"
                                  "less than 60 seconds and get on \n"
                                  "the schedule as early as \n"
                                  "tomorrow.",
                                  style: context.textTheme.bodyMedium!
                                      .copyWith(fontSize: 12)),
                            ),
                          ]),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(),
                        Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: InkWell(
                            onTap: () {
                              Get.toNamed(PageRoutes().swipeScreen , arguments: 1);
                            },
                            child: Row(
                              children: [
                                Text(
                                  "Next",
                                  style: context.textTheme.bodyMedium!
                                      .copyWith(fontSize: 12),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 5.0),
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: 25,
                                    height: 25,
                                    decoration: BoxDecoration(
                                        color: MainColors().subTextYellow,
                                        shape: BoxShape.circle),
                                    child: FaIcon(FontAwesomeIcons.arrowRight,
                                        color: MainColors().textWhite,
                                        size: 14),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                )),
          ],
        ),
      )),
    );
  }
}
