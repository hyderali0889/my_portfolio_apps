import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:house_cleaning/utils/firebase_functions.dart';
import 'package:house_cleaning/utils/main_colors.dart';

import '../Models/user_model.dart';
import '../main.dart';
import '../objectbox.g.dart';
import '../utils/font_names.dart';

class CalenderScreen extends StatefulWidget {
  const CalenderScreen({super.key});

  @override
  State<CalenderScreen> createState() => _CalenderScreenState();
}

class _CalenderScreenState extends State<CalenderScreen> {
  dynamic data;
  @override
  void initState() {
    super.initState();
    if (!mounted) {
      return;
    }
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getFirebaseData();
    });
  }

  getFirebaseData() async {
    if (!mounted) {
      return;
    }
    dynamic fData;
    fData = await FirebaseFunctions().getFirebaseData(context);

    setState(() {
      data = fData;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Box<User> userData = objectBox.store.box<User>();

    return Scaffold(
      body: SafeArea(
          child: SizedBox(
        width: size.width,
        height: size.height,
        child: Column(
          children: [
            SizedBox(
                height: size.height * 0.1,
                width: size.width,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Text(
                        "Cleanse History",
                        style: context.textTheme.bodyMedium!.copyWith(
                            fontFamily: FontNames().monst['semiBold']),
                      ),
                    ),
                  ],
                )),
            Expanded(
              child: Container(
                width: size.width,
                decoration: BoxDecoration(
                    color: MainColors().textWhite,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(14.0),
                        topRight: Radius.circular(14.0))),
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 20.0, left: 20, right: 20),
                  child: ListView(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          data != null
                              ? SizedBox(
                                  height: size.height * 0.88,
                                  child: ListView.builder(
                                    itemCount: data.length,
                                    itemBuilder: ((context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12.0),
                                        child: MainCard(
                                          size: size,
                                          hour: data[index]["Hour"].toString(),
                                          name: userData.get(1)!.name,
                                          cType: data[index]["Cleaning Type"]
                                              .toString(),
                                          price: "20",
                                        ),
                                      );
                                    }),
                                  ),
                                )
                              : const CircularProgressIndicator()
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}

class MainCard extends StatelessWidget {
  const MainCard({
    super.key,
    required this.size,
    required this.hour,
    required this.name,
    required this.cType,
    required this.price,
  });

  final Size size;
  final String hour;
  final String name;
  final String cType;
  final String price;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Text(
            "Time :  $hour : 00",
            style: context.textTheme.labelSmall!
                .copyWith(fontFamily: FontNames().monst["semiBold"]),
          ),
        ),
        Container(
          color: MainColors().imgBackground,
          width: size.width * 0.7,
          height: size.height * 0.25,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: context.textTheme.headlineSmall!
                      .copyWith(fontFamily: FontNames().monst["bold"]),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Text(cType, style: context.textTheme.labelSmall),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Row(
                    children: [
                      FaIcon(
                        FontAwesomeIcons.solidClock,
                        color: MainColors().backgroundPurple,
                        size: 12,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text("$hour : 00",
                            style: context.textTheme.headlineSmall!.copyWith(
                                fontSize: 12,
                                fontFamily: FontNames().monst["bold"])),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Text("Client Rating",
                            style: context.textTheme.labelSmall!.copyWith(
                                fontSize: 12,
                                fontFamily: FontNames().monst["light"])),
                      ),
                      SizedBox(
                        width: size.width * 0.2,
                        height: size.height * 0.02,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            return FaIcon(
                              FontAwesomeIcons.solidStar,
                              color: MainColors().mainBlack,
                              size: 11,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: MainColors().borderBlack,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        InkWell(
                            child: FaIcon(
                          FontAwesomeIcons.lightPhone,
                          size: 12,
                          color: MainColors().backgroundPurple,
                        )),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: InkWell(
                              child: FaIcon(
                            FontAwesomeIcons.lightMailbox,
                            size: 12,
                            color: MainColors().backgroundPurple,
                          )),
                        ),
                      ],
                    ),
                    Text("\$ $price",
                        style: context.textTheme.headlineSmall!.copyWith(
                            fontSize: 12,
                            fontFamily: FontNames().monst["semiBold"])),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
