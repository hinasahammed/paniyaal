import 'package:flutter/material.dart';

class CarpenterScreen extends StatefulWidget {
  const CarpenterScreen({Key? key}) : super(key: key);

  @override
  State<CarpenterScreen> createState() => _CarpenterScreenState();
}

class _CarpenterScreenState extends State<CarpenterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carpenters'),
        centerTitle: true,
      ),
      body: Text('Carpenter'),
    );
  }
}
