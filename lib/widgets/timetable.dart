

import 'package:college_planner_app/pages/overviewScreen.dart';
import 'package:college_planner_app/widgets/attendence.dart';
import 'package:college_planner_app/widgets/attendhome.dart';
import 'package:college_planner_app/widgets/grades.dart';
import 'package:college_planner_app/widgets/timeadd.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';



class Time extends StatelessWidget {
  // This widget is the root oT your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Timetable'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({key,  required this.title}) : super(key: key);
  // MyHomePage({ required Key key,  required this.title}) : super(key: key) {

  //  throw UnimplementedError();
  /// }

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  State<MyHomePage> createState() =>_MyHomePageState();


}


/*List<Appointment> getAppointments() {
  List<Appointment> meetings = <Appointment>[];
  final DateTime today = DateTime.now();
  final DateTime startTime =
  DateTime(today.year, today.month, today.day, 9, 0, 0);
  final DateTime endTime = startTime.add(const Duration(hours: 2));

 /* meetings.add(Appointment(
      startTime: startTime,
      endTime: endTime,
      subject: 'Board Meeting',
      color: Colors.blue,
      recurrenceRule: 'FREQ=DAILY;COUNT=10',
      isAllDay: false));

  return meetings;
}*/

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }
}*/
class _MyHomePageState extends State<MyHomePage> {
  int navIndex = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home : Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(

          title: Text('TimeTable'),
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
        body:
       // bodyHeight = MediaQuery.of(context).size.height - Scaffold.of(context).appBarMaxHeight
      //  MediaQuery. of(context). size. height;

           Row(
            // bodyHeight = MediaQuery.of(context).size.height - Scaffold.of(context).appBarMaxHeight,
              mainAxisAlignment: MainAxisAlignment.start,
              // double height = MediaQuery. of(context). size. height;
           //  bodyHeight = MediaQuery.of(context).size.height - Scaffold.of(context).appBarMaxHeight,
            // bodyHeight = MediaQuery.of(context).size.height - Scaffold.of(context).appBarMaxHeight,
              children: [
            SfCalendar(
            // bodyHeight = MediaQuery.of(context).size.height - Scaffold.of(context).appBarMaxHeight,
            view: CalendarView.week,
            firstDayOfWeek: 6,
            //initialDisplayDate: DateTime(2021, 03, 01, 08, 30),
           // initialSelectedDate: DateTime(2021, 03, 01, 08, 30),
         //  dataSource: MeetingDataSource(getAppointments()),







          ),



              ],
          ),









          floatingActionButton: SpeedDial(
            icon: Icons.add,
            overlayColor: Colors.black,

            onPress: () async {
              String received = await Navigator.push(context, MaterialPageRoute(builder: (_) =>Timeadd()));

            }



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
              Navigator.push(context, MaterialPageRoute(builder:(context)=>Grades()));
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

