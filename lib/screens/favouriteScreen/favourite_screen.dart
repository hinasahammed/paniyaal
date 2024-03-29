import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  final auth = FirebaseAuth.instance;
  String workerUid = "";
  bool? isFavourite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favourites'),
        elevation: 0,
        backgroundColor: const Color(0xffdb3244),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("UsersLogedin")
            .where("uid", isEqualTo: auth.currentUser!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator(
              strokeWidth: 3,
              color: Colors.white,
            );
          } else {
            return ListView(
              children: snapshot.data!.docs.map((userDocument) {
                return StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("workersLogedIn")
                      .where(auth.currentUser!.uid, isEqualTo: "favourited")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: Text('No Favourite item is here'),
                      );
                    } else {
                      return Column(
                        children: snapshot.data!.docs.map((workerDocument) {
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
                                          workerUid = workerDocument['uid'];
                                          removeFavourite(workerUid);
                                        },
                                        backgroundColor: Colors.red,
                                        icon: Icons.delete,
                                        label: 'Delete',
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
                                                              workerDocument[
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
                                                    Text("Name:  ${workerDocument[
                                                            "fullName"]}"
                                                        ),
                                                    Text("Ph: ${workerDocument[
                                                            "phoneNumber"]}"
                                                       ),
                                                    Text(workerDocument[
                                                        "jobType"]),
                                                    Text(workerDocument[
                                                        "location"]),
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
                                                              'tel:${workerDocument["phoneNumber"]}');
                                                      if (await canLaunchUrl(
                                                          phoneNumber)) {
                                                        launchUrl(phoneNumber);
                                                      }
                                                    },
                                                    style: TextButton.styleFrom(
                                                        foregroundColor:
                                                            const Color(
                                                                0xffdb3244)),
                                                    icon:
                                                        const Icon(Icons.phone),
                                                    label: const Text('Call')),
                                                const VerticalDivider(
                                                  thickness: 0.3,
                                                  endIndent: 6,
                                                ),
                                                TextButton.icon(
                                                    onPressed: () {
                                                      workerUid =
                                                          workerDocument['uid'];
                                                      bookWorker(workerUid);
                                                      bookStatus(workerUid);
                                                    },
                                                    style: TextButton.styleFrom(
                                                        foregroundColor:
                                                            const Color(
                                                                0xffdb3244)),
                                                    icon:
                                                        const Icon(Icons.book),
                                                    label:
                                                        const Text('Book now')),
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

  void bookWorker(String uid) async {
    await FirebaseFirestore.instance
        .collection('workersLogedIn')
        .doc(uid)
        .update({
      'status': 'booked',
    });
    Fluttertoast.showToast(msg: "Booked :)");
  }

  void bookStatus(String uid) async {
    await FirebaseFirestore.instance
        .collection('UsersLogedin')
        .doc(auth.currentUser!.uid)
        .update({
      uid: "booked",
    });
  }

  void isFavourited(String uid) async {
    String userUid = auth.currentUser!.uid;
    await FirebaseFirestore.instance
        .collection('workersLogedIn')
        .doc(uid)
        .update({
      userUid: 'favourited',
    });
  }

  void removeFavourite(String uid) async {
    String userUid = auth.currentUser!.uid;
    await FirebaseFirestore.instance
        .collection('workersLogedIn')
        .doc(uid)
        .update({
      userUid: FieldValue.delete(),
    });
  }
}
