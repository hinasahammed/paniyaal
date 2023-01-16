import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../workerLoginScreen/worker_login_screen.dart';

class WorkerMainPage extends StatelessWidget {
   WorkerMainPage({Key? key}) : super(key: key);
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        title: Text('Workers'),
        centerTitle: true,
        backgroundColor: Color(0xffdb3244),
        actions: [
          IconButton(onPressed: () {
            auth.signOut().then((value) {
              Navigator.push(context, MaterialPageRoute(builder: (ctx)=>WorkerLoginScreen()));
            }).onError((error, stackTrace) {
              Fluttertoast.showToast(msg: error!.toString());
            });
          }, icon: Icon(Icons.logout)),
        ],
      ),
      body: Center(
        child: Text('Worker home screen '),
      ),
    );
  }
}
