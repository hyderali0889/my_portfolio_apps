import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/main_colors.dart';
import 'about_screen.dart';
import 'calender_screen.dart';
import 'home_screen.dart';
import '../Controller/home_controller.dart';

class SwipeScreen extends StatefulWidget {
  const SwipeScreen({super.key, required this.selectedPage});
  final int selectedPage;

  @override
  State<SwipeScreen> createState() => _SwipeScreenState();
}

class _SwipeScreenState extends State<SwipeScreen> {
  PageController? pageController;
  @override
  void initState() {
    super.initState();
    if (!mounted) {
      return;
    }
    pageController = PageController(initialPage: widget.selectedPage);

    Get.put(HomeController());
    if (widget.selectedPage != 2) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        removeDialog();
      });
    }
  }

  void removeDialog() async {
    showNewDialog();
    await Future.delayed(const Duration(seconds: 2));
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        scrollBehavior: AppScrollBehavior(),
        controller: pageController,
        children: const [AboutScreen(), HomeScreen(), CalenderScreen()],
      ),
    );
  }

  showNewDialog() {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              alignment: Alignment.center,
              width: 400,
              height: 150,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  "Swipe to Switch Screens. Long press to remove extras",
                  style: TextStyle(
                      color: MainColors().backgroundPurple, fontSize: 20),
                ),
              ),
            ),
          );
        });
  }
}

class AppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad,
      };
}
