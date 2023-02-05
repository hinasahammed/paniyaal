import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:paniyaal/screens/workerHomeScreen/worker_home_screen.dart';

import '../../model/worker_logedin_model.dart';

class WorkerSignupScreen extends StatefulWidget {
  const WorkerSignupScreen({Key? key}) : super(key: key);

  @override
  State<WorkerSignupScreen> createState() => _WorkerSignupScreenState();
}

class _WorkerSignupScreenState extends State<WorkerSignupScreen> {

  final _auth = FirebaseAuth.instance;

  // string for displaying the error Message
  String? errorMessage;
  final _formKey = GlobalKey<FormState>();

  final fullNameEditingController = TextEditingController();
  final emailEditingController = TextEditingController();
  final phoneEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();
  final confirmPasswordEditingController = TextEditingController();
  final locationEditingController = TextEditingController();
  File? _image;

  final picker = ImagePicker();
  String? downloadUrl;
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
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: ListView(
          children: [
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Create your account',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Center(
                    child: Stack(
                      children: [
                        Container(
                          width: 130,
                          height: 130,
                          decoration: BoxDecoration(
                            border: Border.all(width: 4, color: Colors.white),
                            boxShadow: [
                              BoxShadow(
                                spreadRadius: 3,
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.1),
                              ),
                            ],
                            shape: BoxShape.circle,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: _image != null
                                ? Image.file(
                                    _image!.absolute,
                                    width: 130,
                                    height: 130,
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset(
                                    'assets/upload.png',
                                    width: 130,
                                    height: 130,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: InkWell(
                            onTap: () {
                              getGallaryImage();
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(width: 4, color: Colors.white),
                                shape: BoxShape.circle,
                                color: Colors.blue,
                              ),
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          autofocus: false,
                          controller: fullNameEditingController,
                          keyboardType: TextInputType.name,
                          onSaved: (value) {
                            fullNameEditingController.text = value!;
                          },
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
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.account_circle),
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
                            prefixIcon: Icon(Icons.contact_phone),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          autofocus: false,
                          controller: emailEditingController,
                          onSaved: (value) {
                            emailEditingController.text = value!;
                          },
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
                            prefixIcon: Icon(Icons.mail),
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
                          autofocus: false,
                          controller: passwordEditingController,
                          obscureText: true,
                          validator: (value) {
                            RegExp regex = new RegExp(r'^.{6,}$');
                            if (value!.isEmpty) {
                              return ("Password is required for login");
                            }
                            if (!regex.hasMatch(value)) {
                              return ("Enter Valid Password(Min. 6 Character)");
                            }
                          },
                          onSaved: (value) {
                            passwordEditingController.text = value!;
                          },
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.vpn_key),
                            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                            hintText: "Password",
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
                          autofocus: false,
                          controller: confirmPasswordEditingController,
                          obscureText: true,
                          validator: (value) {
                            if (confirmPasswordEditingController.text !=
                                passwordEditingController.text) {
                              return "Password don't match";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            confirmPasswordEditingController.text = value!;
                          },
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.vpn_key),
                            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                            hintText: "Confirm password",
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
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: locationEditingController,
                          autofocus: false,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                            hintText: "Location",
                            prefixIcon: Icon(Icons.location_on),
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
                        final name = fullNameEditingController.text;
                        FirebaseFirestore firebaseFirestore =
                            FirebaseFirestore.instance;
                        Reference referenceRoot =
                            FirebaseStorage.instance.ref();
                        Reference referenceDirImages =
                            referenceRoot.child('WorkersProfile');
                        Reference referenceImageToUpload =
                            referenceDirImages.child('{$name}' +
                                DateTime.now()
                                    .millisecondsSinceEpoch
                                    .toString());
                        try {
                          await referenceImageToUpload
                              .putFile(_image!.absolute);
                          downloadUrl =
                              await referenceImageToUpload.getDownloadURL();
                        } catch (error) {
                          Fluttertoast.showToast(
                              msg: 'You have to choose an image');
                        }
                        signUp(emailEditingController.text,
                            passwordEditingController.text);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xffdb3244),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                      child: const Text('Sign Up'),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        "Already have an account ?",
                        style: TextStyle(color: Colors.black),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(color: Color(0xffdb3244)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

//Signup function
  void signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) => {postDetailsToFirestore()})
            .catchError((e) {
          Fluttertoast.showToast(msg: e!.message);
        });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";
            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
        Fluttertoast.showToast(msg: errorMessage!);
        print(error.code);
      }
    }
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

  postDetailsToFirestore() async {
    // calling our firestore
    // calling our user model
    // sedning these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? worker = _auth.currentUser;

    WorkerLogedinModel workerModel = WorkerLogedinModel();

    // writing all the values
    workerModel.email = worker!.email;
    workerModel.uid = worker.uid;
    workerModel.fullName = fullNameEditingController.text;
    workerModel.password = passwordEditingController.text;
    workerModel.phoneNumber = countryCode+phoneEditingController.text;
    workerModel.imageUrl = downloadUrl;
    workerModel.jobType = _selectedVal;
    workerModel.location = locationEditingController.text;

    await firebaseFirestore
        .collection("workersLogedIn")
        .doc(worker.uid)
        .set(workerModel.toMap());
    Fluttertoast.showToast(msg: "Account created successfully :) ");

    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => WorkerHomeScreen()),
        (route) => false);
  }
}
