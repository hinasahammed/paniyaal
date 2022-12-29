import 'package:flutter/material.dart';

class UserHomeScreen extends StatelessWidget {
  const UserHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE7EFFA),
      appBar: AppBar(
        title: Text('Paniyaal'),
        backgroundColor: Color(0xffdb3244),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.favorite),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Row(
            children: [
              Container(
                width: 182,
                height: 207,
                child: Card(
                  child: Column(
                    children: [
                      Text(
                        'Carpenter',
                        style: TextStyle(fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
