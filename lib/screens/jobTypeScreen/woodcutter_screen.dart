import 'package:flutter/material.dart';

class WoodcutterScreen extends StatefulWidget {
  const WoodcutterScreen({Key? key}) : super(key: key);

  @override
  State<WoodcutterScreen> createState() => _WoodcutterScreenState();
}

class _WoodcutterScreenState extends State<WoodcutterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('Carpenter'),
    );
  }
}
