
import 'package:college_planner_app/widgets/date_picker_widget.dart';

import 'grades.dart';
import 'package:college_planner_app/widgets/button_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
import 'package:intl/intl.dart';

import 'dart:io';

import 'package:college_planner_app/pages/overviewScreen.dart';
import 'package:college_planner_app/pages/attendence.dart';
import 'package:college_planner_app/pages/attendhome.dart';
import 'package:college_planner_app/widgets/date_picker_widget.dart';
import 'package:college_planner_app/pages/grades.dart';

//import 'package:date_picker_example/widget/date_picker_widget.dart';
//import 'package:custom_switch/custom_switch.dart';



import 'package:college_planner_app/widgets/time_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

final _firestore = FirebaseFirestore.instance;
late User loggedInUser;

class GradeAdd extends StatefulWidget {
  @override
  _GradeAddState createState() => _GradeAddState();
}

class _GradeAddState extends State<GradeAdd> {
  // start datetime

  late double _height;
  late double _width;

  //late String _setTime, _setDate;

  //late String _hour, _minute, _time;

  //late String dateTime;

  //DateTime selectedDate = DateTime.now();

  // TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);

  //TextEditingController _dateController = TextEditingController();
  //TextEditingController _timeController = TextEditingController();

  //Future<Null> _selectDate(BuildContext context) async {
  /* final DateTime? picked = await showDatePicker(
        context: context,
        //initialDate: selectedDate,
        //initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        selectedDate = picked;
        _dateController.text = DateFormat.yMd().format(selectedDate);
      });
  }*/

  /* Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null)
      setState(() {
        selectedTime = picked;
        _hour = selectedTime.hour.toString();
        _minute = selectedTime.minute.toString();
        _time = _hour + ' : ' + _minute;
        _timeController.text = _time;
        _timeController.text = formatDate(
            DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute),
            [hh, ':', nn, " ", am]).toString();
      });
  }*/

  // end datetime
  final _auth = FirebaseAuth.instance;

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
    //_dateController.text = DateFormat.yMd().format(DateTime.now());

   // _timeController.text = formatDate(
    //    DateTime(2019, 08, 1, DateTime.now().hour, DateTime.now().minute),
    //    [hh, ':', nn, " ", am]).toString();
    super.initState();
    getCurrentUser();
  }

  int index = 0;

  //String text;
  late String note, title;
  late String  dropdownColor= "Written Exam";
  var items=['Written Exam',' Oral Exam','Practical'];
  //late DateTime atTime;
// bool isOn = false;

 // bool _flutter = false;

  // String newDate;

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height / 2;
    _width = MediaQuery.of(context).size.width;
    //dateTime = DateFormat.yMd().format(DateTime.now());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('Grades'),
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: true,
        //`true` if you want Flutter to automatically add Back Button when needed,
        //or `false` if you want to force your own back button every where
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              //   backgroundColor: Colors.blue.shade300,
              //  padding: const EdgeInsets.all(16.0),
              primary: Colors.white,
              textStyle:
              const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            onPressed: () async {
              //atTime = DateTime(selectedDate.year, selectedDate.month,
              //selectedDate.day, selectedTime.hour, selectedTime.minute);
              await _firestore.collection('Grades').add({
                'grade': note,
                'dropdownColor':dropdownColor,
                'title': title,
                'sender': loggedInUser.uid,
                //'date': Timestamp.fromDate(atTime),
              });
              print("Details entered successfully");
              Navigator.pop(context);
            },
            child: const Text("ADD"),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // args = ModalRoute.of(context)!.settings.arguments as DatePickerWidget;
              Container(
                width: _width / 1.7,
                child: TextField(
                  onChanged: (value) {
                    title = value;
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: "Subject",
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: _width / 1.7,
                child: TextField(
                  onChanged: (value) {
                    note = value;
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: "Grade",
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: _width / 1.7,
                child:


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
                          //   widget.onChanged(value);
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



              ),
              // datetime start

              /* Container(
                width: _width,
                height: _height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text(
                          'Choose Due Date',
                          style: TextStyle(
                            // fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.5),
                        ),
                        InkWell(
                          onTap: () {
                            _selectDate(context);
                          },
                          child: Container(
                            width: _width / 1.7,
                            height: _height / 6,
                            margin: EdgeInsets.only(top: 8.0),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(color: Colors.grey[200]),
                            child: TextFormField(
                              style: TextStyle(fontSize: 40),
                              textAlign: TextAlign.center,
                              enabled: false,
                              keyboardType: TextInputType.text,
                              controller: _dateController,
                              onSaved: (val) {
                                _setDate = val.toString();
                              },
                              decoration: InputDecoration(
                                  disabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide.none),
                                  // labelText: 'Time',
                                  contentPadding: EdgeInsets.only(top: 0.0)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          'Choose Due Time',
                          style: TextStyle(
                            // fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.5),
                        ),
                        InkWell(
                          onTap: () {
                            _selectTime(context);
                          },
                          child: Container(
                            margin: EdgeInsets.only(top: 8),
                            width: _width / 1.7,
                            height: _height / 6,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(color: Colors.grey[200]),
                            child: TextFormField(
                              style: TextStyle(fontSize: 40),
                              textAlign: TextAlign.center,
                              onSaved: (val) {
                                _setTime = val.toString();
                              },
                              enabled: false,
                              keyboardType: TextInputType.text,
                              controller: _timeController,
                              decoration: InputDecoration(
                                  disabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide.none),
                                  // labelText: 'Time',
                                  contentPadding: EdgeInsets.all(5)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),*/

              // datetime end
            ],
          ),
        ),
      ),
    );
  }
}