import 'package:get/get.dart';
import 'package:house_cleaning/Screens/home_screen.dart';
import 'package:house_cleaning/Screens/info_screen.dart';
import 'package:house_cleaning/Screens/splash_screen.dart';
import 'package:house_cleaning/Screens/swipe_pages.dart';
import '../Bindings/home_binding.dart';
import '../Screens/add_user_data.dart';
import '../Screens/confirmation_screen.dart';
import 'page_routes.dart';

class AppRoutes {
  static final List<GetPage<dynamic>> routes = [
    GetPage(
      name: PageRoutes().splashScreen,
      page: () => const SplashScreen(),
    ),
    GetPage(
        name: PageRoutes().homeScreen,
        page: () => const HomeScreen(),
        binding: HomeBinding()),
    GetPage(name: PageRoutes().swipeScreen, page: () =>  SwipeScreen(selectedPage: Get.arguments,  )),
    GetPage(name: PageRoutes().infoScreen, page: () => const InfoScreen()),
    GetPage(
        name: PageRoutes().confirmationScreen,
        page: () => const ConfirmationScreen()),
    GetPage(
        name: PageRoutes().userDataScreen, page: () => const UserDataScreen()),
  ];
}
