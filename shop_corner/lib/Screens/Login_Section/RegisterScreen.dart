// ignore_for_file: file_names
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:shop_corner/Screens/Login_Section/LoginScreen.dart';
import 'package:shop_corner/Screens/Login_Section/SelectionScreen.dart';
import 'package:timer_snackbar/timer_snackbar.dart';
import '../../Utils/firebase_functions.dart';
import '../UI_Section/HomeScreen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  bool isClicked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const SelectionScreen()));
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.05,
            right: MediaQuery.of(context).size.width * 0.05,
            top: MediaQuery.of(context).size.width * 0.05,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Text(
                    " Signup ",
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  )
                ],
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.4,
                padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.05),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      controller: nameController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                          hintText: "Name",
                          hintStyle: TextStyle(color: Colors.white54),
                          focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1.0)),
                          enabledBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1.0))),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(top: 25.0),
                        child: TextField(
                          controller: emailController,
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                              hintText: "Email",
                              hintStyle: TextStyle(color: Colors.white54),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 1.0)),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 1.0))),
                        )),
                    Padding(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: TextField(
                        obscureText: true,
                        controller: passwordController,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                            hintText: "Password",
                            hintStyle: TextStyle(color: Colors.white54),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.white, width: 1.0))),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  TextButton(
                      onPressed: isClicked ? () => {} : () => signUp(),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: isClicked
                                ? LinearGradient(colors: [
                                    HexColor("#131313"),
                                    HexColor("#131313")
                                  ])
                                : LinearGradient(colors: [
                                    HexColor("#667EEA"),
                                    HexColor("#64B6FF")
                                  ])),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 15),
                          child: Center(
                            child: isClicked
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : const Text(
                                    "Sign Up",
                                    style: TextStyle(color: Colors.white),
                                  ),
                          ),
                        ),
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account ?",
                        style: TextStyle(color: Colors.white54),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginScreen()));
                          },
                          child: const Text(
                            "Sign in",
                            style: TextStyle(color: Colors.white),
                          ))
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  //
  // ──────────────────────────────────────────────────────────────────────── I ──────────
  //   :::::: F U N C T I O N   S E C T I O N : :  :   :    :     :        :          :
  // ──────────────────────────────────────────────────────────────────────────────────
  //

  signUp() async {
    if (nameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        passwordController.text.length >= 6) {
      setState(() {
        isClicked = true;
      });
      await FirebaseFunctions().signUp(nameController.text,
          emailController.text, passwordController.text, context);

      if (FirebaseAuth.instance.currentUser != null) {
        FirebaseAuth.instance.currentUser
            ?.updateDisplayName(nameController.text);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
            (route) => false);
      }
    } else {
      timerSnackbar(
          backgroundColor: Colors.red,
          buttonLabel: "",
          context: context,
          contentText: "Please Check your Credentials",
          second: 2,
          afterTimeExecute: () {});
      setState(() {
        isClicked = false;
      });
    }
  }
}
