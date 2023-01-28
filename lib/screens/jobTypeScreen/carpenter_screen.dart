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
              .where("JobType", isEqualTo: _screenName)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator(strokeWidth: 3,color: Colors.white,);
            } else {
              return Column(
                children: snapshot.data!.docs.map((document) {
                  return Column(
                    children: [

                    ],
                  );
                }).toList(),
              );
            }
          },
        ),
    );
    }
  }
