import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:oven_app/model/constants.dart';

class HelpCard extends StatefulWidget {
  final Logger logger = Logger("HelpCard");

  final String description;
  final String iconPath;

  HelpCard({this.description = "", this.iconPath = ""});

  @override
  State<StatefulWidget> createState() {
    return HelpCardState();
  }
}

class HelpCardState extends State<HelpCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Constants.addPizzaColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.all(7.5),
              child: Image.asset(
                widget.iconPath,
                width: 30,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(
              width: 30.0,
            ),
            Text(
              widget.description,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Constants.textLight),
            ),
          ],
        ),
      ),
    );
  }
}
