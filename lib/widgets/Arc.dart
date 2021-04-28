import 'package:flutter/material.dart';
import 'dart:math' as math;

class Arc extends StatelessWidget {
  final double diameter;

  const Arc({Key? key, this.diameter = 200}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ArcPainter(),
      size: Size(diameter, diameter / 2),
    );
  }
}

class ArcPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.blue;
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(size.width / 2, size.height),
        height: 2 * size.height,
        width: size.width,
      ),
      math.pi,
      math.pi,
      false,
      paint,
    );
    
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}