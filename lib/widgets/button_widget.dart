import 'package:flutter/material.dart';

class ButtonHeaderWidget extends StatelessWidget {
  final String title;
  final String text;
  final VoidCallback onClicked;

  final Icon icon;

  const ButtonHeaderWidget({
    key,
    required this.title,
    required this.text,
    required this.icon,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => HeaderWidget(
    title: title,

    child: ButtonWidget(
      text: text,
      onClicked: onClicked,
    ),
  );
}

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

  const ButtonWidget({
    key,
    required this.text,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
    style: ElevatedButton.styleFrom(
      minimumSize: Size.fromHeight(40),
      primary: Colors.blue,
    ),
    child: FittedBox(
      child:

      Text(
        text,
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),

    ),

    onPressed: onClicked,

  );

}

class HeaderWidget extends StatelessWidget {
  final String title;
  final Widget child;

  const HeaderWidget({
    key,
    required this.title,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,

    children: <Widget> [





      Text(







        title,

        style: TextStyle(
          color: Colors.lightBlue,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),

      ),

      const SizedBox(height: 8),
      child,

    ],

  );
}
