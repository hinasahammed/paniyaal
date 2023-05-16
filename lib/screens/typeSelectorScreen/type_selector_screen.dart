import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paniyaal/screens/typeSelectorScreen/selecter_container.dart';
import 'package:paniyaal/screens/userPhoneVerificationScreen/user_phone_verification_screen.dart';
import 'package:paniyaal/screens/workerHomeScreen/worker_home_screen.dart';
import 'package:paniyaal/screens/workerLoginScreen/worker_login_screen.dart';

import '../userHomeScreen/user_home_screen.dart';

class TypeSelectorScreen extends StatelessWidget {
  TypeSelectorScreen({super.key});

  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xffdb3244),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Choose your account type',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                      color: Color(0xffffffff))),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SelecterContainer(
                  imageName: 'assets/user.png',
                  textName: 'User',
                  isUserLogedIn: () {
                    isUserLogedIn(context);
                  },
                ),
                SelecterContainer(
                    isUserLogedIn: () {
                      isWorkerLogedIn(context);
                    },
                    imageName: 'assets/customer.png',
                    textName: 'Worker')
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void isWorkerLogedIn(BuildContext context) {
  final auth = FirebaseAuth.instance;
  final user = auth.currentUser;
  if (user != null) {
    Navigator.push(
        context, MaterialPageRoute(builder: (ctx) => WorkerHomeScreen()));
  } else {
    Navigator.push(
        context, MaterialPageRoute(builder: (ctx) => WorkerLoginScreen()));
  }
}

void isUserLogedIn(BuildContext context) {
  final auth = FirebaseAuth.instance;
  final user = auth.currentUser;
  if (user != null) {
    Navigator.push(
        context, MaterialPageRoute(builder: (ctx) => UserHomeScreen()));
  } else {
    Navigator.push(
        context, MaterialPageRoute(builder: (ctx) => UserLoginScreen()));
  }
}
