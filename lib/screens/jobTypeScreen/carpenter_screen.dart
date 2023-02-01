import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CarpenterScreen extends StatefulWidget {
  const CarpenterScreen({Key? key}) : super(key: key);

  @override
  State<CarpenterScreen> createState() => _CarpenterScreenState();
}

class _CarpenterScreenState extends State<CarpenterScreen> {
  final auth = FirebaseAuth.instance;
  final _screenName = "Carpenter";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffdb3244),
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
            return Column(
              children: snapshot.data!.docs.map((document) {
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
                                        onPressed: () async{
                                          final Uri _phoneNumber = Uri.parse('tel:${document["phoneNumber"]}');
                                          if(await canLaunchUrl(_phoneNumber)){
                                            launchUrl(_phoneNumber);
                                          }
                                        },
                                        style: TextButton.styleFrom(foregroundColor: Color(0xffdb3244)),
                                        icon: Icon(Icons.phone),
                                        label: Text('Call')),
                                    VerticalDivider(
                                      thickness: 0.3,
                                      endIndent: 6,
                                    ),
                                    TextButton.icon(
                                        onPressed: () {},
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
      ),
    );
  }
}
