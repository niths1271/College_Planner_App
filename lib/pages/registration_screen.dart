import 'package:college_planner_app/utils/color.dart';
import 'package:college_planner_app/widgets/btn_widget.dart';
import 'package:college_planner_app/widgets/herder_container.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'login_screen.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = '/registration';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  late String email;
  late String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.only(bottom: 30),
        child: Column(
          children: <Widget>[
            HeaderContainer("Register"),
            Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.only(left: 20, right: 20, top: 30),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Colors.white,
                      ),
                      padding: EdgeInsets.only(left: 10),
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Full Name",
                          prefixIcon: Icon(Icons.person),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Colors.white,
                      ),
                      padding: EdgeInsets.only(left: 10),
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Email",
                          prefixIcon: Icon(Icons.email),
                        ),
                        onChanged: (value) {
                          email = value;
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Colors.white,
                      ),
                      padding: EdgeInsets.only(left: 10),
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Phone Number",
                          prefixIcon: Icon(Icons.call),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Colors.white,
                      ),
                      padding: EdgeInsets.only(left: 10),
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Password",
                          prefixIcon: Icon(Icons.vpn_key),
                        ),
                        obscureText: true,
                        onChanged: (value) {
                          password = value;
                        },
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: ButtonWidget(
                          btnText: "REGISTER",
                          onClick: () async {
                            try {
                              await _auth.createUserWithEmailAndPassword(
                                  email: email, password: password);
                              // Navigator.pushNamed(context,);
                              print("Registered Successfully");
                            } catch (e) {
                              print(e);
                            }
                          },
                        ),
                      ),
                    ),
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: "Already a member ? ",
                            style: TextStyle(color: Colors.black)),
                        TextSpan(
                            recognizer:TapGestureRecognizer()..onTap = () => Navigator.pushNamed(context,LoginScreen.id),
                            text: "Login",
                            style: TextStyle(color: blueColors)),
                      ]),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
