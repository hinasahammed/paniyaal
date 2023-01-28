import 'package:flutter/material.dart';

class MechanicScreen extends StatefulWidget {
  const MechanicScreen({Key? key}) : super(key: key);

  @override
  State<MechanicScreen> createState() => _MechanicScreenState();
}

class _MechanicScreenState extends State<MechanicScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('Mechanic'),
    );
  }
}
