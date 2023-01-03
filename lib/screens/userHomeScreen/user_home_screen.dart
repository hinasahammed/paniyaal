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
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Paniyaal'),
        ),
        backgroundColor: Color(0xffdb3244),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.favorite),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 20,
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
                            Image.asset(
                              'assets/Carpenter.png',
                              fit: BoxFit.contain,
                            ),
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
                            Image.asset(
                              'assets/painter.png',
                              fit: BoxFit.contain,
                            ),
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
                SizedBox(
                  height: 20,
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
                            Image.asset(
                              'assets/gardening.jpg',
                              fit: BoxFit.contain,
                            ),
                            Text(
                              'Gardgening',
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
                            Image.asset(
                              'assets/cleaning.jpg',
                              fit: BoxFit.contain,
                            ),
                            Text(
                              'Cleaning',
                              style: TextStyle(fontWeight: FontWeight.w400),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
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
                            Image.asset(
                              'assets/plumber.jpg',
                              fit: BoxFit.contain,
                            ),
                            Text(
                              'Plumbing',
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
                            Image.asset(
                              'assets/electrician.jpg',
                              fit: BoxFit.contain,
                            ),
                            Text(
                              'Electrician',
                              style: TextStyle(fontWeight: FontWeight.w400),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Container(
                        width: 155,
                        height: 195,
                        child: Card(
                          elevation: 0,
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/other service.jpg',
                                fit: BoxFit.contain,
                              ),
                              Text(
                                'Other home\nservice',
                                style: TextStyle(fontWeight: FontWeight.w400),
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
