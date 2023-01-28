import 'package:flutter/material.dart';

class PlumberScreen extends StatefulWidget {
  const PlumberScreen({Key? key}) : super(key: key);

  @override
  State<PlumberScreen> createState() => _PlumberScreenState();
}

class _PlumberScreenState extends State<PlumberScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('Plumber'),
    );
  }
}
