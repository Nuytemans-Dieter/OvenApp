import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Gauge extends StatefulWidget {
  final double min;
  final double max;

  final Color leftColor;
  final Color rightColor;

  Gauge(
      {this.min = 0,
      this.max = 900,
      this.leftColor = Colors.blue,
      this.rightColor = Colors.red});

  @override
  State<StatefulWidget> createState() {
    return GaugeState(20.0);
  }
}

class GaugeState extends State<Gauge> {
  double value;

  GaugeState(this.value);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: <Color>[Colors.blue, Colors.red],
          tileMode: TileMode.decal,
        ),
      ),
    );
  }
}
