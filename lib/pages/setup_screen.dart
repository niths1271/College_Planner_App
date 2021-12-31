import 'package:college_planner_app/pages/overview_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/intl.dart';

final _firestore = FirebaseFirestore.instance;
late User loggedInUser;

class SetupScreen extends StatefulWidget {
  static String id = '/setup';

  const SetupScreen({Key? key}) : super(key: key);

  @override
  _SetupScreenState createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {

  List<String> startdates=['','','',''];
  List<String> enddates=['','','',''];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> showInformationDialog(BuildContext context,int i) async {
    return await showDialog(context: context,
        builder: (context){
          final TextEditingController _textEditingController = TextEditingController();
          bool isChecked = false;
          return StatefulBuilder(builder: (context,setState){
            return AlertDialog(
              content: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment:CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Start Date",textAlign:TextAlign.left,style: TextStyle(color: Colors.blue),),
                      TextFormField(
                        readOnly: true,
                        controller: _textEditingController,
                        // validator: (value){
                        //   return value!.isNotEmpty ? null : "Invalid Field";
                        // },
                        decoration: InputDecoration(hintText:"${startdates[i]==''?"Not Set":startdates[i]}"),
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context, initialDate: DateTime.now(),
                              firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                              lastDate: DateTime(2101)
                          );
                          if(pickedDate != null ){
                            String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                            print(formattedDate);
                            setState(() {
                              startdates[i]=formattedDate; //set output date to TextField value.
                            });
                          }else{
                            print("Date is not selected");
                          }
                        },
                      ),
                      SizedBox(height: 20,),
                      Text("End Date",textAlign:TextAlign.left,style: TextStyle(color: Colors.blue),),
                      TextFormField(
                          readOnly: true,
                        controller: _textEditingController,
                          decoration: InputDecoration(hintText:"${enddates[i]==''?"Not Set":enddates[i]}"),
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context, initialDate: DateTime.now(),
                                firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                                lastDate: DateTime(2101)
                            );
                            if(pickedDate != null ){
                              String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                              print(formattedDate);
                              setState(() {
                                enddates[i]=formattedDate; //set output date to TextField value.
                              });
                            }else{
                              print("Date is not selected");
                            }
                          }
                      ),
                    ],
                  )),
              actions: <Widget>[
                TextButton(
                  child: Text('Submit'),
                  onPressed: (){
                    if(_formKey.currentState!.validate()){
                      // Do something like updating SharedPreferences or User Settings etc.
                      Navigator.of(context).pop();
                      setState((){
                      });
                    }
                  },
                ),
              ],
            );
          });
        });
  }

  var details = {'One':1,'Two':2,'Three':3,'Four':4};
  String dropdownValue = 'One';

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

  List<Widget> outputCards(){
    const mapd={0:'st',1:'nd',2:'rd',3:'th'};
    List<Widget> arr=[];
       var n=details[dropdownValue];
       for (int i=0;i<n!;i++){
           arr.add(Card(
             child: InkWell(
               splashColor: Colors.blue.withAlpha(30),
               onTap: () async {
                 await showInformationDialog(context,i);
               },
               child: Column(
                 mainAxisSize: MainAxisSize.min,
                 children:<Widget>[
                   ListTile(
                     leading: Icon(Icons.calendar_today_outlined,size: 30, color: Colors.blue),
                     title: Text('${(i+1).toString()}${mapd[i]} Term'),
                     subtitle: Text("${(startdates[i]=='' || enddates[i]=='')?"Not Set":startdates[i]+" - "+enddates[i]}",),
                   ),
                 ],
               ),
             ),
           ));
       }
       return arr;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F6F6),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 100, horizontal: 30),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.calendar_today, size: 40, color: Colors.blue),
              SizedBox(
                height: 20,
              ),
              Text(
                "Terms",
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "How many terms do you have?",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Icon(Icons.access_time_outlined,
                      size: 35, color: Colors.blue),
                  SizedBox(
                    width: 20,
                  ),
                  DropdownButton<String>(
                    value: dropdownValue,
                    elevation: 16,
                    style: const TextStyle(color: Colors.blue),
                    underline: Container(
                      height: 2,
                      color: Colors.blue,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                      });
                    },
                    items: <String>['One', 'Two', 'Three', 'Four']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top:10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:outputCards(),
                ),
              ),
            ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 30.0, right: 20.0),
        child: FloatingActionButton(
          onPressed: () async {
            await _firestore.collection('Terms').add({
              'terms': details[dropdownValue],
              'sender': loggedInUser.uid,
            });
            for(int i=0;i<details[dropdownValue]!;i++) {
              if (startdates[i] != '' || enddates[i] != '') {
                await _firestore.collection('TermStartDates').add({
                  (i + 1).toString(): startdates[i],
                  'sender': loggedInUser.uid,
                });
                await _firestore.collection('TermEndDates').add({
                  (i + 1).toString(): enddates[i],
                  'sender': loggedInUser.uid,
                });
              }
            }
            print("Number of terms entered successfully");
            Navigator.pushNamed(context, OverviewScreen.id);
          },
          backgroundColor: Colors.blue,
          child: const Icon(Icons.arrow_forward),
        ),
      ),
    );
  }
}
