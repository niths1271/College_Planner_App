import 'dart:io';

import 'package:college_planner_app/pages/overviewScreen.dart';
import 'package:college_planner_app/pages/attendence.dart';
import 'package:college_planner_app/pages/attendhome.dart';
import 'package:college_planner_app/widgets/date_picker_widget.dart';
import 'package:college_planner_app/pages/grades.dart';
import 'package:college_planner_app/widgets/subject.dart';
//import 'package:date_picker_example/widget/date_picker_widget.dart';
//import 'package:custom_switch/custom_switch.dart';


import 'package:college_planner_app/widgets/time_picker_widget.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';


class Gradeadd extends StatelessWidget {

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
      backgroundColor: Colors.blue,
      title: Text('Grades'),

      automaticallyImplyLeading: true,
      //`true` if you want Flutter to automatically add Back Button when needed,
      //or `false` if you want to force your own back button every where
      leading: IconButton(icon:Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>Grades()),
            );
          }


      ),
      actions: <Widget>[
        TextButton(
            style: TextButton.styleFrom(
              //  padding: const EdgeInsets.all(16.0),
              primary:Colors.white,
              textStyle: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),

            ),
            //onPressed: () {},
            child: const Text("ADD"),

            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>Grades()),
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

          const TextField(
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.emoji_events),
                hintText: "Add a grade",
                hintStyle: TextStyle(
                    fontSize: 20,
                    //fontWeight: FontWeight.bold,

                    color: Colors.grey

                ),


                border: InputBorder.none,
                fillColor: Colors.white,
                filled: true


            ),

          ),
          const SizedBox(height: 20),
          SizedBox(
            height:50, //height of button
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
        //  ),


       //   DatePickerWidget(),
          const SizedBox(height: 20),
   Align(
 alignment: Alignment.centerLeft,

   child:DecoratedBox(

            decoration: BoxDecoration(
                color:Colors.white,
                //background color of dropdown button
                border: Border.all(color: Colors.black38, width:0), //border of dropdown button
                borderRadius: BorderRadius.horizontal(), //border raiuds of dropdown button
                boxShadow: <BoxShadow>[ //apply shadow on Dropdown button
                  BoxShadow(

                      color: Color.fromRGBO(0,0,0,0), //shadow for button
                      blurRadius: 5) //blur radius of shadow
                ]
              //  width:50,
            ),

            child:Padding(
              //    width:50,
              padding: EdgeInsets.only(left:10, right:10,top: 10),
              child:DropdownButton(
                items: items.map((itemsname){
                  style: new TextStyle(
                    color: Colors.black,
                    fontSize: 40,
                    // fontWeight: FontWeight.bold,

                  );
                  return   DropdownMenuItem(
                      value:itemsname ,
                      child: Text(itemsname),


                   // const TextStyle(color: Colors.grey),
                  );
                }).toList(),

                onChanged: (String? newValue){
                  setState(() {
                    dropdownColor  = newValue!;
                  });
                },
                style: const TextStyle(color: Colors.grey),
                selectedItemBuilder: (BuildContext context) {
                  return options.map((String value) {
                    return Text(
                      dropdownColor,
                      style: const TextStyle(color: Colors.black, fontSize: 20,),
                    );
                  }).toList();
                },
                //style: const TextStyle(color: Colors.grey),

                value: dropdownColor,

              ),
            ),
          ),
   ),














          const SizedBox(height: 10),
          const TextField(
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.shop),
                hintText: "Add Percentage",
                hintStyle: TextStyle(
                    fontSize: 20,
                   // fontWeight: FontWeight.bold,

                    color: Colors.grey

                ),


                border: InputBorder.none,
                fillColor: Colors.white,
                filled: true


            ),

          ),




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
            MaterialPageRoute(builder: (context) =>Gradeadd()),
          );

         // );
        },
      )
    ],

  ),
);
}







