import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:paniyaal/screens/typeSelectorScreen/type_selector_screen.dart';
import 'package:paniyaal/screens/userHomeScreen/user_home_screen.dart';
import 'package:paniyaal/screens/workerHomeScreen/worker_home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
var auth = FirebaseAuth.instance;

@override
  void initState() {
  loginOrNot();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: Image.asset("assets/logo.png"),),
    );
  }
Future<void> loginOrNot() async {
  await Future.delayed(
    Duration(seconds: 2),
  );
  if(auth.currentUser !=null){
    checkIfUserOrWorker();
  }else{
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=>TypeSelectorScreen()));
  }
}
checkIfUserOrWorker() async{
  auth.authStateChanges().listen((User? user) {
    String? email = user!.email;
    if(email!=null){
      if(email.isNotEmpty  && mounted){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=>WorkerHomeScreen()));
        print('worker');
      }else{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=>UserHomeScreen()));
      }
    }else{
      print("user");
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=>UserHomeScreen()));
    }

  });
}
}
