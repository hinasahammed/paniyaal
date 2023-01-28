import 'package:flutter/material.dart';

class PainterScreen extends StatefulWidget {
  const PainterScreen({Key? key}) : super(key: key);

  @override
  State<PainterScreen> createState() => _PainterScreenState();
}

class _PainterScreenState extends State<PainterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('Painter'),
    );
  }
}
