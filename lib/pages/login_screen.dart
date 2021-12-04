import 'package:college_planner_app/pages/overview_screen.dart';
import 'package:college_planner_app/pages/registration_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:college_planner_app/utils/color.dart';
import 'package:college_planner_app/widgets/btn_widget.dart';
import 'package:college_planner_app/widgets/header_container.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static String id = '/login';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _auth = FirebaseAuth.instance;
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
            HeaderContainer("Login"),
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
                      child: TextField(
                        keyboardType: TextInputType.emailAddress,
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
                      child: TextField(
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Password",
                          prefixIcon: Icon(Icons.vpn_key),
                        ),
                        onChanged: (value) {
                          password = value;
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Forgot Password?",
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: ButtonWidget(
                          onClick: () async {
                            try {
                              await _auth.signInWithEmailAndPassword(
                                  email: email,
                                  password: password
                              );
                              Navigator.pushNamed(context,OverviewScreen.id);
                              print("Login Successful");
                            } catch (e) {
                              print(e);
                            }
                          },
                          btnText: "LOGIN",
                        ),
                      ),
                    ),
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: "Don't have an account ? ",
                            style: TextStyle(color: Colors.black)),
                        TextSpan(
                            recognizer:TapGestureRecognizer()..onTap = () => Navigator.pushNamed(context, RegistrationScreen.id),
                            text: "Register",
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
