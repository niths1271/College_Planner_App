import 'package:college_planner_app/utils/color.dart';
import 'package:flutter/material.dart';

class OverviewScreen extends StatefulWidget {
  static String id = '/overview';

  const OverviewScreen({Key? key}) : super(key: key);

  @override
  _OverviewScreenState createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen> {
  final List<String> options = [
    "TimeTable",
    "Agenda",
    "Calendar",
    "Subjects",
    "Grades",
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Overview"),
        // backgroundColor: Color.fromRGBO(52, 113, 235, 1),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.all(8),
              child: Text(
                "College Planner",
                style: TextStyle(
                  fontSize: 30,
                  color: Color.fromRGBO(52, 113, 235, 1),
                ),
              ),
            ),
            ListTile(
              title: Text("TimeTable"),
            ),
            ListTile(
              title: Text("Grades"),
            ),
            ListTile(
              title: Text("Subjects"),
            ),
            ListTile(
              title: Text("Calendar"),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height / 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10.0,
              ),
              child: Options(size),
            ),
            SizedBox(
              height: size.height / 40,
            ),
            ReportCard(size),
            SizedBox(
              height: size.height / 40,
            ),
            Container(
              height: size.height / 2.7,
              width: size.width / 1.1,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color.fromRGBO(52, 113, 235, 1),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: size.height / 40,
                  ),
                  Container(
                    width: size.width / 1.25,
                    child: Row(
                      children: [
                        Icon(
                          Icons.bookmark,
                          color: Colors.white,
                          size: 24.0,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Today",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height / 40,
                  ),
                  Container(
                    child: Image.asset(
                      "assets/study.jpg",
                      fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(
                    height: size.height / 40,
                  ),
                  Container(
                    child: Image.asset(
                      "assets/study.jpg",
                      fit: BoxFit.fill,
                    ),
                    width:350,
                    height:180,
                  ),
                  SizedBox(
                    height: size.height / 40,
                  ),
                  Container(
                    width: size.width / 1.2,
                    child: Text(
                      "No work due",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: size.height / 30,
            ),
            Container(
              height: size.height / 2.7,
              width: size.width / 1.1,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: blueLightColors,
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: size.height / 40,
                  ),
                  Container(
                    width: size.width / 1.25,
                    child: Row(
                      children: [
                        Icon(
                          Icons.bookmark,
                          color: Colors.white,
                          size: 24.0,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Tomorrow",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    // width:350,
                    height:180,
                  ),
                  SizedBox(
                    height: size.height / 40,
                  ),
                  Container(
                    width: size.width / 1.2,
                    child: Text(
                      "No work due",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: size.height / 30,
            ),
          ],
        ),
      ),
    );
  }

  Widget ReportCard(Size size) {
    return Container(
      height: size.height / 3.2,
      width: size.width / 1.1,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color.fromRGBO(52, 113, 235, 1),
      ),
      child: Column(
        children: [
          SizedBox(
            height: size.height / 40,
          ),
          Container(
            width: size.width / 1.25,
            child: Text(
              "Weekly Report",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
          SizedBox(
            height: size.height / 30,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: size.width / 1.25,
              child: Text(
                "You have no upcoming events",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ),
          ),
        ],
      ),
    );
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
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  width: 2,
                  color: Color.fromRGBO(52, 113, 235, 1),
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
                  color: Color.fromRGBO(52, 113, 235, 1),
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }),
    );
  }
}
