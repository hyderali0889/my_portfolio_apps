import 'dart:io';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'Screens/SplashScreen.dart';

void main() {
  runApp(const MyApp());

  Platform.isWindows || Platform.isLinux || Platform.isMacOS
      ? doWhenWindowReady(() {
          final win = appWindow;
          const initialSize = Size(800, 600);
          win.minSize = initialSize;
          win.size = initialSize;
          win.alignment = Alignment.center;
          win.title = "Cook Book";
          win.show();
        })
      : "";
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'QuickSand'
       ),
      title: 'Cook Book',
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: SplashScreen());
  }
}
