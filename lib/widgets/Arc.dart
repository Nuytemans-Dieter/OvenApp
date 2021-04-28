import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:ui' as ui;

class Arc extends StatelessWidget {
  final double diameter;
  final double border;
  final double? value;

  final Color backgroundColor;
  final Color leftColor;
  final Color rightColor;
  final Color dotColor;

  const Arc(
      {Key? key,
      this.diameter = 300,
      this.value,
      this.border = 50.0,
      this.leftColor = Colors.blue,
      this.rightColor = Colors.red,
      this.dotColor = Colors.black,
      this.backgroundColor = Colors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ArcPainter(
          border, value, backgroundColor, leftColor, rightColor, dotColor),
      size: Size(diameter, diameter / 2),
    );
  }
}

class ArcPainter extends CustomPainter {
  final double border;
  final double? value;

  final Color backgroundColor;
  final Color leftColor;
  final Color rightColor;
  final Color dotColor;

  ArcPainter(this.border, this.value, this.backgroundColor, this.leftColor,
      this.rightColor, this.dotColor);

  @override
  void paint(Canvas canvas, Size size) {
    // Shared variables
    Offset centerOffset = Offset(size.width / 2, size.height);

    // Draw semi-circle

    Paint paint = Paint()
      ..shader = ui.Gradient.linear(
        Offset(centerOffset.dx + 20 - size.width / 2, 0),
        Offset(centerOffset.dx - 20 + size.width / 2, 0),
        [leftColor, rightColor],
      );
    canvas.drawArc(
      Rect.fromCenter(
        center: centerOffset,
        height: 2 * size.height,
        width: size.width,
      ),
      math.pi,
      math.pi,
      false,
      paint,
    );

    // Cut out part of semi-circle

    Paint eraser = Paint();
    eraser.color = backgroundColor;
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(centerOffset.dx, centerOffset.dy + 1),
        height: (2 * size.height) - 2 * border - 1,
        width: size.width - 2 * border,
      ),
      math.pi,
      math.pi,
      false,
      eraser,
    );

    // Draw the value dot

    if (value == null || value! < 0 || value! > 1) return;

    // Adjust the value range
    double currentValue;
    if (value! < 0)
      currentValue = 0;
    else if (value! > 1)
      currentValue = 1;
    else
      currentValue = value!;

    double largeRadius = size.width / 2;
    double smallRadius = size.width / 2 - border;

    // Calculate the angle (value 0 -> angle PI, value 1 -> angle 0)
    double theta = math.pi * (1 - currentValue);

    double x = math.cos(theta);
    double y = -math.sin(theta);

    Paint dotPaint = Paint()..color = dotColor;
    dotPaint.strokeWidth = 10.0;
    canvas.drawLine(
      Offset( x * smallRadius + centerOffset.dx,
              y * smallRadius + centerOffset.dy),
      Offset( x * largeRadius + centerOffset.dx, 
              y * largeRadius + centerOffset.dy),
      dotPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
