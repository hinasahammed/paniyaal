import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:paniyaal/screens/userDetailScreen/user_detail_screen.dart';
import 'package:paniyaal/screens/userHomeScreen/user_home_screen.dart';
import 'package:paniyaal/screens/userPhoneVerificationScreen/user_phone_verification_screen.dart';
import 'package:pinput/pinput.dart';

class OtpVerificationScreen extends StatefulWidget {
  OtpVerificationScreen({Key? key}) : super(key: key);

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    var smsCode = "";
    return Scaffold(
      backgroundColor: Colors.grey[100],
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: const Color(0xffdb3244),
            size: 30,
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
            Pinput(
              length: 6,
              showCursor: true,
              onChanged: (value) {
                smsCode = value;
              },
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 45,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  try {
                    PhoneAuthCredential credential =
                        PhoneAuthProvider.credential(
                            verificationId: UserLoginScreen.verify,
                            smsCode: smsCode);

                    // Sign the user in (or link) with the credential
                    await auth.signInWithCredential(credential);
                    isDocumentExist(context);
                  } catch (e) {
                    print("Wrong otp");
                  }
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffdb3244),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
                child: const Text('Verify phone number'),
              ),
            ),
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Edit phone number ?',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ],
        )),
      ),
    );
  }
}

Future isDocumentExist(BuildContext context) async {
  final auth = FirebaseAuth.instance;
  DocumentSnapshot<Map<String, dynamic>> document = await FirebaseFirestore
      .instance
      .collection("UsersLogedin")
      .doc(auth.currentUser!.uid)
      .get();
  if (document.exists) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (ctx) => UserHomeScreen()));
  } else {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (ctx) => UserDetailScreen()));
  }
}
