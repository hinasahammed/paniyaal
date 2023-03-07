import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../worker_home_screen.dart';

class WorkerDetailScreen extends StatefulWidget {
  WorkerDetailScreen({Key? key}) : super(key: key);

  @override
  State<WorkerDetailScreen> createState() => _WorkerDetailScreenState();
}

class _WorkerDetailScreenState extends State<WorkerDetailScreen> {
  final fullNameEditingController = TextEditingController();
  final phoneEditingController = TextEditingController();
  final emailEditingController = TextEditingController();
  final locationEditingController = TextEditingController();
  final otherJobTypeEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  FirebaseStorage storage = FirebaseStorage.instance;

  static File? _image;
  final auth = FirebaseAuth.instance;
  final picker = ImagePicker();
  final _jobTypeList = [
    "Carpenter",
    "Painter",
    "Gardening",
    "Cleaning",
    "Plumber",
    "Electrician",
    "Woodcutter",
    "Mechanic",
    "Pest Controller",
    "Technic repair",
    "Other",
  ];
  String? _selectedVal = "Carpenter";
  final countryCode = "+91";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
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
                          controller: emailEditingController,
                          autofocus: false,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ("Please Enter Your Email");
                            }
                            // reg expression for email validation
                            if (!RegExp(
                                    "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                .hasMatch(value)) {
                              return ("Please Enter a valid email");
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                            hintText: "Email",
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
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: locationEditingController,
                          autofocus: false,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                            hintText: "Location",
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
                  DropdownButtonFormField(
                      icon: const Icon(
                        Icons.arrow_drop_down_circle,
                        color: Color(0xffdb3244),
                      ),
                      decoration: InputDecoration(
                        labelText: "Job type",
                        prefixIcon: Icon(Icons.work),
                        border: OutlineInputBorder(),
                      ),
                      value: _selectedVal,
                      items: _jobTypeList.map((e) {
                        return DropdownMenuItem(
                          child: Text(e),
                          value: e,
                        );
                      }).toList(),
                      onChanged: (val) {
                        setState(() {
                          _selectedVal = val;
                        });
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  if (_selectedVal == "Other")
                    Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: otherJobTypeEditingController,
                                autofocus: false,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.fromLTRB(20, 15, 20, 15),
                                  hintText: "Job name",
                                  prefixIcon: Icon(Icons.work),
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
                        )
                      ],
                    ),
                  SizedBox(
                    height: 45,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        try {
                          updateData();
                          Fluttertoast.showToast(msg: 'Uploaded');
                        } catch (error) {
                          Fluttertoast.showToast(
                              msg: 'You have to choose an image');
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

  Future getGallaryImage() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      setState(() {
        _image;
      });
    }
  }

  updateData() async {
    await FirebaseFirestore.instance
        .collection('workersLogedIn')
        .doc(auth.currentUser!.uid)
        .update({
      "fullName": fullNameEditingController.text,
      "email": emailEditingController.text,
      "phoneNumber": countryCode + phoneEditingController.text,
      "location": locationEditingController.text,
      "jobType": _selectedVal == "Other"
          ? otherJobTypeEditingController.text
          : _selectedVal,
      "jobTypeOther":_selectedVal == "Other"
          ? otherJobTypeEditingController.text
          : _selectedVal,
    });
    Fluttertoast.showToast(msg: "Saved your data :)");

    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => WorkerHomeScreen()),
        (route) => false);
  }
}
