import 'package:college_planner_app/pages/overviewScreen.dart';
import 'package:college_planner_app/widgets/attendhome.dart';
import 'package:college_planner_app/widgets/grades.dart';
import 'package:college_planner_app/widgets/time_picker_widget.dart';
import 'package:college_planner_app/widgets/Classes.dart';
//import 'package:college_planner_app/widgets/remainder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'agenda_add.dart';
//import 'exam.dart';
//import 'home_work.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

final _firestore = FirebaseFirestore.instance;
late User loggedInUser;

class Agenda extends StatefulWidget {
  static String id = '/agenda';
  @override
  _AgendaState createState() => _AgendaState();
}

class _AgendaState extends State<Agenda> {
  late var agendas = <Widget>[];
  final _auth = FirebaseAuth.instance;

  void getAgendas() async {
    try {
      print("inside getagenda try");

      final snaps = await _firestore.collection('Assignments').get();
      for (var docm in snaps.docs) {
        if (docm['sender'] == loggedInUser.uid) {
          String time = DateTime.fromMillisecondsSinceEpoch(
                      docm['date'].seconds * 1000)
                  .toString()
                  .substring(0, 10) +
              " at " +
              DateTime.fromMillisecondsSinceEpoch(docm['date'].seconds * 1000)
                  .toString()
                  .substring(11, 16);
          print("adding");
          print(docm['title']);
          var agenda = Container(
            color: Colors.transparent,
            margin: EdgeInsets.all(4.0),
            padding: EdgeInsets.all(4.0),
            child: Padding(
              padding: EdgeInsets.all(3.0),
              child: Material(
                color: Colors.blueAccent.withOpacity(0.4),
                borderRadius: BorderRadius.circular(10.0),
                child: Container(
                  color: Colors.transparent,
                  margin: EdgeInsets.all(4.0),
                  child: ExpansionTile(
                    initiallyExpanded: false,
                    childrenPadding: EdgeInsets.all(12.0),
                    title: Text(
                      docm['title'],
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    children: [
                      ListTile(
                        title: Text(
                          docm['note'],
                        ),
                        subtitle: Text(
                          time,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );

          setState(() {
            agendas.add(agenda);
          });
        }
      }
    } catch (e) {
      print(e);
    }
  }

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
    getAgendas();
  }

  int navIndex = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        //backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Assignments'),
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
        body: Padding(
          padding: EdgeInsets.all(32),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: agendas,
            ),
          ),
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
            onPress: () async {
              await Navigator.push(
                  context, MaterialPageRoute(builder: (_) => AgendaAdd()));
              getAgendas();
            }),
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
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => OverviewScreen()));
          }, selected: selectedIndex == 1),
          _navItem(context, Icons.bookmark, 'Assignments',
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
          _navItem(context, Icons.pending_actions, 'Classes',
              suffix: Text(
                '',
                style: TextStyle(fontWeight: FontWeight.w500),
              ), onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Classes()));
          }, selected: selectedIndex == 4),
          Divider(color: Colors.grey.shade400),
          _navItem(
            context,
            Icons.emoji_events,
            'Grades',
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Grades()));
            },
            selected: selectedIndex == 5,
            suffix: Text(""),
          ),
          _navItem(
            context,
            Icons.event_available,
            'Attendance',
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Grades()));
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

// waste
