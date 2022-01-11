import 'package:college_planner_app/pages/attendence.dart';
import 'package:college_planner_app/pages/grades.dart';
import 'package:college_planner_app/widgets/Classes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import '../chart/chart_container.dart';
import '../chart/line_chart.dart';
import 'package:fl_chart/fl_chart.dart';
import 'agenda_add.dart';
import 'agendaq.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'display_profile.dart';

// hi bro hey
// import { collection, query, where, getDocs } from "firebase/firestore";
final _firestore = FirebaseFirestore.instance;
late User loggedInUser;
late List<LineChartBarData> lineChartBarData;
var todayClasses = [],
    tomorrowClasses = [],
    oneClasses = [],
    twoClasses = [],
    threeClasses = [],
    fourClasses = [],
    fiveClasses = [];
const spinkit = SpinKitRing(
  color: Colors.white,
  size: 50.0,
);

var todayEvents = [], tomorrowEvents = [];
//aa
final List<String> options = [
  "Classes",
  "Assignments",
  "Calendar",
  "Subjects",
  "Grades",
];

class OverviewScreen extends StatefulWidget {
  static String id = '/overview';
  @override
  _OverviewScreenState createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen> {
  final _auth = FirebaseAuth.instance;

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser!;
      if (user != null) {
        loggedInUser = user;
        print(user);
        // getEventsAndClasses();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<int> getEvents() async {
    int numEvents = 0;
    try {
      print("inside event");
      final snaps = await _firestore.collection('Assignments').get();
      // await for (var snapshot in _firestore.collection('Assignments').snapshots()) {
      // numEvents = snaps.docs.length;
      for (var docm in snaps.docs) {
        if (docm['sender'] == loggedInUser.uid) {
          print("user match!!");
          numEvents++;
          print(docm['date']);
          if (DateTime.fromMillisecondsSinceEpoch(docm['date'].seconds * 1000)
                  .day ==
              today.day) {
            setState(() {
              todayEvents.add(docm.data());
            });
          } else if (DateTime.fromMillisecondsSinceEpoch(
                      docm['date'].seconds * 1000)
                  .day ==
              tomorrow.day) {
            print("tomo events added");
            setState(() {
              tomorrowEvents.add(docm.data());
            });
          }
        }
        print(docm['title']);
      }
      //}
    } catch (e) {
      print(e);
    }
    print("tomo events");
    print(tomorrowEvents);
    return numEvents;
  }

  Future<int> getClasses() async {
    int numClasses = 0;
    try {
      print("inside");
      final snaps = await _firestore.collection('Classes').get();
      // for (var snapshot in snaps) {
      // numClasses = snaps.docs.length;
      for (var docm in snaps.docs) {
        if (docm['sender'] == loggedInUser.uid) {
          numClasses++;
          if (DateTime.fromMillisecondsSinceEpoch(docm['start'].seconds * 1000)
                  .day ==
              today.day) {
            todayClasses.add(docm.data());
          } else if (DateTime.fromMillisecondsSinceEpoch(
                      docm['start'].seconds * 1000)
                  .day ==
              tomorrow.day) {
            print("tom class added");
            tomorrowClasses.add(docm.data());
          } else if (DateTime.fromMillisecondsSinceEpoch(
                      docm['start'].seconds * 1000)
                  .day ==
              oneDayFromTomorrow.day) {
            print("one class added");
            setState(() {
              oneClasses.add(docm.data());
            });
          } else if (DateTime.fromMillisecondsSinceEpoch(
                      docm['start'].seconds * 1000)
                  .day ==
              twoDaysFromTomorrow.day) {
            print("two class added");
            setState(() {
              twoClasses.add(docm.data());
            });
          } else if (DateTime.fromMillisecondsSinceEpoch(
                      docm['start'].seconds * 1000)
                  .day ==
              threeDaysFromTomorrow.day) {
            setState(() {
              threeClasses.add(docm.data());
            });
          } else if (DateTime.fromMillisecondsSinceEpoch(
                      docm['start'].seconds * 1000)
                  .day ==
              fourDaysFromTomorrow.day) {
            setState(() {
              fourClasses.add(docm.data());
            });
          } else if (DateTime.fromMillisecondsSinceEpoch(
                      docm['start'].seconds * 1000)
                  .day ==
              fiveDaysFromTomorrow.day) {
            setState(() {
              fiveClasses.add(docm.data());
            });
          }
        }
        print(docm['room']);
      }
      //}
    } catch (e) {
      print(e);
    }
    print("tomo classes");
    print(tomorrowClasses);
    return numClasses;
  }

  int navIndex = 0;
  late ChartContainer myChart;
  bool chartSet = false;
  late var oneDayFromTomorrowD,
      twoDaysFromTomorrowD,
      threeDaysFromTomorrowD,
      fourDaysFromTomorrowD,
      fiveDaysFromTomorrowD,
      sixDaysFromTomorrowD;
  late DateTime today,
      tomorrow,
      oneDayFromTomorrow,
      twoDaysFromTomorrow,
      threeDaysFromTomorrow,
      fourDaysFromTomorrow,
      fiveDaysFromTomorrow,
      sixDaysFromTomorrow;

  late String todayDate,
      tomorrowDate,
      oneDate,
      twoDate,
      threeDate,
      fourDate,
      fiveDate,
      sixDate;

  void setWeekDays() {
    today = DateTime.now();
    DateTime absToday = today.subtract(Duration(hours: today.hour));
    tomorrow = absToday.add(Duration(days: 1));
    oneDayFromTomorrow = tomorrow.add(Duration(days: 1));
    oneDayFromTomorrowD = DateFormat('EEEE').format(oneDayFromTomorrow);
    twoDaysFromTomorrow = tomorrow.add(Duration(days: 2));
    twoDaysFromTomorrowD = DateFormat('EEEE').format(twoDaysFromTomorrow);
    threeDaysFromTomorrow = tomorrow.add(Duration(days: 3));
    threeDaysFromTomorrowD = DateFormat('EEEE').format(threeDaysFromTomorrow);
    fourDaysFromTomorrow = tomorrow.add(Duration(days: 4));
    fourDaysFromTomorrowD = DateFormat('EEEE').format(fourDaysFromTomorrow);
    fiveDaysFromTomorrow = tomorrow.add(Duration(days: 5));
    fiveDaysFromTomorrowD = DateFormat('EEEE').format(fiveDaysFromTomorrow);
    sixDaysFromTomorrow = tomorrow.add(Duration(days: 6));
    sixDaysFromTomorrowD = DateFormat('EEEE').format(sixDaysFromTomorrow);

    todayDate = today.toString().substring(0, 11);
    tomorrowDate = tomorrow.toString().substring(0, 11);
    oneDate = oneDayFromTomorrow.toString().substring(0, 11);
    twoDate = twoDaysFromTomorrow.toString().substring(0, 11);
    threeDate = threeDaysFromTomorrow.toString().substring(0, 11);
    fourDate = fourDaysFromTomorrow.toString().substring(0, 11);
    fiveDate = fiveDaysFromTomorrow.toString().substring(0, 11);
    sixDate = sixDaysFromTomorrow.toString().substring(0, 11);
  }

  int numTotalEvents = 0;
  void getCandE() async {
    print("calling 1");
    numTotalEvents += await getEvents();
    print("calling 2");

    numTotalEvents += await getClasses();
    setState(() {
      numTotalEvents += 0;
    });

    List<Color> lineColor = [
      Color(0xff62abe3),
      Color(0xff365d7a),
    ];

    lineChartBarData = [
      LineChartBarData(colors: lineColor, isCurved: true, spots: [
        FlSpot(today.weekday.toDouble(),
            (todayEvents.length + todayClasses.length).toDouble()),
        FlSpot(tomorrow.weekday.toDouble(),
            (tomorrowEvents.length + tomorrowClasses.length).toDouble()),
        FlSpot(oneDayFromTomorrow.weekday.toDouble(),
            oneClasses.length.toDouble()),
        FlSpot(twoDaysFromTomorrow.weekday.toDouble(),
            twoClasses.length.toDouble()),
        FlSpot(threeDaysFromTomorrow.weekday.toDouble(),
            threeClasses.length.toDouble()),
        FlSpot(fourDaysFromTomorrow.weekday.toDouble(),
            fourClasses.length.toDouble()),
        FlSpot(fiveDaysFromTomorrow.weekday.toDouble(),
            fiveClasses.length.toDouble())
      ])
    ];

    myChart = ChartContainer(
      title: '',
      color: Color.fromRGBO(45, 108, 223, 1),
      chart: LineChartContent(lineChartBarData: lineChartBarData),
    );
    chartSet = true;
  }

  @override
  void initState() {
    super.initState();
    setWeekDays();
    getCurrentUser();
    getCandE();
  }

  @override
  Widget build(BuildContext context) {
    Container mySpinner = Container(
      child: spinkit,
    );
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromRGBO(207, 214, 227, 1),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black54,
        ),
        title: Text(
          "Overview",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Color.fromRGBO(207, 214, 227, 1),
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
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: size.height / 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10.0,
              ),
              child: Options(size),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                height: 400.0,
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(
                        Icons.show_chart,
                        color: Colors.blueAccent,
                      ),
                      title: Text(
                        'Weekly report',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: chartSet ? myChart : mySpinner,
                        ),
                        SizedBox(
                          width: 120.0,
                          child: ListTile(
                            title: Text(
                              "$numTotalEvents events",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text("next 7 days"),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.0,
                        ),
                        child: Divider(
                          color: Colors.grey.shade400,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        leading: Icon(
                          Icons.arrow_forward,
                          color: Colors.black54,
                        ),
                        title: Text(
                          'Show more',
                          style: TextStyle(
                            // fontWeight: FontWeight.bold,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              leading: Text(
                "Today",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              trailing: Text("$todayDate"),
            ),
            todayEvents.length > 0 ? TodayEvents() : NoEvents(),
            ListTile(
              leading: Text(
                "Tomorrow",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              trailing: Text("$tomorrowDate"),
            ),
            tomorrowEvents.length > 0 ? TomorrowEvents() : NoEvents(),
            todayClasses.length > 0 ? TodayClasses() : NoTodayClasses(),
            ListTile(
              leading: Text(
                "$oneDayFromTomorrowD",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              trailing: Text("$oneDate"),
            ),
            oneClasses.length > 0 ? OneDayClasses() : Container(),
            ListTile(
              leading: Text(
                "$twoDaysFromTomorrowD",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              trailing: Text("$twoDate"),
            ),
            twoClasses.length > 0 ? TwoDayClasses() : Container(),
            ListTile(
              leading: Text(
                "$threeDaysFromTomorrowD",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              trailing: Text("$threeDate"),
            ),
            threeClasses.length > 0 ? ThreeDayClasses() : Container(),
            ListTile(
              leading: Text(
                "$fourDaysFromTomorrowD",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              trailing: Text("$fourDate"),
            ),
            fourClasses.length > 0 ? FourDayClasses() : Container(),
            ListTile(
              leading: Text(
                "$fiveDaysFromTomorrowD",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              trailing: Text("$fiveDate"),
            ),
            fiveClasses.length > 0 ? FiveDayClasses() : Container(),
            ListTile(
              leading: Text(
                "$sixDaysFromTomorrowD",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              trailing: Text("$sixDate"),
            ),
          ],
        ),
      ),
    );
  }
}

class FiveDayClasses extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var fiveDayClasses = <Widget>[];
    for (var event in fiveClasses) {
      String start =
          DateTime.fromMillisecondsSinceEpoch(event['start'].seconds * 1000)
              .toString()
              .substring(12, 16);
      // String start = event['start'].toString();
      String subject = event['subject'];
      var wid1 = Text(
        "$start",
        style: TextStyle(
          color: Colors.black54,
        ),
      );
      var wid2 = SizedBox(
        width: 8.0,
      );
      var wid3 = Icon(
        Icons.circle,
        color: Colors.green,
        size: 10,
      );
      var wid4 = SizedBox(
        width: 8.0,
      );
      var wid5 = Text(
        "$subject",
        style: TextStyle(
          color: Colors.black54,
        ),
      );
      // fiveDayClasses.add(wid1);
      // fiveDayClasses.add(wid2);
      // fiveDayClasses.add(wid3);
      // fiveDayClasses.add(wid4);
      // fiveDayClasses.add(wid5);
      fiveDayClasses.add(Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          wid1,
          wid2,
          wid3,
          wid4,
          wid5,
        ],
      ));
    }
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 30.0,
        vertical: 8.0,
      ),
      child: Column(
        children: fiveDayClasses,
      ),
    );
  }
}

class FourDayClasses extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var fourDayClasses = <Widget>[];
    for (var event in fourClasses) {
      String start =
          DateTime.fromMillisecondsSinceEpoch(event['start'].seconds * 1000)
              .toString()
              .substring(12, 16);
      // String start = event['start'].toString();
      String subject = event['subject'];
      var wid1 = Text(
        "$start",
        style: TextStyle(
          color: Colors.black54,
        ),
      );
      var wid2 = SizedBox(
        width: 8.0,
      );
      var wid3 = Icon(
        Icons.circle,
        color: Colors.green,
        size: 10,
      );
      var wid4 = SizedBox(
        width: 8.0,
      );
      var wid5 = Text(
        "$subject",
        style: TextStyle(
          color: Colors.black54,
        ),
      );
      // fourDayClasses.add(wid1);
      // fourDayClasses.add(wid2);
      // fourDayClasses.add(wid3);
      // fourDayClasses.add(wid4);
      // fourDayClasses.add(wid5);

      fourDayClasses.add(Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          wid1,
          wid2,
          wid3,
          wid4,
          wid5,
        ],
      ));
    }
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 30.0,
        vertical: 8.0,
      ),
      child: Column(
        children: fourDayClasses,
      ),
    );
  }
}

