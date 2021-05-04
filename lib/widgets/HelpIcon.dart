import 'package:flutter/material.dart';
import 'package:oven_app/pages/Help.dart';

import '../model/constants.dart';

class HelpIcon extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HelpIconState();
  }
}

class HelpIconState extends State<HelpIcon> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HelpScreen()),
        );
      },
      child: Card(
        elevation: 0.0,
        color: Constants.backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Padding(
          padding: EdgeInsets.all(7.5),
          child: Icon(
            Icons.help_outline_rounded,
            color: Constants.textLight,
            size: 30,
          ),
        ),
      ),
    );
  }
}
