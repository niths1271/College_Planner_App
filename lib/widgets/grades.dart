import 'package:college_planner_app/pages/overviewScreen.dart';
import 'package:college_planner_app/widgets/attendence.dart';
import 'package:college_planner_app/widgets/attendhome.dart';
import 'package:college_planner_app/widgets/gradeadd.dart';
import 'package:college_planner_app/widgets/timetable.dart';
//import 'package:college_planner_app/widgets/remainder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

//import 'exam.dart';
//import 'home_work.dart';


class  Grades extends StatelessWidget {
  static final String title = 'Date (Range) & Time';
//  Date({required this.DatePickerWidget(),required this.TimePickerWidget()()})

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: title,
    theme: ThemeData(
      primaryColor: Colors.black,
    ),
    home: MainPage(),
  );
}
class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}
class _MainPageState extends State<MainPage> {
  int navIndex = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home : Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(

          title: Text('Grades'),
          backgroundColor: Colors.blueAccent,
        ),
        drawer: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Color.fromRGBO(207, 214, 227, 1),
            //other styles
          ),
          child: Sidenav(navIndex, (int index) {
            setState(() {
              navIndex = index;
            });
          }),
        ),
        //  body: SafeArea(
        // child: Row(
        //  children:<Widget>[
        //  Container(
        //   width: 100.0,
        //  height: 100.0,
        //  color: Colors.yellow,
        //  child: Text('Your absence 1 out of 10'),

        //  ),
        // ],
        floatingActionButton: SpeedDial(
            icon: Icons.add,
            overlayColor: Colors.black,

            onPress: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>Gradeadd()),
              );

            }


          //child: Icon(Icons.add),
          //backgroundColor: Colors.green,
          //foregroundColor: Colors.white,
          // onPressed: () {
          // Navigator.push(
          //  context,
          //   MaterialPageRoute(builder: (context) =>Remainder()),
          // );
          //   }
          //),

          // ),

        ),
      ),
    );





  }




}
class Sidenav extends StatelessWidget {
  final Function setIndex;
  final int selectedIndex;

  Sidenav(this.selectedIndex, this.setIndex);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('College Planner',
                style: TextStyle(
                    color: Theme.of(context).primaryColor, fontSize: 21)),
          ),
          Divider(color: Colors.grey.shade400),
          _navItem(context, Icons.home, 'Overview',
              suffix: Text(
                '',
                style: TextStyle(fontWeight: FontWeight.w500),
              ), onTap: () {
                Navigator.push(context, MaterialPageRoute(builder:(context)=>OverviewScreen ()));
              }, selected: selectedIndex == 1),
          _navItem(context, Icons.bookmark, 'Agenda',
              suffix: Text(
                '',
                style: TextStyle(fontWeight: FontWeight.w500),
              ), onTap: () {
                _navItemClicked(context, 2);
              }, selected: selectedIndex == 2),
          _navItem(context, Icons.calendar_today, 'Calendar',
              suffix: Text(
                '',
                style: TextStyle(fontWeight: FontWeight.w500),
              ), onTap: () {
                _navItemClicked(context, 3);
              }, selected: selectedIndex == 3),
          _navItem(context, Icons.pending_actions, 'Timetable',
              suffix: Text(
                '',
                style: TextStyle(fontWeight: FontWeight.w500),
              ), onTap: () {
                Navigator.push(context, MaterialPageRoute(builder:(context)=> Time()));
              }, selected: selectedIndex == 4),
          Divider(color: Colors.grey.shade400),
          _navItem(
            context,
            Icons.emoji_events,
            'Grades',
            onTap: () {

            },
            selected: selectedIndex == 5,
            suffix: Text(""),
          ),
          _navItem(
            context,
            Icons.event_available,
            'Attendance',
            onTap: () {

              Navigator.push(context, MaterialPageRoute(builder:(context)=>Attendence()));
            },
            selected: selectedIndex == 6,
            suffix: Text(""),
          ),
          _navItem(
            context,
            Icons.school,
            'Subjects',
            onTap: () {
              _navItemClicked(context, 7);
            },
            selected: selectedIndex == 7,
            suffix: Text(""),
          ),
          _navItem(
            context,
            Icons.person,
            'Teachers',
            onTap: () {
              _navItemClicked(context, 8);
            },
            selected: selectedIndex == 8,
            suffix: Text(""),
          ),
          Divider(color: Colors.grey.shade400),
          _navItem(
            context,
            Icons.settings,
            'Settings',
            onTap: () {
              _navItemClicked(context, 9);
            },
            selected: selectedIndex == 9,
            suffix: Text(""),
          ),
        ],
      ),
    );
  }

  _navItem(BuildContext context, IconData icon, String text,
      {required Text suffix,
        required Function() onTap,
        bool selected = false}) =>
      Container(
        color: selected ? Colors.grey.shade300 : Colors.transparent,
        child: ListTile(
          leading: Icon(icon,
              color: selected ? Theme.of(context).primaryColor : Colors.black),
          trailing: suffix,
          title: Text(text),
          selected: selected,
          onTap: onTap,
        ),
      );

  _navItemClicked(BuildContext context, int index) {
    setIndex(index);
    Navigator.of(context).pop();
  }
}
