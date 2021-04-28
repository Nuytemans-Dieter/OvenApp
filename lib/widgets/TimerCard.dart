import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oven_app/model/TimerHelper.dart';
import 'package:oven_app/model/constants.dart';

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

  TimerCardState(this.timerHelper) {
    timerHelper.onCount = () {
      setState(() {});
    };
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Icon(
              Icons.local_pizza,
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
                  widget.title,
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
    );
  }
}
