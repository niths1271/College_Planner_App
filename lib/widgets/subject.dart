//import 'package:college_planner_app/widgets/agendaHome.dart';
//import 'package:college_planner_app/widgets/exam.dart';
import 'package:college_planner_app/widgets/gradeadd.dart';
import 'package:college_planner_app/widgets/grades.dart';
import 'package:flutter/material.dart';


import 'date_picker_widget.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
//import 'package:college_planner_app/widgets/date_picker_widget.dart';

class  Subject extends StatefulWidget {
  const Subject({key}) : super(key: key);

  @override
  State<Subject> createState() => _SubjectState();
}

// const Remainder({key}) : super(key: key);
class _SubjectState extends State<Subject> {
  Color pickerColor = Color(0xff443a49);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text('Subject'),
            // Here we take the value from the MyHomePage object that was created by
            // the App.build method, and use it to set our appbar title.
            backgroundColor: Colors.blue,
            automaticallyImplyLeading: true,
            //`true` if you want Flutter to automatically add Back Button when needed,
            //or `false` if you want to force your own back button every where
            leading: IconButton(icon:Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
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
                    Navigator.pop(context);
                  }
              ),
            ],
          ),

          body: SafeArea(
            // backgroundColor: Colors.white,

          child: Column(
              children: [
                const SizedBox(height: 20),


               // backgroundColor: Colors.white,








              /*  ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 20),

                  ),

                  onPressed: () => pickColor(context),*/
               //  child:Column(

                    //children:[
                      const SizedBox(height: 20),
                      TextField(
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.book),
                            hintText: "Add a name",
                            hintStyle: TextStyle(
                                fontSize: 25,
                               // fontWeight: FontWeight.bold,

                                color: Colors.grey

                            ),


                            border: InputBorder.none,
                            fillColor: Colors.white,
                            filled: true


                        ),


                      ),
                      const SizedBox(height: 20),
                 /*container(

                        width: MediaQuery.of(context).size.width  ,
                        height: 40,
                        decoration: BoxDecoration(

                          // shape: BoxShape.circle,
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          color:  pickerColor,



                          //     boxShadow:[
                          //     BoxShadow(
                          //   offset:Offset(0.0,10.0)
                          //  )

                        ),
                        child:

                        Text(
                          'pick color',
                          style: TextStyle(
                              fontSize: 24
                          ),
                        ),

                      ),*/
                      const SizedBox(height: 20),

                      //  const SizedBox(height: 10),

                      TextField(
                        decoration: InputDecoration(
                            hintText: "Add a note",
                            hintStyle: TextStyle(
                                fontSize: 20,
                              //  fontWeight: FontWeight.bold,

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



              //],


            ),
          );


     // ),
   // );


  }

  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  Widget buildColorPicker() =>
      ColorPicker(
        pickerColor:  pickerColor,
        onColorChanged: changeColor,



      );

  void pickColor(BuildContext context) =>
      showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(
              title: Text("your color"),
              content: Column(

                mainAxisSize: MainAxisSize.min,
                children: [
                  buildColorPicker(),
                  TextButton(
                    child: Text(
                      "SELECT",
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  //  ),
                ],
              ),
            ),
      );






}
