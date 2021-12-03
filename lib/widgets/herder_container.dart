import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:college_planner_app/utils/color.dart';
import 'package:flutter/material.dart';

class HeaderContainer extends StatelessWidget {
  var text = "Login";

  HeaderContainer(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [blueColors, blueLightColors],
              end: Alignment.bottomCenter,
              begin: Alignment.topCenter),
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(100)),
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            bottom: 20,
              right: 20,
              child: Text(
            text,
            style: TextStyle(color: Colors.white,fontSize: 20),
          )),
          Center(
            child: AnimatedTextKit(
              isRepeatingAnimation: false,
              animatedTexts: [
                TypewriterAnimatedText(
                  'College Planner App',
                  textStyle: TextStyle(
                    fontSize: 35.0,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
              ],
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}
