import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:house_cleaning/utils/theme_data.dart';
import 'Helpers/object_box_helper.dart';
import 'Routes/app_routes.dart';
import 'Routes/page_routes.dart';
import 'firebase_options.dart';

late ObjectBox objectBox;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  objectBox = await ObjectBox.create();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cleanse',
      theme: MainAppTheme().mainTheme,
      getPages: AppRoutes.routes,
      initialRoute: PageRoutes().splashScreen,
    );
  }
}
