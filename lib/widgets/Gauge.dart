import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oven_app/widgets/Arc.dart';

class Gauge extends StatefulWidget {
  final double width;

  final double min;
  final double max;
  final double defaultValue;

  final Color leftColor;
  final Color rightColor;
  final Color backgroundColor;

  Gauge({
    this.width = 300,
    this.min = 0,
    this.max = 900,
    this.defaultValue = 20,
    this.leftColor = Colors.blue,
    this.rightColor = Colors.red,
    this.backgroundColor = Colors.white});

  @override
  State<StatefulWidget> createState() {
    return GaugeState(defaultValue);
  }
}

class GaugeState extends State<Gauge> {
  double value;

  GaugeState(this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Arc(
        leftColor: widget.leftColor,
        rightColor: widget.rightColor,
        backgroundColor: widget.backgroundColor,
        diameter: widget.width,
        border: widget.width * 0.15,
      ),
    );
  }
}
