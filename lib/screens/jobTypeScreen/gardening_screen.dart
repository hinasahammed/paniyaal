import 'package:flutter/material.dart';

class GardeningScreen extends StatefulWidget {
  const GardeningScreen({Key? key}) : super(key: key);

  @override
  State<GardeningScreen> createState() => _GardeningScreenState();
}

class _GardeningScreenState extends State<GardeningScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('Gardening'),
    );
  }
}
