import 'package:flutter/material.dart';

import 'bottomNavigation/bottom_navigation.dart';

class UserHomeScreen extends StatelessWidget {
  const UserHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNavigation(),
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
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 155,
                  height: 195,
                  child: Card(
                    elevation: 0,
                    child: Column(
                      children: [
                        Image.asset('assets/Carpenter.png',fit: BoxFit.contain,),
                        Text(
                          'Carpenter',
                          style: TextStyle(fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 155,
                  height: 195,
                  child: Card(
                    elevation: 0,
                    child: Column(
                      children: [
                        Image.asset('assets/painter.png',fit: BoxFit.contain,),
                        Text(
                          'Painter',
                          style: TextStyle(fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 155,
                  height: 195,
                  child: Card(
                    elevation: 0,
                    child: Column(
                      children: [
                        Image.asset('assets/Carpenter.png',fit: BoxFit.contain,),
                        Text(
                          'Carpenter',
                          style: TextStyle(fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 155,
                  height: 195,
                  child: Card(
                    elevation: 0,
                    child: Column(
                      children: [
                        Image.asset('assets/painter.png',fit: BoxFit.contain,),
                        Text(
                          'Painter',
                          style: TextStyle(fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 155,
                  height: 195,
                  child: Card(
                    elevation: 0,
                    child: Column(
                      children: [
                        Image.asset('assets/Carpenter.png',fit: BoxFit.contain,),
                        Text(
                          'Carpenter',
                          style: TextStyle(fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 155,
                  height: 195,
                  child: Card(
                    elevation: 0,
                    child: Column(
                      children: [
                        Image.asset('assets/painter.png',fit: BoxFit.contain,),
                        Text(
                          'Painter',
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
      ),
    );
  }
}
