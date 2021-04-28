import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Gauge extends StatefulWidget {
  final double min;
  final double max;

  final double defaultValue;

  final Color leftColor;
  final Color rightColor;

  Gauge(
      {this.min = 0,
      this.max = 900,
      this.defaultValue = 20,
      this.leftColor = Colors.blue,
      this.rightColor = Colors.red});

  @override
  State<StatefulWidget> createState() {
    return GaugeState( defaultValue );
  }
}

class GaugeState extends State<Gauge> {
  double value;

  GaugeState(this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: AspectRatio(
        aspectRatio: 1.0,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: <Color>[Colors.blue, Colors.red],
              tileMode: TileMode.decal,
            ),
          ),
        ),
      ),
    );
  }
}
