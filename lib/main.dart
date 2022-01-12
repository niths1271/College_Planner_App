import 'package:college_planner_app/pages/grades.dart';
import 'package:college_planner_app/pages/overviewScreen.dart';
import 'package:college_planner_app/pages/reset.dart';
import 'package:college_planner_app/pages/setup_profile_page.dart';
import 'package:college_planner_app/pages/setup_screen.dart';
import 'package:college_planner_app/pages/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:college_planner_app/pages/login_screen.dart';
import 'package:college_planner_app/pages/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:college_planner_app/pages/attendence.dart';
import 'widgets/Classes_add.dart';
import 'widgets/Classes.dart';
import 'pages/agendaq.dart';
import 'pages/display_profile.dart';

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
      SetupScreen.id: (context) => SetupScreen(),
      ProfilePage.id: (context) => ProfilePage(),
      ResetScreen.id: (context) => ResetScreen(),
      //ClassesAdd.id: (context) => ClassesAdd(),
      Classes.id: (context) => Classes(),
      Attendence.id: (context) => Attendence(),
      Grade.id: (context) => Grade(),
      Agenda.id: (context) => Agenda(),
      DispProfile.id: (context) => DispProfile(),
    });
  }
}
