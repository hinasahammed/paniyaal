import 'package:flutter/material.dart';

class JobCategoryScreen extends StatelessWidget {
  const JobCategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Paniyaal',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Color(0xffdb3244),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.favorite),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15.0),
          child: ListView(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 155,
                        height: 195,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                               Image.asset(
                                'assets/Carpenter.png',
                                fit: BoxFit.contain,
                              ),
                              Text(
                                'Carpenter',
                                style: TextStyle(fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 155,
                        height: 195,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset(
                                'assets/painter.png',
                                fit: BoxFit.contain,
                              ),
                              Text(
                                'Painter',
                                style: TextStyle(fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 155,
                        height: 195,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset(
                                'assets/gardening.jpg',
                                fit: BoxFit.contain,
                              ),
                              Text(
                                'Gardening',
                                style: TextStyle(fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 155,
                        height: 195,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset(
                                'assets/cleaning.jpg',
                                fit: BoxFit.contain,
                              ),
                              Text(
                                'Cleaning',
                                style: TextStyle(fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 155,
                        height: 195,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset(
                                'assets/plumber.jpg',
                                fit: BoxFit.contain,
                              ),
                              Text(
                                'Plumber',
                                style: TextStyle(fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 155,
                        height: 195,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset(
                                'assets/electrician.jpg',
                                fit: BoxFit.contain,
                              ),
                              Text(
                                'Electrician',
                                style: TextStyle(fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 155,
                        height: 195,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset(
                                'assets/woodcutter.jpg',
                                fit: BoxFit.contain,
                              ),
                              Text(
                                'Wood cutter',
                                style: TextStyle(fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 155,
                        height: 195,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset(
                                'assets/mechanic.jpg',
                                fit: BoxFit.contain,
                              ),
                              Text(
                                'Mechanic',
                                style: TextStyle(fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Container(
                        width: 155,
                        height: 195,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset(
                                'assets/other service.jpg',
                                fit: BoxFit.contain,
                                height: 140,
                              ),
                              Text(
                                'Other\nservices',
                                style: TextStyle(fontWeight: FontWeight.w500),
                                textAlign: TextAlign.center,
                              )
                            ],
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
      ),
    );
  }
}
