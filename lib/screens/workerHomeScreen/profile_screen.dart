import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Color(0xffdb3244),
        centerTitle: true ,
      ),
      body: Center(
        child: Text('Profile screen'),
      ),
    );
  }
}
