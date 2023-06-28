// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:shop_corner/Screens/Login_Section/LoginScreen.dart';
import 'package:shop_corner/Screens/Login_Section/RegisterScreen.dart';

class SelectionScreen extends StatefulWidget {
  const SelectionScreen({Key? key}) : super(key: key);

  @override
  State<SelectionScreen> createState() => _SelectionScreenState();
}

class _SelectionScreenState extends State<SelectionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(children: const [
              Padding(
                padding: EdgeInsets.only(top: 15.0),
                child: Text(
                  "Welcome to Bolt",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15.0),
                child: Text(
                  "Explore Us",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ]),
            Image.asset("assets/images/Image.png"),
            Column(children: [
              TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                          colors: [HexColor("#667EEA"), HexColor("#64B6FF")]),
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 15),
                      child: const Center(
                        child: Text(
                          "Login",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  )),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RegisterScreen()));
                },
                child: const Text(
                  "Sign Up",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ])
          ],
        ),
      ),
    );
  }
}
