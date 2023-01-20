import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:paniyaal/screens/workerHomeScreen/workerDetailScreen/worker_detail_screen.dart';

import '../../workerLoginScreen/worker_login_screen.dart';

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
              Center(
                child: Container(
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(
                    border: Border.all(width: 4, color: Colors.white),
                    boxShadow: [
                      BoxShadow(
                        spreadRadius: 3,
                        blurRadius: 10,
                        color: Colors.black.withOpacity(0.1),
                      ),
                    ],
                    shape: BoxShape.circle,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset(
                      'assets/profile.jpeg',
                      width: 130,
                      height: 130,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Card(child: ListTile(
                title: Text('Paniyaal'),
                leading:Icon(Icons.person),
                trailing: Icon(Icons.chevron_right),
              ),),
              Card(child: ListTile(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (ctx)=>WorkerDetailScreen()));
                },
                title: Text('Details'),
                leading:Icon(Icons.details),
                trailing: Icon(Icons.chevron_right),
              ),),
              Card(child: ListTile(
                title: Text('Contact us'),
                leading:Icon(Icons.contact_mail),
                trailing: Icon(Icons.chevron_right),
              ),),
              Card(child: ListTile(
                onTap: (){
                  auth.signOut().then((value) {
                    Navigator.push(context, MaterialPageRoute(builder: (ctx)=>WorkerLoginScreen()));
                  }).onError((error, stackTrace) {
                    Fluttertoast.showToast(msg: error!.toString());
                  });
                },
                title: Text('Logout'),
                leading:Icon(Icons.logout),
                trailing: Icon(Icons.chevron_right),
              ),),
            ],)));
  }
}
