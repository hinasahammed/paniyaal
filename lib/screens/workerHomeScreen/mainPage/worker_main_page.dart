import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:url_launcher/url_launcher.dart';

class WorkerMainPage extends StatefulWidget {
  const WorkerMainPage({super.key});

  @override
  State<WorkerMainPage> createState() => _WorkerMainPageState();
}

class _WorkerMainPageState extends State<WorkerMainPage> {
  final auth = FirebaseAuth.instance;

  String userUid = "";
  storeNotificationToken() async {
    String? token = await FirebaseMessaging.instance.getToken();

    FirebaseFirestore.instance
        .collection("workersLogedIn")
        .doc(auth.currentUser!.uid)
        .set({'token': token}, SetOptions(merge: true));
  }

  @override
  void initState() {
    super.initState();
    storeNotificationToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Workers'),
        backgroundColor: const Color(0xffdb3244),
        automaticallyImplyLeading: false,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("workersLogedIn")
            .where("uid", isEqualTo: auth.currentUser!.uid)
            .where("status", isEqualTo: "booked")
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator(
              strokeWidth: 3,
              color: Colors.white,
            );
          } else {
            return ListView(
              children: snapshot.data!.docs.map((document) {
                return StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("UsersLogedin")
                      .where(auth.currentUser!.uid, isEqualTo: "booked")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const CircularProgressIndicator(
                        strokeWidth: 3,
                        color: Colors.white,
                      );
                    } else {
                      return Column(
                        children: snapshot.data!.docs.map((userDocument) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12.0,
                            ),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Slidable(
                                  startActionPane: ActionPane(
                                    motion: const StretchMotion(),
                                    children: [
                                      SlidableAction(
                                        onPressed: (context) {
                                          userUid = userDocument['uid'];
                                          completed(userUid);
                                        },
                                        backgroundColor: Colors.green,
                                        icon: Icons.done_all_outlined,
                                        label: 'Completed',
                                      )
                                    ],
                                  ),
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        children: [
                                          IntrinsicHeight(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Column(
                                                  children: [
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Container(
                                                      width: 100,
                                                      height: 100,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            width: 4,
                                                            color:
                                                                Colors.white),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            spreadRadius: 3,
                                                            blurRadius: 10,
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.1),
                                                          ),
                                                        ],
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100),
                                                        child:
                                                            CachedNetworkImage(
                                                          imageUrl:
                                                              userDocument[
                                                                  "imageUrl"],
                                                          width: 130,
                                                          height: 130,
                                                          fit: BoxFit.cover,
                                                          placeholder: (context,
                                                                  url) =>
                                                              const CircularProgressIndicator(),
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              const Icon(
                                                                  Icons.error),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const VerticalDivider(
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
                                                    Text(
                                                        "Name: ${document["fullName"]}"),
                                                    Text(
                                                        "Ph: ${document["phoneNumber"]}"),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          const Divider(
                                            thickness: 0.3,
                                          ),
                                          IntrinsicHeight(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                TextButton.icon(
                                                    onPressed: () async {
                                                      final Uri phoneNumber =
                                                          Uri.parse(
                                                              'tel:${userDocument["phoneNumber"]}');
                                                      if (await canLaunchUrl(
                                                          phoneNumber)) {
                                                        launchUrl(phoneNumber);
                                                      }
                                                    },
                                                    style: TextButton.styleFrom(
                                                        foregroundColor:
                                                            const Color(
                                                                0xffdb3244)),
                                                    icon: const Icon(
                                                        Icons.phone_outlined),
                                                    label: const Text('Call')),
                                                const VerticalDivider(
                                                  thickness: 0.3,
                                                  endIndent: 6,
                                                ),
                                                TextButton.icon(
                                                    onPressed: () async {
                                                      var url =
                                                          "https://wa.me/${userDocument["phoneNumber"]}?text=Help?";
                                                      await canLaunchUrl(
                                                          Uri.parse(url));
                                                    },
                                                    style: TextButton.styleFrom(
                                                        foregroundColor:
                                                            const Color(
                                                                0xffdb3244)),
                                                    icon: const Icon(
                                                        Icons.message_outlined),
                                                    label:
                                                        const Text('Message')),
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
    await FirebaseFirestore.instance
        .collection('UsersLogedin')
        .doc(uid)
        .update({
      auth.currentUser!.uid: FieldValue.delete(),
    });
  }
}
