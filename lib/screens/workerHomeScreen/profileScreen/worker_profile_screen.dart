import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../typeSelectorScreen/type_selector_screen.dart';
import '../../workerLoginScreen/worker_login_screen.dart';
import '../editYourDetailsScreen/worker_detail_editing_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        body: SafeArea(
          child: ListView(
            children: [
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("workersLogedIn")
                    .where("uid", isEqualTo: auth.currentUser!.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const CircularProgressIndicator(
                      strokeWidth: 3,
                      color: Colors.white,
                    );
                  } else {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: snapshot.data!.docs.map((document) {
                        return Column(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(50),
                                    bottomRight: Radius.circular(50)),
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
                                    const Text(
                                      'Profile',
                                      style: TextStyle(
                                          fontSize: 22,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(
                                      height: 25,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          children: [
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Container(
                                              width: 60,
                                              height: 60,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 1,
                                                    color: Colors.black),
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
                                                  imageUrl:
                                                      document["imageUrl"],
                                                  width: 60,
                                                  height: 60,
                                                  fit: BoxFit.cover,
                                                  placeholder: (context, url) =>
                                                      const CircularProgressIndicator(
                                                    color: Colors.black,
                                                  ),
                                                  errorWidget: (context, url,
                                                          error) =>
                                                      const Icon(Icons.error),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            const Text(
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
                                              style: const TextStyle(
                                                  fontSize: 22,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Text(
                                              document['email'],
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            Text(
                                              document['phoneNumber'],
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            Card(
                              elevation: 0,
                              child: ListTile(
                                onTap: () {
                                  auth.signOut().then((value) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (ctx) =>
                                                TypeSelectorScreen()));
                                  }).onError((error, stackTrace) {
                                    Fluttertoast.showToast(
                                        msg: error!.toString());
                                  });
                                },
                                title: const Text('Login as User'),
                                leading: const Icon(Icons.login_outlined),
                                trailing: const Icon(Icons.chevron_right),
                              ),
                            ),
                            Card(
                              elevation: 0,
                              child: ListTile(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (ctx) =>
                                              const WorkerDetailScreen()));
                                },
                                title: const Text('Edit your details'),
                                leading: const Icon(Icons.edit_outlined),
                                trailing: const Icon(Icons.chevron_right),
                              ),
                            ),
                            Card(
                              elevation: 0,
                              child: ListTile(
                                onTap: () async {
                                  launchWhatsapp();
                                },
                                title: const Text('Need Help?'),
                                leading:
                                    const Icon(Icons.help_outline_outlined),
                                trailing: const Icon(Icons.chevron_right),
                              ),
                            ),
                            Card(
                              elevation: 0,
                              child: ListTile(
                                onTap: () {
                                  auth.signOut().then((value) {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (ctx) =>
                                                const WorkerLoginScreen()));
                                  }).onError((error, stackTrace) {
                                    Fluttertoast.showToast(
                                        msg: error!.toString());
                                  });
                                },
                                title: const Text(
                                  'Logout',
                                  style: TextStyle(
                                    color: Colors.red,
                                  ),
                                ),
                                leading: const Icon(
                                  Icons.logout,
                                  color: Colors.red,
                                ),
                                trailing: const Icon(
                                  Icons.chevron_right,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    );
                  }
                },
              ),
            ],
          ),
        ));
  }

  void launchWhatsapp() async {
    var url = "https://wa.me/+917293222211?text=Help?";
    await canLaunchUrl(Uri.parse(url));
  }
}
