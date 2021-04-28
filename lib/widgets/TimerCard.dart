import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TimerCard extends StatefulWidget {
  final String title;
  final Color color;

  TimerCard({this.title = "", this.color = Colors.grey});

  @override
  State<StatefulWidget> createState() {
    return TimerCardState();
  }
}

class TimerCardState extends State<TimerCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            widget.title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0
            ),
          ),
        ),
      ),
    );
  }
}
