import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

import '../../service/localpush_notification.dart';

class ElectricianScreen extends StatefulWidget {
  const ElectricianScreen({Key? key}) : super(key: key);

  @override
  State<ElectricianScreen> createState() => _ElectricianScreenState();
}

class _ElectricianScreenState extends State<ElectricianScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseMessaging.instance.getInitialMessage();
    FirebaseMessaging.onMessage.listen((event) {
      LocalNotificationService.display(event);
    });
    // storeNotificationToken();
  }

  final auth = FirebaseAuth.instance;
  final _screenName = "Electrician";
  String? token;
  String workerUid = "";
  bool? isFavourite = false;
  String fav = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffdb3244),
        elevation: 0,
        title: Text('Carpenters'),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("workersLogedIn")
            .where("jobType", isEqualTo: _screenName)
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
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
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
                                            child: CachedNetworkImage(
                                              imageUrl: document["imageUrl"],
                                              width: 130,
                                              height: 130,
                                              fit: BoxFit.cover,
                                              placeholder: (context, url) =>
                                                  CircularProgressIndicator(),
                                              errorWidget: (context, url,
                                                  error) => Icon(Icons.error),
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
                                        Text("Name: " + document["fullName"]),
                                        Text("Ph: " + document["phoneNumber"]),
                                        Text(document["jobType"]),
                                        Text(document["location"]),
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
                                        onPressed: () async {
                                          final Uri _phoneNumber = Uri.parse(
                                              'tel:${document["phoneNumber"]}');
                                          if (await canLaunchUrl(
                                              _phoneNumber)) {
                                            launchUrl(_phoneNumber);
                                          }
                                        },
                                        style: TextButton.styleFrom(
                                            foregroundColor: Color(0xffdb3244)),
                                        icon: Icon(Icons.phone),
                                        label: Text('Call')),
                                    VerticalDivider(
                                      thickness: 0.3,
                                      endIndent: 6,
                                    ),
                                    TextButton.icon(
                                        onPressed: () {
                                          workerUid = document['uid'];
                                          token = document['token'];
                                          updateBookedWorkerFirebase(workerUid);
                                          updateBookStatusFirebase(workerUid);
                                          sendNotification('New Booking', token!);
                                        },
                                        style: TextButton.styleFrom(
                                            foregroundColor: Color(0xffdb3244)),
                                        icon: Icon(Icons.book),
                                        label: Text('Book now')),
                                    VerticalDivider(
                                      thickness: 0.3,
                                      endIndent: 6,
                                    ),
                                    TextButton.icon(
                                        onPressed: () async {
                                          workerUid = document['uid'];
                                          _toggleFavorite();
                                          isFavourite!
                                              ? updateIsFavouritedFirebase(
                                              workerUid)
                                              : deleteIsNotFavouritedFirebase(
                                              workerUid);
                                        },
                                        style: TextButton.styleFrom(
                                            foregroundColor: Color(0xffdb3244)),
                                        icon: (isFavourite! &&
                                            workerUid == document['uid']
                                            ? Icon(Icons.favorite)
                                            : Icon(Icons.favorite_border)),
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
      ),
    );
  }

  void updateBookedWorkerFirebase(String uid) async {
    await FirebaseFirestore.instance
        .collection('workersLogedIn')
        .doc(uid)
        .update({
      'status': 'booked',
      auth.currentUser!.uid: 'booked',
    });
    Fluttertoast.showToast(msg: "Booked :)");
  }

  void updateBookStatusFirebase(String uid) async {
    await FirebaseFirestore.instance
        .collection('UsersLogedin')
        .doc(auth.currentUser!.uid)
        .update({
      uid: "booked",
    });
  }

  void _toggleFavorite() {
    setState(() {
      isFavourite = !isFavourite!;
    });
  }

  void updateIsFavouritedFirebase(String uid) async {
    String userUid = auth.currentUser!.uid;
    await FirebaseFirestore.instance
        .collection('workersLogedIn')
        .doc(uid)
        .update({
      userUid: 'favourited',
    });
  }

  void deleteIsNotFavouritedFirebase(String uid) async {
    String userUid = auth.currentUser!.uid;
    await FirebaseFirestore.instance
        .collection('workersLogedIn')
        .doc(uid)
        .update({
      userUid: FieldValue.delete(),
    });
  }

  isAlreadyFavouritedInFirebase(String favourited) {
    if (favourited != null) {
      print("have");
      setState(() {
        isFavourite == true;
      });
    } else {
      print("null");
      setState(() {
        isFavourite = false;
      });
    }
  }


  sendNotification(String title, String token) async{
    final data = {
      'click_action': 'FLUTTER_NOTIFICATION_CLICK',
      'id': '1',
      'status': 'done',
      'message': title,
    };

    try {
      http.Response response = await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': 'key=AAAA-CsTEzc:APA91bFICujld27e_WSaDDdwCW3TG9DkcwuGsiBORTJQZFvK4o_Jxd_C1IZw4161l_Cqb1_QNX3WULHdxCnKP-QzXCIvEYxJ9LLaBz3zNhaVkcsAhTtxUkjL3PaRaPIs31qws3jq7V4X'
          },
          body: jsonEncode(<String,dynamic>{
            'notification': <String,dynamic> {'title': title,'body': 'You have a new booking!'},
            'priority': 'high',
            'data': data,
            'to': '$token'
          })
      );

      if(response.statusCode == 200){
        print("Yeh notificatin is sended");
      }else{
        print("Error");
      }

    } catch (e) {}
  }
}
