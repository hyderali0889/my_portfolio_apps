import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tik_tak_toe/Screens/game_selection.dart';
import 'Helper/object_box_helper.dart';
import 'Models/users.dart';
import 'Screens/main_screen.dart';
import 'objectbox.g.dart';
import 'package:get/get.dart';

late ObjectBox objectBox;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  objectBox = await ObjectBox.create();
  runApp(const MyWidget());
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Box<User> userData = objectBox.store.box<User>();
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.blue.shade600));
    return GetMaterialApp(
      defaultTransition: Transition.fade,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: "Medium", primaryColor: Colors.red),
      home: userData.count() == 0 ? const MainScreen() : const GameSelection(),
    );
  }
}