class ThreeDayClasses extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("3 dat class");
    var threeDayClasses = <Widget>[];
    for (var event in threeClasses) {
      String start =
          DateTime.fromMillisecondsSinceEpoch(event['start'].seconds * 1000)
              .toString()
              .substring(12, 16);
      // String start = event['start'].toString();
      String subject = event['subject'];
      var wid1 = Text(
        "$start",
        style: TextStyle(
          color: Colors.black54,
        ),
      );
      var wid2 = SizedBox(
        width: 8.0,
      );
      var wid3 = Icon(
        Icons.circle,
        color: Colors.green,
        size: 10,
      );
      var wid4 = SizedBox(
        width: 8.0,
      );
      var wid5 = Text(
        "$subject",
        style: TextStyle(
          color: Colors.black54,
        ),
      );
      // threeDayClasses.add(wid1);
      // threeDayClasses.add(wid2);
      // threeDayClasses.add(wid3);
      // threeDayClasses.add(wid4);
      // threeDayClasses.add(wid5);

      threeDayClasses.add(Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          wid1,
          wid2,
          wid3,
          wid4,
          wid5,
        ],
      ));
    }
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 30.0,
        vertical: 8.0,
      ),
      child: Column(
        children: threeDayClasses,
      ),
    );
  }
}

