import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:paniyaal/screens/typeSelectorScreen/type_selector_screen.dart';
import 'package:paniyaal/screens/userHomeScreen/user_home_screen.dart';
import 'package:paniyaal/screens/userPhoneVerificationScreen/user_phone_verification_screen.dart';
import 'package:paniyaal/screens/workerHomeScreen/worker_home_screen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    gotoScreen(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/logo.png'),
      ),
    );
  }
}

Future<void> gotoScreen(BuildContext context) async {
  await Future.delayed(
    Duration(seconds: 3),
  );
  Navigator.of(context).pushReplacement(
    MaterialPageRoute(
      builder: (ctx) => TypeSelectorScreen(),
    ),
  );
}
