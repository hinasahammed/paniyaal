import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../typeSelectorScreen/type_selector_screen.dart';
import '../userHomeScreen/user_home_screen.dart';

class SplashScreenServices {
  void gotoScreen(BuildContext context) async {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    if (user != null) {
      Timer(Duration(seconds: 3), ()=> Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (ctx) => UserHomeScreen())),);

    } else {
      Timer(Duration(seconds: 3), ()=> Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (ctx) => TypeSelectorScreen())),);
    }
  }
}