class TwoDayClasses extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("2 dat class");
    var twoDayClasses = <Widget>[];
    for (var event in twoClasses) {
      String start =
          DateTime.fromMillisecondsSinceEpoch(event['start'].seconds * 1000)
              .toString()
              .substring(12, 16);
      // String start = event['start'].toString();
      String subject = event['subject'];
      var wid1 = Text(
        "$start",
        style: TextStyle(
          color: Colors.black54,
        ),
      );
      var wid2 = SizedBox(
        width: 8.0,
      );
      var wid3 = Icon(
        Icons.circle,
        color: Colors.green,
        size: 10,
      );
      var wid4 = SizedBox(
        width: 8.0,
      );
      var wid5 = Text(
        "$subject",
        style: TextStyle(
          color: Colors.black54,
        ),
      );
      // twoDayClasses.add(wid1);
      // twoDayClasses.add(wid2);
      // twoDayClasses.add(wid3);
      // twoDayClasses.add(wid4);
      // twoDayClasses.add(wid5);
      twoDayClasses.add(Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          wid1,
          wid2,
          wid3,
          wid4,
          wid5,
        ],
      ));
    }
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 30.0,
        vertical: 8.0,
      ),
      child: Column(
        children: twoDayClasses,
      ),
    );
  }
}

class OneDayClasses extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("1 dat class");
    var oneDayClasses = <Widget>[];
    for (var event in oneClasses) {
      String start =
          DateTime.fromMillisecondsSinceEpoch(event['start'].seconds * 1000)
              .toString()
              .substring(12, 16);
      //String start = event['start'].toString();
      String subject = event['subject'];
      var wid1 = Text(
        "$start",
        style: TextStyle(
          color: Colors.black54,
        ),
      );
      var wid2 = SizedBox(
        width: 8.0,
      );
      var wid3 = Icon(
        Icons.circle,
        color: Colors.green,
        size: 10,
      );
      var wid4 = SizedBox(
        width: 8.0,
      );
      var wid5 = Text(
        "$subject",
        style: TextStyle(
          color: Colors.black54,
        ),
      );
      // oneDayClasses.add(wid1);
      // oneDayClasses.add(wid2);
      // oneDayClasses.add(wid3);
      // oneDayClasses.add(wid4);
      // oneDayClasses.add(wid5);
      oneDayClasses.add(Row(
          //mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [wid1, wid2, wid3, wid4, wid5]));
    }
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 30.0,
        vertical: 8.0,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: oneDayClasses,
      ),
    );
  }
}

