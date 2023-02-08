import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:paniyaal/screens/userHomeScreen/user_home_screen.dart';

class UserDetailEditingScreen extends StatefulWidget {
  UserDetailEditingScreen({Key? key}) : super(key: key);

  @override
  State<UserDetailEditingScreen> createState() =>
      _UserDetailEditingScreenState();
}

class _UserDetailEditingScreenState extends State<UserDetailEditingScreen> {
  final fullNameEditingController = TextEditingController();
  final phoneEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final auth = FirebaseAuth.instance;
  final countryCode = "+91";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit profile'),
        backgroundColor: Color(0xffdb3244),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 15, top: 20, right: 15),
          child: Form(
            key: _formKey,
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/edit_your_detail.png",
                    fit: BoxFit.contain,
                    width: 250,
                    height: 250,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: fullNameEditingController,
                          autofocus: false,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            RegExp regex = new RegExp(r'^.{3,}$');
                            if (value!.isEmpty) {
                              return ("Name cannot be Empty");
                            }
                            if (!regex.hasMatch(value)) {
                              return ("Enter Valid name(Min. 3 Character)");
                            }
                            return null;
                          },
                          onSaved: (value) {
                            fullNameEditingController.text = value!;
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                            hintText: "Full name",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
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
                      Expanded(
                        child: TextFormField(
                          controller: phoneEditingController,
                          autofocus: false,
                          keyboardType: TextInputType.phone,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a phone number';
                            } else if (!RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)')
                                .hasMatch(value)) {
                              return "Please enter a valid phone number";
                            }
                          },
                          onSaved: (value) {
                            phoneEditingController.text = value!;
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                            hintText: "Phone number",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ],
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
                          updateData();
                          Fluttertoast.showToast(msg: 'Updated');
                        } catch (error) {
                          Fluttertoast.showToast(msg: error.toString());
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xffdb3244),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                      child: const Text('Save'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  updateData() async {
    await FirebaseFirestore.instance
        .collection('UsersLogedin')
        .doc(auth.currentUser!.uid)
        .update({
      "fullName": fullNameEditingController.text,
      "phoneNumber": countryCode + phoneEditingController.text,
    });
    Fluttertoast.showToast(msg: "Saved your data :) ");

    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => UserHomeScreen()),
        (route) => false);
  }
}
