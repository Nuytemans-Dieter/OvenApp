import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oven_app/model/TimerHelper.dart';
import 'package:oven_app/model/constants.dart';
import 'package:oven_app/widgets/popups/PizzaSettingsPopup.dart';

class TimerCard extends StatefulWidget {
  final TimerHelper timerHelper = TimerHelper();
  final String title;
  final Color color;

  TimerCard({this.title = "", this.color = Colors.grey});

  @override
  State<StatefulWidget> createState() {
    return TimerCardState(timerHelper);
  }
}

class TimerCardState extends State<TimerCard> {
  TimerHelper timerHelper;
  String? overwriteTitle;
  IconData icon = Icons.local_pizza_rounded;

  TimerCardState(this.timerHelper) {
    timerHelper.onCount = () {
      setState(() {});
    };
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) => PizzaSettingsPopup(
              title: "Change info card",
              cancelText: "Cancel",
              titleInputHint: "(optional) change item name",
              okText: "Ok",
              description: "Change appearance of this item",
              onSubmit: (newName, newIcon) {
                  setState(() {
                    if (newName != "")
                      overwriteTitle = newName;
                    icon = newIcon;
                  });
              },
            ),
          );
        },
        onLongPress: () {},
        splashColor: Constants.accentColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(
                icon,
                size: 50.0,
                color: Constants.accentColor,
              ),
              SizedBox(
                width: 30.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    overwriteTitle ?? widget.title,
                    style: Constants.textStyle,
                  ),
                  Text(
                    widget.timerHelper.getPrettyTime(),
                    style: Constants.textStyle,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