class NoTodayClasses extends StatelessWidget {
  const NoTodayClasses({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 8.0,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
        ),
        // width: size.width,
        height: 470.0,
        child: Column(
          children: [
            ListTile(
              leading: Icon(
                Icons.bookmark,
                color: Colors.blueAccent,
              ),
              title: Text(
                'Daily Schedule',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
            ),
            Image.asset(
              'assets/study.jpg',
              fit: BoxFit.fill,
            ),
            ListTile(
              title: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 8.0,
                ),
                child: Text(
                  'There are no classes',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
              ),
              subtitle:
                  Text('You can always add new classes from the Classes menu'),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.0,
              ),
              child: Divider(
                color: Colors.grey.shade400,
              ),
            ),
            Expanded(
              child: ListTile(
                leading: Icon(
                  Icons.arrow_forward,
                  color: Colors.black54,
                ),
                title: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Agenda()));
                  },
                  child: Text(
                    'Show more',
                    style: TextStyle(
                      // fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TodayClasses extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var todayAllClassWidgets = <Widget>[];

    for (var event in todayClasses) {
      String subject = event['subject'];
      String start =
          DateTime.fromMillisecondsSinceEpoch(event['start'].seconds * 1000)
              .toString()
              .substring(12, 16);
      String end =
          DateTime.fromMillisecondsSinceEpoch(event['end'].seconds * 1000)
              .toString()
              .substring(12, 16);
      String remaining =
          (DateTime.fromMillisecondsSinceEpoch(event['start'].seconds * 1000)
                      .hour -
                  DateTime.now().hour)
              .toString();
      // String start = "13:00 PM";
      // String end = "14:00 PM";
      String room = event['room'];
      var wid1 = ListTile(
        leading: Icon(
          Icons.circle,
          size: 15,
          color: Colors.green,
        ),
        title: Text('$subject'),
        subtitle: Text('$start - $end'),
        trailing: SizedBox(
          height: 50.0,
          width: 100.0,
          child: Row(
            children: [
              SizedBox(
                width: 25.0,
              ),
              Icon(
                Icons.schedule,
                size: 15,
              ),
              SizedBox(
                width: 5.0,
              ),
              Text(
                "$remaining hr",
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      );
      var wid2 = ListTile(
        leading: Icon(
          Icons.location_on,
          size: 20,
          color: Colors.black54,
        ),
        title: Text(
          '$room',
          style: TextStyle(
            fontSize: 15.0,
            color: Colors.black54,
          ),
        ),
      );
      // todayAllClassWidgets.add(Expanded(child: wid1));
      // todayAllClassWidgets.add(Expanded(child: wid2));
      todayAllClassWidgets.add(Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          wid1,
          wid2,
        ],
      ));
    }

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 8.0,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
        ),
        //height: 280.0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(
                Icons.pending_actions,
                color: Colors.blueAccent,
              ),
              title: Text(
                'Next Classes',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: todayAllClassWidgets,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.0,
              ),
              child: Divider(
                color: Colors.grey.shade400,
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.arrow_forward,
                color: Colors.black54,
              ),
              title: Text(
                'Show more',
                style: TextStyle(
                  // fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NoEvents extends StatelessWidget {
  const NoEvents({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 8.0,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
        ),
        // width: size.width,
        height: 460.0,
        child: Column(
          children: [
            ListTile(
              leading: Icon(
                Icons.bookmark,
                color: Colors.blueAccent,
              ),
              title: Text(
                'Pending Events',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
            ),
            Image.asset(
              'assets/work.jpg',
              fit: BoxFit.fill,
            ),
            ListTile(
              title: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 8.0,
                ),
                child: Text(
                  'There are no events',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
              ),
              subtitle: Text(
                  'You can always add new assignments in the Assignments tab'),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.0,
              ),
              child: Divider(
                color: Colors.grey.shade400,
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.arrow_forward,
                color: Colors.black54,
              ),
              title: GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Agenda()));
                },
                child: Text(
                  'Show more',
                  style: TextStyle(
                    // fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget Options(Size size) {
  return Container(
    height: size.height / 15,
    width: size.width,
    child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: options.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Agenda()));
            },
            child: Container(
              height: size.height / 16,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  width: 1,
                  color: Color.fromRGBO(150, 151, 153, 1),
                ),
              ),
              padding: EdgeInsets.symmetric(
                vertical: 4,
                horizontal: 8,
              ),
              margin: EdgeInsets.symmetric(
                vertical: 6,
                horizontal: 8,
              ),
              child: Text(
                options[index],
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        }),
  );
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
            _navItemClicked(context, 1);
          }, selected: selectedIndex == 1),
          _navItem(context, Icons.bookmark, 'Assignments',
              suffix: Text(
                '',
                style: TextStyle(fontWeight: FontWeight.w500),
              ), onTap: () {
            _navItemClicked(context, 2);
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Agenda()));
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
                  context, MaterialPageRoute(builder: (context) => Grade()));
            },
            selected: selectedIndex == 5,
            suffix: Text(""),
          ),
          _navItem(
            context,
            Icons.event_available,
            'Attendance',
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Attendence()));
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
          // _navItem(
          //   context,
          //   Icons.person,
          //   'Teachers',
          //   onTap: () {
          //     _navItemClicked(context, 8);
          //   },
          //   selected: selectedIndex == 8,
          //   suffix: Text(""),
          // ),
          Divider(color: Colors.grey.shade400),
          _navItem(
            context,
            Icons.person,
            'Profile',
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => DispProfile()));
              // _navItemClicked(context, 9);
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

