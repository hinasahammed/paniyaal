import 'package:cloud_firestore/cloud_firestore.dart';
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
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   elevation: 0,
      //   backgroundColor: Color(0xffdb3244),
      // ),
      //   title: Text('Profile'),
      body: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("UsersLogedin")
                .where("uid", isEqualTo: auth.currentUser!.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator(
                  strokeWidth: 3,
                  color: Colors.black,
                );
              } else {
                return Column(
                  children: snapshot.data!.docs.map((document) {
                    return Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xffdb3244),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 15.0,
                              right: 15.0,
                              top: 10.0,
                              bottom: 25.0,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Setting',
                                  style: TextStyle(
                                      fontSize: 22,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1, color: Colors.black),
                                        boxShadow: [
                                          BoxShadow(
                                            spreadRadius: 3,
                                            blurRadius: 10,
                                            color:
                                                Colors.black.withOpacity(0.1),
                                          ),
                                        ],
                                        shape: BoxShape.circle,
                                      ),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: Image.network(
                                          document["imageUrl"],
                                          width: 60,
                                          height: 60,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          'Hello',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w300),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          document['fullName'],
                                          style: TextStyle(
                                              fontSize: 22,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),

                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 25,
                                ),
                                Card(
                                  child: ListTile(
                                    onTap: () {},
                                    title: Text('Edit your details'),
                                    leading: Icon(Icons.edit),
                                    trailing: Icon(Icons.chevron_right),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Card(
                                  child: ListTile(
                                    title: Text('Favourites'),
                                    leading: Icon(Icons.favorite),
                                    trailing: Icon(Icons.chevron_right),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
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
                                const SizedBox(
                                  height: 5,
                                ),
                                Card(
                                  child: ListTile(
                                    title: Text('Contact us'),
                                    leading: Icon(Icons.contact_mail),
                                    trailing: Icon(Icons.chevron_right),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
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
                                const SizedBox(
                                  height: 5,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    );
                  }).toList(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
