import 'package:college_planner_app/pages/overviewScreen.dart';
import 'package:college_planner_app/pages/registration_screen.dart';
import 'package:college_planner_app/pages/reset.dart';
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

  Future<void> _showMyDialog(String e) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
            content: SingleChildScrollView(
              child: ListBody(
                children:<Widget>[
                  Text(e),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text("Okay"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ]);
      },
    );
  }

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
                      child:RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Navigator.pushNamed(
                                    context, ResetScreen.id),
                              text: "Forgot Password?",
                              style: TextStyle(color: blueColors)),
                        ]),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: ButtonWidget(
                          onClick: () async {
                            try {
                              await _auth.signInWithEmailAndPassword(
                                  email: email, password: password);
                              Navigator.pushNamed(context, OverviewScreen.id);
                              print("Login Successful");
                            } catch (e) {
                              _showMyDialog(e.toString());
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
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Navigator.pushNamed(
                                  context, RegistrationScreen.id),
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
