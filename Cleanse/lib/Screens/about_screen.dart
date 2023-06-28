import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:house_cleaning/Screens/swipe_pages.dart';
import 'package:house_cleaning/utils/main_colors.dart';
import '../Routes/page_routes.dart';
import '../utils/font_names.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
          child: SizedBox(
        width: size.width,
        height: size.height,
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.3,
              child: Center(
                  child: Image.asset(
                'assets/icons/aboutimg.png',
                width: 125,
                height: 125,
              )),
            ),
            Expanded(
              child: Container(
                width: size.width,
                decoration: BoxDecoration(
                  color: MainColors().textWhite,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(14.0),
                      topRight: Radius.circular(14.0)),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 25.0, left: 25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Accounts",
                        style: context.textTheme.labelLarge!.copyWith(
                            fontSize: 18, fontFamily: FontNames().pub["bold"]),
                      ),
                      InkWell(
                        onTap: () {
                          Get.offAll(const SwipeScreen(selectedPage: 2));
                        },
                        child: const MainListItem(
                          icon: FontAwesomeIcons.solidCalendar,
                          text: "My Bookings",
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.toNamed(PageRoutes().userDataScreen,
                              arguments: true);
                        },
                        child: const MainListItem(
                          icon: FontAwesomeIcons.solidMap,
                          text: "Addresses",
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 25.0),
                        child: Text(
                          "Share",
                          style: context.textTheme.labelLarge!.copyWith(
                              fontSize: 18,
                              fontFamily: FontNames().pub["bold"]),
                        ),
                      ),
                      const MainListItem(
                        icon: FontAwesomeIcons.facebook,
                        text: "Facebook",
                      ),
                      const MainListItem(
                        icon: FontAwesomeIcons.twitter,
                        text: "Twitter",
                      ),
                      const MainListItem(
                        icon: FontAwesomeIcons.google,
                        text: "Gmail",
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

class MainListItem extends StatelessWidget {
  const MainListItem({
    super.key,
    required this.icon,
    required this.text,
  });
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: Row(
        children: [
          FaIcon(
            icon,
            color: MainColors().backgroundPurple,
            size: 18,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35.0),
            child: Text(
              text,
              style: context.textTheme.labelMedium!
                  .copyWith(fontFamily: FontNames().pub["reg"]),
            ),
          )
        ],
      ),
    );
  }
}