class TodayEvents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var todayAllEventWidgets = <Widget>[];
    int i = 1;
    for (var event in todayEvents) {
      String title = event['title'];
      String note = event['note'];
      var wid = ListTile(
        leading: Text("$i"),
        title: Text('$title'),
        subtitle: Text('$note'),
      );
      todayAllEventWidgets.add(wid);
      i++;
    }

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 8.0,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
        ),
        // width: size.width,
        //height: 150.0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(
                Icons.bookmark,
                color: Colors.blueAccent,
              ),
              title: Text(
                'Pending Events',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: todayAllEventWidgets,
            ),
          ],
        ),
      ),
    );
  }
}

class TomorrowEvents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var tomAllEventWidgets = <Widget>[];
    int i = 1;
    for (var event in tomorrowEvents) {
      String title = event['title'];
      String note = event['note'];
      var wid = ListTile(
        leading: Text("$i"),
        title: Text('$title'),
        subtitle: Text('$note'),
      );
      tomAllEventWidgets.add(wid);
      i++;
    }

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 8.0,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
        ),
        // width: size.width,
        //height: 150.0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(
                Icons.bookmark,
                color: Colors.blueAccent,
              ),
              title: Text(
                'Pending Events',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: tomAllEventWidgets,
            ),
          ],
        ),
      ),
    );
  }
}
