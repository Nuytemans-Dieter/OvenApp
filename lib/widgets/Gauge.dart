import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:oven_app/widgets/Arc.dart';

class Gauge extends StatefulWidget {
  final double width;

  final double min;
  final double max;
  final double defaultValue;

  final Color leftColor;
  final Color rightColor;
  final Color backgroundColor;

  Gauge(
      {Key? key,
      this.width = 100,
      this.min = 0,
      this.max = 900,
      this.defaultValue = 20,
      this.leftColor = Colors.grey,
      this.rightColor = Colors.grey,
      this.backgroundColor = Colors.transparent})
      : super(key: key);

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
        value: ((value - widget.min) / (widget.max - widget.min)),
        leftColor: widget.leftColor,
        rightColor: widget.rightColor,
        backgroundColor: widget.backgroundColor,
        diameter: widget.width,
        border: widget.width * 0.05,
      ),
    );
  }
}
