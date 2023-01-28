import 'package:flutter/material.dart';

class CleaningScreen extends StatefulWidget {
  const CleaningScreen({Key? key}) : super(key: key);

  @override
  State<CleaningScreen> createState() => _CleaningScreenState();
}

class _CleaningScreenState extends State<CleaningScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('Cleaning'),
    );
  }
}
