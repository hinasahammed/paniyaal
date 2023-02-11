import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:paniyaal/screens/userHomeScreen/user_home_screen.dart';

import '../../model/user_logedin_model.dart';

class UserDetailScreen extends StatefulWidget {
  const UserDetailScreen({Key? key}) : super(key: key);

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  final _formKey = GlobalKey<FormState>();
  final fullNameEditingController = TextEditingController();
  File? _image;
  final picker = ImagePicker();
  String? downloadUrl;


  @override
  void dispose() {
    fullNameEditingController.dispose();
    // TODO: implement dispose
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
            child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                height: 30,
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
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 45,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    final name = fullNameEditingController.text;
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
                    postDetailsToFirestore();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (ctx) => UserHomeScreen()),
                        (route) => false);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffdb3244),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                  child: const Text('Save'),
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        )),
      ),
    );
  }

  postDetailsToFirestore() async {
    // calling our firestore
    // calling our user model
    // sedning these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    final _auth = FirebaseAuth.instance;
    User? user = _auth.currentUser;
    UserLogedinModel userModel = UserLogedinModel();

    // writing all the values
    userModel.uid = user!.uid;
    userModel.imageUrl = downloadUrl;
    userModel.fullName = fullNameEditingController.text;
    userModel.phoneNumber = user.phoneNumber;

    await firebaseFirestore
        .collection("UsersLogedin")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account Created :)");
  }
  Future getGallaryImage() async {
    final pickedFile =
    await picker.pickImage(source: ImageSource.gallery, imageQuality: 5);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      setState(() {
        _image;
      });
    }
  }
}
