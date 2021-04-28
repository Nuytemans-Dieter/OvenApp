import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:ui' as ui;

class Arc extends StatelessWidget {
  final double diameter;
  final double border;
  final Color backgroundColor;

  const Arc(
      {Key? key,
      this.diameter = 300,
      this.border = 50.0,
      this.backgroundColor = Colors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ArcPainter(border, backgroundColor),
      size: Size(diameter, diameter / 2),
    );
  }
}

class ArcPainter extends CustomPainter {
  final double border;
  final Color backgroundColor;

  ArcPainter(this.border, this.backgroundColor);

  @override
  void paint(Canvas canvas, Size size) {
    // Shared variables
    Offset centerOffset = Offset(size.width / 2, size.height);

    // Draw semi-circle

    Paint paint = Paint()..shader = ui.Gradient.linear(
      Offset(centerOffset.dx - size.width / 2, 0),
      Offset(centerOffset.dx + size.width / 2, 0),
      [Colors.blue, Colors.red], 
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
        height: (2 * size.height) - border - 1,
        width: size.width - border,
      ),
      math.pi,
      math.pi,
      false,
      eraser,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
