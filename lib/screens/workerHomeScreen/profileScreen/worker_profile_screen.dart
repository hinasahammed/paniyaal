import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:paniyaal/screens/workerHomeScreen/workerDetailScreen/worker_detail_screen.dart';

import '../../typeSelectorScreen/type_selector_screen.dart';
import '../../workerLoginScreen/worker_login_screen.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              child: ListView(
          children: [
              const SizedBox(
                height: 25,
              ),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("workersLogedIn")
                    .where("uid", isEqualTo: auth.currentUser!.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator(strokeWidth: 3,color: Colors.white,);
                  } else {
                    return Column(
                      children: snapshot.data!.docs.map((document) {
                        return Column(
                          children: [
                            Container(
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
                                child: Image.network(
                                  document["imageUrl"],
                                  width: 130,
                                  height: 130,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(height: 15,),
                            Text(
                              document["fullName"].toUpperCase(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 15),
                            ),
                            Text(
                              document["phoneNumber"],
                              style: TextStyle(
                                  fontWeight: FontWeight.w300, fontSize: 15),
                            ),
                            Text(
                              document["email"],
                              style: TextStyle(
                                  fontWeight: FontWeight.w300, fontSize: 15),
                            ),
                          ],
                        );
                      }).toList(),
                    );
                  }
                },
              ),
              const SizedBox(
                height: 25,
              ),
              Card(
                child: ListTile(
                  onTap: (){
                    auth.signOut().then((value) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (ctx) => TypeSelectorScreen()));
                    }).onError((error, stackTrace) {
                      Fluttertoast.showToast(msg: error!.toString());
                    });
                  },
                  title: Text('Login as User'),
                  leading: Icon(Icons.login),
                  trailing: Icon(Icons.chevron_right),
                ),
              ),
              Card(
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (ctx) => WorkerDetailScreen()));
                  },
                  title: Text('Edit your details'),
                  leading: Icon(Icons.edit),
                  trailing: Icon(Icons.chevron_right),
                ),
              ),
              Card(
                child: ListTile(
                  title: Text('Contact us'),
                  leading: Icon(Icons.contact_mail),
                  trailing: Icon(Icons.chevron_right),
                ),
              ),
              Card(
                child: ListTile(
                  onTap: () {
                    auth.signOut().then((value) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (ctx) => WorkerLoginScreen()));
                    }).onError((error, stackTrace) {
                      Fluttertoast.showToast(msg: error!.toString());
                    });
                  },
                  title: Text('Logout'),
                  leading: Icon(Icons.logout),
                  trailing: Icon(Icons.chevron_right),
                ),
              ),
          ],
        ),
            )));
  }
}


