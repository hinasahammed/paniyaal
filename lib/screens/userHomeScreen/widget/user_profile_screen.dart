import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:paniyaal/screens/typeSelectorScreen/type_selector_screen.dart';

import '../../userPhoneVerificationScreen/user_phone_verification_screen.dart';

class SettingsPage extends StatelessWidget {
   SettingsPage({Key? key}) : super(key: key);

  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        centerTitle: true,
        backgroundColor: Color(0xffdb3244),
        title: Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(children: [
          const SizedBox(
            height: 25,
          ),
          Card(
            child: ListTile(
              title: Text('Favourites'),
              leading: Icon(Icons.favorite),
              trailing: Icon(Icons.chevron_right),
            ),
          ),
          const SizedBox(height: 5,),
          Card(
            child: ListTile(
              onTap: () {
                auth.signOut().then((value) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (ctx) => TypeSelectorScreen()));
                }).onError((error, stackTrace) {
                  Fluttertoast.showToast(msg: error!.toString());
                });

              },
              title: Text('Login as worker'),
              leading: Icon(Icons.login),
              trailing: Icon(Icons.chevron_right),
            ),
          ),
          const SizedBox(height: 5,),
          Card(
            child: ListTile(
              title: Text('Contact us'),
              leading: Icon(Icons.contact_mail),
              trailing: Icon(Icons.chevron_right),
            ),
          ),
          const SizedBox(height: 5,),
          Card(
            child: ListTile(
              onTap: () {
                auth.signOut().then((value) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (ctx) => UserLoginScreen()));
                }).onError((error, stackTrace) {
                  Fluttertoast.showToast(msg: error!.toString());
                });
              },
              title: Text('Logout'),
              leading: Icon(Icons.logout),
              trailing: Icon(Icons.chevron_right),
            ),
          ),
          const SizedBox(height: 5,),
        ],),
      ),
    );
  }
}
