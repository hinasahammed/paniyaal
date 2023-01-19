import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../workerLoginScreen/worker_login_screen.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Profile'),
          backgroundColor: Color(0xffdb3244),
          centerTitle: true,
        ),
        body: SafeArea(
            child: ListView(children: [
              SizedBox(height: 30,),
              Card(child: ListTile(
                title: Text('Worker'),
                leading:Icon(Icons.person),
              ),),
              Card(child: ListTile(
                title: Text('Contact us'),
                leading:Icon(Icons.contact_mail),
              ),),
              Card(child: ListTile(
                title: Text('Logout'),
                leading:Icon(Icons.logout),
              ),),
            ],)));
  }
}
