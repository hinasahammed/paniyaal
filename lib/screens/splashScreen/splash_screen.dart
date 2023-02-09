import 'package:paniyaal/screens/workerHomeScreen/worker_home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:paniyaal/screens/typeSelectorScreen/type_selector_screen.dart';

import '../userHomeScreen/user_home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    // gotoScreen();
    isLogedin();
  }
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset('assets/logo.png'),
      ),
    );
  }
  Future<void> gotoScreen() async {
    await Future.delayed(
      Duration(seconds: 3),
    );
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (ctx) => TypeSelectorScreen(),
      ),
    );
  }
  isLogedin() async{
    await Future.delayed(
      Duration(seconds: 3),
    );
    final user = auth.currentUser;
    if(user != null){
      final email = user.email;
      if(email!=null){
        Navigator.push(context, MaterialPageRoute(builder: (ctx)=>WorkerHomeScreen()));
      }else{
        Navigator.push(context, MaterialPageRoute(builder: (ctx)=>UserHomeScreen()));
      }
}else{
          Navigator.push(context, MaterialPageRoute(builder: (ctx)=>TypeSelectorScreen()));
          }
      }
}