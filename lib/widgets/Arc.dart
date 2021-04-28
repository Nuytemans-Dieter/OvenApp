import 'package:flutter/material.dart';
import 'dart:math' as math;

class Arc extends StatelessWidget {
  final double diameter;
  final double border;

  const Arc({Key? key, this.diameter = 300, this.border = 50.0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ArcPainter(border),
      size: Size(diameter, diameter / 2),
    );
  }
}

class ArcPainter extends CustomPainter {

  final double border;

  ArcPainter(this.border);

  @override
  void paint(Canvas canvas, Size size) {
    // Shared variables
    Offset centerOffset = Offset(size.width / 2, size.height);

    // Draw semi-circle

    Paint paint = Paint()..color = Colors.blue;
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
    eraser.blendMode = BlendMode.clear;
    eraser.color = Colors.white;
    canvas.drawArc(
      Rect.fromCenter(
        center: centerOffset,
        height: (2 * size.height) - border,
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
