import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

class OtherScreen extends StatefulWidget {
  const OtherScreen({Key? key}) : super(key: key);

  @override
  State<OtherScreen> createState() => _OtherScreenState();
}

class _OtherScreenState extends State<OtherScreen> {

  final auth = FirebaseAuth.instance;
  final _screenName = "Carpenter";
  String workerUid = "";
  bool? isFavourite = false;
  String fav = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffdb3244),
        title: Text('Other jobs'),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("workersLogedIn")
            .where("jobTypeOther", isGreaterThan: "")
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
                                            child: Image.network(
                                              document["imageUrl"],
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
                                          updateBookedWorkerFirebase(workerUid);
                                          updateBookStatusFirebase(workerUid);
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
                                              ? updateIsFavouritedFirebase(workerUid)
                                              : deleteIsNotFavouritedFirebase(workerUid);
                                        },
                                        style: TextButton.styleFrom(
                                            foregroundColor: Color(0xffdb3244)),
                                        icon: (isFavourite! && workerUid == document['uid']
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

  isAlreadyFavouritedInFirebase(String favourited){
    if(favourited!=null){
      print("have");
      setState(() {
        isFavourite == true;
      });
    }else{
      print("null");
      setState(() {
        isFavourite=false;
      });
    }
  }
}
