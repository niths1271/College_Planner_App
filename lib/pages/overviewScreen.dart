import 'package:college_planner_app/widgets/attendence.dart';
import 'package:college_planner_app/widgets/grades.dart';
import 'package:college_planner_app/widgets/timetable.dart';
import 'package:flutter/material.dart';

final List<String> options = [
  "TimeTable",
  "Agenda",
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
  int navIndex = 0;

  @override
  Widget build(BuildContext context) {
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
                height: 280.0,
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
                      children: [
                        Expanded(
                          child: ListTile(
                            title: Text(
                              "2 events",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text("next 7 days"),
                          ),
                        ),
                      ],
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
            ),
            ListTile(
              leading: Text(
                "Today",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              trailing: Text("Dec 10, 2021"),
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
                height: 280.0,
                child: Column(
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
                    ListTile(
                      leading: Icon(
                        Icons.circle,
                        size: 15,
                        color: Colors.green,
                      ),
                      title: Text('Software Engg'),
                      subtitle: Text('12:00 AM - 1:00 AM'),
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
                              "35m",
                              style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.location_on,
                        size: 20,
                        color: Colors.black54,
                      ),
                      title: Text(
                        'CR 207',
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.black54,
                        ),
                      ),
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
            ),
            ListTile(
              leading: Text(
                "Tomorrow",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              trailing: Text("Dec 10, 2021"),
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
                // width: size.width,
                height: 420.0,
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
                          'You can always add new events in the agenda tab'),
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
                // width: size.width,
                height: 420.0,
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
                      subtitle: Text(
                          'You can always add new classes from the timetable menu'),
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
            ),
            ListTile(
              leading: Text(
                "Sunday",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              trailing: Text("Dec 10, 2021"),
            ),
            ListTile(
              leading: Text(
                "Monday",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              trailing: Text("Dec 10, 2021"),
            ),
            ListTile(
              leading: Text(
                "Tuesday",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              trailing: Text("Dec 10, 2021"),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 30.0,
                vertical: 8.0,
              ),
              child: Row(
                children: [
                  Text(
                    "11:00 PM",
                    style: TextStyle(
                      color: Colors.black54,
                    ),
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Icon(
                    Icons.circle,
                    color: Colors.green,
                    size: 10,
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Text(
                    "Advanced Algorithms",
                    style: TextStyle(
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
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
                // width: size.width,
                height: 150.0,
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
                    ListTile(
                      leading: Text("1"),
                      title: Text('Advanced Algorithm'),
                      subtitle: Text('Quiz'),
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              leading: Text(
                "Wednesday",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              trailing: Text("Dec 10, 2021"),
            ),
            ListTile(
              leading: Text(
                "Thursday",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              trailing: Text("Dec 10, 2021"),
            ),
            ListTile(
              leading: Text(
                "Friday",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              trailing: Text("Dec 10, 2021"),
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
          return Container(
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
              ),onTap: () {
                Navigator.push(context, MaterialPageRoute(builder:(context)=>Time()));
              },selected: selectedIndex == 4),
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
