
import 'package:college_planner_app/widgets/date_picker_widget.dart';

import 'package:college_planner_app/widgets/subject.dart';



import 'package:college_planner_app/widgets/time_picker_widget.dart';
import 'package:college_planner_app/widgets/timetable.dart';
import 'package:flutter/material.dart';



class Timeadd extends StatelessWidget {

  static final String title = 'Date (Range) & Time';
  // Date({required this.DatePickerWidget(),})

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
  String  dropdownColor= "Written Exam";
  var items=['Written Exam',' Oral Exam','Practical'];
  int index = 0;
  //String text;


  //bool isOn = false;

  bool toggled=false;






  @override
  Widget build(BuildContext context) => Scaffold(







    backgroundColor: Colors.white,
    appBar: AppBar(
      // Here we take the value from the MyHomePage object that was created by
      // the App.build method, and use it to set our appbar title.

      automaticallyImplyLeading: true,
      //`true` if you want Flutter to automatically add Back Button when needed,
      //or `false` if you want to force your own back button every where
      leading: IconButton(icon:Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>Time()),
            );
          }


      ),
      actions: <Widget>[
        TextButton(
            style: TextButton.styleFrom(
              //  padding: const EdgeInsets.all(16.0),
              primary:Colors.white,
              textStyle: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),

            ),
            //onPressed: () {},
            child: const Text("ADD"),

            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>Time()),
              );
            }
        ),
      ],
    ),
    body: Padding(
      padding: EdgeInsets.all(32),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [





          SizedBox(
            height:40.5, //height of button
            width:double.infinity,
            //  font
            child: Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(

                icon: Icon(
                  Icons.school,
                  color: Colors.grey,
                  size: 24.0,
                ),
                label: Text('  Pick a subject'),
                //style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),

                onPressed: () {
                  dialog();
                },
                style: TextButton.styleFrom(
                  // primary: Colors.white, // background (button) color
                  textStyle:  TextStyle(fontSize: 20,  ),
                  primary: Colors.grey,

                ),
              ),
            ),
          ),
           DatePickerWidget(),
          const SizedBox(height: 10),
          TimePickerWidget(),

          const SizedBox(height: 10),
          TimePickerWidget(),



        ],
      ),


    ),
  );



  Future dialog() => showDialog(

    context: context,
    builder: ( context)=>AlertDialog(
      title: Text('Pick a subject'),
      content:
      ElevatedButton.icon(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>Subject()),
          );
        },
        label: const Text('Add new subject'),
        icon: const Icon(Icons.add),
      ),
      actions:[
        TextButton(
          child:Text('cancel'),
          onPressed:(){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>Time()),
            );
          },
        )
      ],

    ),
  );
}







