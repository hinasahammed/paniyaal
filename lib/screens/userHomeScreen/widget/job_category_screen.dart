import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:paniyaal/screens/jobTypeScreen/other_screen.dart';
import 'package:paniyaal/screens/userPhoneVerificationScreen/user_phone_verification_screen.dart';
import '../../jobTypeScreen/carpenter_screen.dart';
import '../../jobTypeScreen/cleaning_screen.dart';
import '../../jobTypeScreen/electrician_screen.dart';
import '../../jobTypeScreen/gardening_screen.dart';
import '../../jobTypeScreen/mechanic_screen.dart';
import '../../jobTypeScreen/painter_screen.dart';
import '../../jobTypeScreen/pestcontrol_screen.dart';
import '../../jobTypeScreen/plumber_screen.dart';
import '../../jobTypeScreen/technicrepair_screen.dart';
import '../../jobTypeScreen/woodcutter_screen.dart';

class JobCategoryScreen extends StatefulWidget {
   JobCategoryScreen({Key? key}) : super(key: key);

  @override
  State<JobCategoryScreen> createState() => _JobCategoryScreenState();
}

class _JobCategoryScreenState extends State<JobCategoryScreen> {
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Paniyaal',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xffdb3244),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
              onPressed: () {
              },
              icon: Icon(Icons.favorite,size: 30,),
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
                 const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (ctx)=>CarpenterScreen()));
                        },
                        child: Container(
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
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (ctx)=>PainterScreen()));
                        },
                        child: Container(
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
                      ),
                    ],
                  ),
                 const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (ctx)=>GardeningScreen()));
                        },
                        child: Container(
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
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (ctx)=>CleaningScreen()));
                        },
                        child: Container(
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
                      ),
                    ],
                  ),
                 const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (ctx)=>PlumberScreen()));
                        },
                        child: Container(
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
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (ctx)=>ElectricianScreen()));
                        },
                        child: Container(
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
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (ctx)=>WoodcutterScreen()));
                        },
                        child: Container(
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
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (ctx)=>MechanicScreen()));
                        },
                        child: Container(
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
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (ctx)=>PestcontrolScreen()));
                        },
                        child: Container(
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
                                  'assets/pest.jpg',
                                  fit: BoxFit.contain,
                                ),
                                Text(
                                  'Pest control\nservice',
                                  style: TextStyle(fontWeight: FontWeight.w500),textAlign: TextAlign.center,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (ctx)=>TechnicRepairScreen()));
                        },
                        child: Container(
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
                                  'assets/technic.jpg',
                                  fit: BoxFit.contain,
                                ),
                                const SizedBox(height: 5,),
                                Text(
                                  'Technic repair',
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (ctx)=>OtherScreen()));
                        },
                        child: Container(
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
