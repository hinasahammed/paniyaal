import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class WorkerMainPage extends StatelessWidget {
  WorkerMainPage({Key? key}) : super(key: key);
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Paniyaal'),
          backgroundColor: Color(0xffdb3244),
          automaticallyImplyLeading: false,
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("workersLogedIn").where("uid", isEqualTo: auth.currentUser!.uid)
              .where("status", isEqualTo: "booked")
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator(
                strokeWidth: 3,
                color: Colors.white,
              );
            } else {
              return ListView(
                children: snapshot.data!.docs.map((document) {
                  return StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("UsersLogedin").where(auth.currentUser!.uid, isEqualTo: "booked")
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return CircularProgressIndicator(
                          strokeWidth: 3,
                          color: Colors.white,
                        );
                      } else {
                        return Column(
                          children: snapshot.data!.docs.map((userDocument) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12.0,),
                              child: Column(
                                children: [
                                  SizedBox(height: 10,),
                                  Container(
                                    width: double.infinity,
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        children: [
                                          IntrinsicHeight(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Container(
                                                      width: 100,
                                                      height: 100,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            width: 4, color: Colors.white),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            spreadRadius: 3,
                                                            blurRadius: 10,
                                                            color: Colors.black
                                                                .withOpacity(0.1),
                                                          ),
                                                        ],
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                        BorderRadius.circular(100),
                                                        child: Image.network(
                                                          userDocument["imageUrl"],
                                                          width: 130,
                                                          height: 130,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                VerticalDivider(
                                                  thickness: 0.3,
                                                  indent: 8,
                                                  endIndent: 5,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                                  children: [
                                                    Text("Name: " + userDocument["fullName"]),
                                                    Text("Ph: " + userDocument["phoneNumber"]),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Divider(
                                            thickness: 0.3,
                                          ),
                                          IntrinsicHeight(
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                              children: [
                                                TextButton.icon(
                                                    onPressed: () {
                                                    },
                                                    style: TextButton.styleFrom(foregroundColor: Color(0xffdb3244)),
                                                    icon: Icon(Icons.phone),
                                                    label: Text('Call')),
                                                VerticalDivider(
                                                  thickness: 0.3,
                                                  endIndent: 6,
                                                ),
                                                TextButton.icon(
                                                    onPressed: () {
                                                    },
                                                    style: TextButton.styleFrom(foregroundColor: Color(0xffdb3244)),
                                                    icon: Icon(Icons.book),
                                                    label: Text('Book now')),
                                                VerticalDivider(
                                                  thickness: 0.3,
                                                  endIndent: 6,
                                                ),
                                                TextButton.icon(
                                                    onPressed: () {},
                                                    style: TextButton.styleFrom(foregroundColor: Color(0xffdb3244)),
                                                    icon: Icon(Icons.favorite_border),
                                                    label: Text('Save')),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        );
                      }
                    },
                  );
                }).toList(),
              );
            }
          },
        ),
    );

  }
}
