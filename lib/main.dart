import 'package:flutter/material.dart';
import 'package:paniyaal/screens/splashScreen/splash_screen.dart';
import 'package:paniyaal/screens/typeSelectorScreen/type_selector_screen.dart';
import 'package:paniyaal/screens/userHomeScreen/user_home_screen.dart';
import 'package:paniyaal/screens/userPhoneVerificationScreen/otp_verification_screen.dart';
import 'package:paniyaal/screens/userPhoneVerificationScreen/user_phone_verification_screen.dart';
import 'package:paniyaal/screens/workerLoginScreen/worker_login_screen.dart';
import 'package:paniyaal/screens/workerLoginScreen/worker_signup_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PANIYAAL',
      theme: ThemeData(
        primaryColor: Color(0xffdb3244),
      ),
      initialRoute: 'splash',
      routes: {
        'numberVerification': (context) => UserLoginScreen(),
        'otpVerification': (context) => OtpVerificationScreen(),
        'typeSelector': (context) => TypeSelectorScreen(),
        'splash':(context)=>SplashScreen(),
        'workerlogin': (context)=>WorkerLoginScreen(),
        'signup':(context)=>WorkerSignupScreen(),
        'home':(context)=>UserHomeScreen(),
      },
    );
  }
}
