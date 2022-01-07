import 'package:college_planner_app/pages/setup_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';


final _firestore = FirebaseFirestore.instance;
late User loggedInUser;

mixin InputValidationMixin {
  bool validateName(String value) {
    String pattern = r'(^[a-zA-Z ]*$)';
    RegExp regex = new RegExp(pattern);
    return regex.hasMatch(value) && value.isNotEmpty;
  }

  bool validateMobile(String value) {
    String patttern = r'(^[0-9]*$)';
    RegExp regex = new RegExp(patttern);
    return regex.hasMatch(value);
  }

  bool isEmailValid(String email) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(p);
    return regex.hasMatch(email);
  }
}

class ProfilePage extends StatefulWidget {
  static String id = '/setupprofile';

  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with InputValidationMixin {
  final formGlobalKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  late String name;
  late String email;
  late String organization;
  late String bio;
  late String phno;

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser!;
      if (user != null) {
        loggedInUser = user;
        print(user);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  height: 250.0,
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.only(left: 20.0, top: 20.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(left: 90.0),
                                child: Text('COMPLETE PROFILE',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0,
                                        fontFamily: 'sans-serif-light',
                                        color: Colors.blue)),
                              )
                            ],
                          )),
                      Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child: Stack(fit: StackFit.loose, children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                  width: 140.0,
                                  height: 140.0,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: ExactAssetImage('assets/as.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  )),
                            ],
                          ),
                        ]),
                      )
                    ],
                  ),
                ),
                Form(
                  key: formGlobalKey,
                  child: Container(
                    color: Color(0xffFFFFFF),
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 25.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(left: 25.0, right: 25.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text(
                                        'Personal Information:',
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text(
                                        'Name',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Flexible(
                                    child: TextFormField(
                                      validator: (name) {
                                        if (validateName(name!))
                                          return null;
                                        else
                                          return 'Enter a valid email address';
                                      },
                                      decoration: const InputDecoration(
                                        hintText: "Enter Your Name",
                                      ),
                                      onChanged: (value){
                                        name=value;
                                      },
                                    ),
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text(
                                        'Email ID',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Flexible(
                                    child: TextFormField(
                                      validator: (email) {
                                        if (isEmailValid(email!))
                                          return null;
                                        else
                                          return 'Enter a valid email address';
                                      },
                                      decoration: const InputDecoration(
                                          hintText: "Enter Email ID"),
                                      onChanged: (value){
                                        email=value;
                                      },
                                    ),
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text(
                                        'Mobile',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Flexible(
                                    child: TextFormField(
                                      validator: (num) {
                                        if (validateMobile(num!))
                                          return null;
                                        else
                                          return 'Enter a valid mobile number';
                                      },
                                      decoration: const InputDecoration(
                                          hintText: "Enter Mobile Number"),
                                      onChanged: (value){
                                        phno=value;
                                      },
                                    ),
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      child: Text(
                                        'Oragnization',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue),
                                      ),
                                    ),
                                    flex: 2,
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Flexible(
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 10.0),
                                      child: TextFormField(
                                          validator:(name) {
                                            if (name!.isNotEmpty)
                                              return null;
                                            else
                                              return 'Please enter orgazization name';
                                          },
                                        decoration: const InputDecoration(
                                            hintText:
                                                "Enter Organization Name"),
                                        onChanged: (value){
                                          organization=value;
                                        },
                                      ),
                                    ),
                                    flex: 2,
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      child: Text(
                                        'Bio',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue),
                                      ),
                                    ),
                                    flex: 2,
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Flexible(
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 10.0),
                                      child: TextFormField(
                                          validator:(bio) {
                                            if (bio!.isNotEmpty)
                                              return null;
                                            else
                                              return 'Please enter your Bio';
                                          },
                                        decoration: const InputDecoration(
                                            hintText: "Enter about yourself"),
                                        onChanged: (value){
                                          bio=value;
                                        },
                                      ),
                                    ),
                                    flex: 2,
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20.0, right: 10.0),
        child: FloatingActionButton(
          onPressed: () async{
            if (formGlobalKey.currentState!.validate()) {
                 print(name+" "+email+" "+phno+" "+organization+" "+bio);
                 await _firestore.collection('ProfileDetails').add({
                   'name':name,
                   'email':email,
                   'Phone number':phno,
                   'Organization':organization,
                   'Bio':bio,
                   'sender': loggedInUser.uid,
                 });
                 print("Details entered successfully");
                 Navigator.pushNamed(context,SetupScreen.id);
            }else{
              print("Wrong Information Provided");
            }
          },
          backgroundColor: Colors.blue,
          child: const Icon(Icons.arrow_forward),
        ),
      ),
    );
  }
}
