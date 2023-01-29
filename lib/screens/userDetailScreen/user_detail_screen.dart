import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
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
              Image.asset(
                'assets/login.png',
                width: 200,
                height: 200,
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
    userModel.fullName = fullNameEditingController.text;
    userModel.phoneNumber = user.phoneNumber;

    await firebaseFirestore
        .collection("UsersLogedin")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Saved");
  }

}
