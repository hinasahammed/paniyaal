import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
              return CircularProgressIndicator(strokeWidth: 3,color: Colors.white,);
            } else {
              return Column(
                children: snapshot.data!.docs.map((document) {
                  return Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                      Container(
                      width: double.infinity,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.network(
                                  document["imageUrl"],
                                  fit: BoxFit.contain,
                                  height: 140,
                                ),
                                Text(
                                    document["fullName"]
                                )
                              ],
                            ),
                            Divider(thickness: 2,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                              IconButton(onPressed: (){}, icon: Icon(Icons.phone),),
                              VerticalDivider(color: Colors.black,
                                thickness: 2,),
                              IconButton(onPressed: (){}, icon: Icon(Icons.book_online),),
                            ],),
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
