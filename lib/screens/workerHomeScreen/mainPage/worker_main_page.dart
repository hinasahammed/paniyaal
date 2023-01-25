import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class WorkerMainPage extends StatelessWidget {
  WorkerMainPage({Key? key}) : super(key: key);
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Workers'),
          centerTitle: true,
          backgroundColor: Color(0xffdb3244),
        ),
        body: ListView.separated(itemBuilder: (ctx, index){
          return Card(
            elevation: 0,
            child: ListTile(
              title: Text('Notificatiion ${index}'),
            ),
          );
        },
          separatorBuilder: (ctx, index){
          return SizedBox(height: 10,);
          },
          itemCount: 10,)
    );

  }
}
