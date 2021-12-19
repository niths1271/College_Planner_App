import 'package:college_planner_app/pages/overviewScreen.dart';
import 'package:college_planner_app/pages/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:college_planner_app/pages/login_screen.dart';
import 'package:college_planner_app/pages/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(PlannerApp());
}

class PlannerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(initialRoute: WelcomePage.id, routes: {
      WelcomePage.id: (context) => WelcomePage(),
      LoginScreen.id: (context) => LoginScreen(),
      RegistrationScreen.id: (context) => RegistrationScreen(),
      OverviewScreen.id: (context) => OverviewScreen(),
    });
  }
}
