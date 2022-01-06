import 'package:college_planner_app/widgets/button_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class DatePickerWidget extends StatefulWidget {
//  var date;
  // DatePickerWidget({required this.date});
  //late final String newDate;
 //DatePickerWidget({required this.newDate});
  @override
  _DatePickerWidgetState createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {





  var icon;
  var date;


  String getText() {

    if (date == null) {


      return

        ' Pick a Date';
    } else {
      return DateFormat('MM/dd/yyyy').format(date);
      // return '${date.month}/${date.day}/${date.year}';

    }
  }

  @override
  Widget build(BuildContext context) => ButtonHeaderWidget(
    title: '',
    icon:  Icon(Icons.search),


    text:


    getText(),


    onClicked: () => pickDate(context),



  );

  Future pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
    );

    if (newDate == null) return;


    setState(() => date = newDate);
  }
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<DateTime>('date', date));
  }
}
