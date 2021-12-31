import 'package:college_planner_app/pages/setup_screen.dart';
import 'package:college_planner_app/utils/color.dart';
import 'package:college_planner_app/widgets/btn_widget.dart';
import 'package:college_planner_app/widgets/header_container.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'login_screen.dart';

// final RegExp emailRegex = new RegExp(
//     r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");


class RegistrationScreen extends StatefulWidget {
  static String id = '/registration';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

  // final formGlobalKey = GlobalKey < FormState > ();
  //
  // final _passwordFieldKey = GlobalKey<FormFieldState<String>>();

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
              child: Form(
                // key:formGlobalKey,
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
                            hintText: "Email",
                            prefixIcon: Icon(Icons.email),
                          ),
                          // validator: (value) {
                          //   if (!emailRegex.hasMatch(value!)) {
                          //     return 'Please enter valid email';
                          //   }
                          //   return null;
                          // },
                          onChanged: (value) {
                            email = value;
                          },
                        ),
                      ),
                      Container(
                        // key: _passwordFieldKey,
                        margin: EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Colors.white,
                        ),
                        padding: EdgeInsets.only(left: 10),
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "New Password",
                            prefixIcon: Icon(Icons.vpn_key),
                          ),
                          obscureText: true,
                          onChanged: (value) {
                            password = value;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter password';
                            }
                            return null;
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
                            hintText: "Confirm Password",
                            prefixIcon: Icon(Icons.vpn_key),
                          ),
                          obscureText: true,
                          onChanged: (value) {
                            password = value;
                          },
                          // validator: (value) {
                          //   if (value!.isEmpty) {
                          //     return 'Password is required';
                          //   }
                          //   if (value != _passwordFieldKey.currentState!.value) {
                          //     return 'Password do not match';
                          //   }
                          //   return null;
                          // },
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: ButtonWidget(
                            btnText: "REGISTER",
                            onClick: () async {
                                 // if (formGlobalKey.currentState!.validate()) {
                                 //   formGlobalKey.currentState!.save();
                                   try {
                                     await _auth.createUserWithEmailAndPassword(
                                         email: email, password: password);
                                     Navigator.pushNamed(context,SetupScreen.id);
                                     print("Registered Successfully");
                                   } catch (e) {
                                     print(e);
                                   }
                                 // }else{
                                 //   print("Wrong input");
                                 // }
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
              ),
            )
          ],
        ),
      ),
    );
  }
}
