import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
                Container(
                  width: 175,
                  height: 211,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0))),
                    child: InkWell(
                      onTap: () {
                        isUserLogedIn(context);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/user.png',
                            width: 117,
                            height: 117,
                            fit: BoxFit.cover,
                          ),
                          Text(
                            'User',
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff000000))),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 175,
                  height: 211,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0))),
                    child: InkWell(
                      onTap: () {
                        isWorkerLogedIn(context);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/customer.png',
                            width: 117,
                            height: 117,
                            fit: BoxFit.cover,
                          ),
                          Text(
                            'Worker',
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff000000))),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void isWorkerLogedIn(BuildContext context){
  final auth = FirebaseAuth.instance;
  final user = auth.currentUser;
  if(user != null){
    Navigator.push(context, MaterialPageRoute(builder: (ctx)=>WorkerHomeScreen()));
  }else{
    Navigator.push(context, MaterialPageRoute(builder: (ctx)=>WorkerLoginScreen()));
  }
}
void isUserLogedIn(BuildContext context){
  final auth = FirebaseAuth.instance;
  final user = auth.currentUser;
  if(user != null){
    Navigator.push(context, MaterialPageRoute(builder: (ctx)=>UserHomeScreen()));
  }else{
    Navigator.push(context, MaterialPageRoute(builder: (ctx)=>UserLoginScreen()));
  }
}

