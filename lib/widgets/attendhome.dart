

import 'package:college_planner_app/widgets/attendence.dart';
import 'package:college_planner_app/widgets/date_picker_widget.dart';
import 'package:college_planner_app/widgets/grades.dart';

import 'package:college_planner_app/widgets/button_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:college_planner_app/widgets/time_picker_widget.dart';
import 'package:flutter/material.dart';



class Date extends StatelessWidget {
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
  int index = 0;
  //String text;


  //bool isOn = false;

  bool _flutter=false;

 // String newDate;






  @override
  Widget build(BuildContext context) => Scaffold(







    backgroundColor: Colors.white,
    appBar: AppBar(
      // Here we take the value from the MyHomePage object that was created by
      // the App.build method, and use it to set our appbar title.
      title: Text('Attendence'),
      backgroundColor: Colors.blue,
      automaticallyImplyLeading: true,
      //`true` if you want Flutter to automatically add Back Button when needed,
      //or `false` if you want to force your own back button every where
      leading: IconButton(icon:Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>Attendence()),
            );
          }


      ),
      actions: <Widget>[
        TextButton(
            style: TextButton.styleFrom(
           //   backgroundColor: Colors.blue.shade300,
              //  padding: const EdgeInsets.all(16.0),
              primary:Colors.white,
              textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),

            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>Attendence()),
              );
            },
            child: const Text("ADD"),

        ),
      ],
    ),
    body: Padding(

      padding: EdgeInsets.all(32),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [




            // args = ModalRoute.of(context)!.settings.arguments as DatePickerWidget;
        DatePickerWidget(),
          const SizedBox(height: 10),
          TimePickerWidget(),
          const SizedBox(height: 10),


          Column(
            children: [
              SwitchListTile(
                title: Text('JUSTIFICATION',style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w800,

                    fontSize: 20
                ),
                ),
                value: _flutter,
                activeColor: Colors.lightBlue,
                inactiveTrackColor: Colors.grey,
                onChanged: (bool value) {
                  setState(() {
                    _flutter = value;
                  });
                },
              ),

            ],
          ),

        ],
      ),


    ),
  );

}



