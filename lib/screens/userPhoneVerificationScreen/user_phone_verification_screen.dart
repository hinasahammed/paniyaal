import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:paniyaal/screens/userHomeScreen/user_home_screen.dart';

import '../../model/user_logedin_model.dart';
import '../typeSelectorScreen/type_selector_screen.dart';


class UserLoginScreen extends StatefulWidget {
  UserLoginScreen({super.key});

  static String verify = "";


  @override
  State<UserLoginScreen> createState() => _UserLoginScreenState();
}

class _UserLoginScreenState extends State<UserLoginScreen> {
  TextEditingController countryCode = TextEditingController();
  var phone = "";
  final fullNameEditingController = TextEditingController();
  final phoneEditingController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    countryCode.text = " +91";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (ctx) => TypeSelectorScreen()), (
                    route) => false);
          },
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/verification.png',
                  width: 200,
                  height: 200,
                ),
                SizedBox(
                  height: 25,
                ),
                const Text(
                  'Phone Verification',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'We need to register your phone before getting started !',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  height: 55,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 40,
                        child: TextFormField(
                          controller: countryCode,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      Text(
                        '|',
                        style: TextStyle(fontSize: 33, color: Colors.grey),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: TextFormField(
                          controller: phoneEditingController,
                          onChanged: (value) {
                            phone = value;
                          },
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Phone",
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 45,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      await FirebaseAuth.instance.verifyPhoneNumber(
                        phoneNumber: '${countryCode.text + phone}',
                        verificationCompleted: (
                            PhoneAuthCredential credential) {},
                        verificationFailed: (FirebaseAuthException e) {},
                        codeSent: (String verificationId, int? resendToken) {
                          UserLoginScreen.verify = verificationId;
                          Navigator.of(context).pushNamed('otpVerification');
                        },
                        codeAutoRetrievalTimeout: (String verificationId) {},
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffdb3244),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                    child: const Text('Send the code'),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
