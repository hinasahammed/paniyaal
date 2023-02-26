import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:url_launcher/url_launcher.dart';

class WorkerMainPage extends StatelessWidget {
  WorkerMainPage({Key? key}) : super(key: key);
  final auth = FirebaseAuth.instance;
  String userUid= "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Workers'),
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
                              Slidable(
                                startActionPane: ActionPane(
                                  motion: const StretchMotion(),
                                  children: [
                                    SlidableAction(
                                      onPressed: (context) {
                                        userUid =
                                        userDocument['uid'];
                                        completed(userUid);
                                      },
                                      backgroundColor: Colors.green,
                                      icon: Icons.done_all_outlined,
                                      label: 'Completed',
                                    )
                                  ],
                                ),
                                child: Container(
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
                                                      child: CachedNetworkImage(
                                                        imageUrl: userDocument["imageUrl"],
                                                        width: 130,
                                                        height: 130,
                                                        fit: BoxFit.cover,
                                                        placeholder: (context, url) => CircularProgressIndicator(),
                                                        errorWidget: (context, url, error) => Icon(Icons.error),
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
                                                  onPressed: () async{
                                                    final Uri _phoneNumber = Uri.parse(
                                                        'tel:${userDocument["phoneNumber"]}');
                                                    if (await canLaunchUrl(
                                                        _phoneNumber)) {
                                                      launchUrl(_phoneNumber);
                                                    }
                                                  },
                                                  style: TextButton.styleFrom(foregroundColor: Color(0xffdb3244)),
                                                  icon: Icon(Icons.phone_outlined),
                                                  label: Text('Call')),
                                              VerticalDivider(
                                                thickness: 0.3,
                                                endIndent: 6,
                                              ),
                                              TextButton.icon(
                                                  onPressed: () async{
                                                    var url = "https://wa.me/${userDocument["phoneNumber"]}?text=Help?";
                                                    await launch(url);
                                                  },
                                                  style: TextButton.styleFrom(foregroundColor: Color(0xffdb3244)),
                                                  icon: Icon(Icons.message_outlined),
                                                  label: Text('Message')),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
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
  void completed(String uid) async {
    String userUid = auth.currentUser!.uid;
    await FirebaseFirestore.instance
        .collection('UsersLogedin')
        .doc(uid)
        .update({
      auth.currentUser!.uid: FieldValue.delete(),
    });
  }
}
