import 'package:flutter/material.dart';
import 'package:oven_app/model/constants.dart';

class TemperatureScreenCurve extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Constants.backgroundColor;
    paint.style = PaintingStyle.fill; // Change this to fill

    var path = Path();

    path.moveTo(0, size.height * 0.25);
    path.quadraticBezierTo(size.width * 0.2, size.height * 0.21,
        size.width * 0.5, size.height * 0.21);
    path.quadraticBezierTo(size.width * 0.8, size.height * 0.21,
        size.width * 1.0, size.height * 0.25);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    canvas.drawPath(path, paint);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class HelpScreenCurve extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Constants.addPizzaColor;
    paint.style = PaintingStyle.fill; // Change this to fill

    var path = Path();

    path.moveTo(0, size.height * 0.20);
    path.quadraticBezierTo(size.width * 0.2, size.height * 0.15,
        size.width * 0.5, size.height * 0.15);
    path.quadraticBezierTo(size.width * 0.8, size.height * 0.15,
        size.width * 1.0, size.height * 0.20);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    canvas.drawPath(path, paint);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}


class AddPizzaCurve extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Constants.temperatureCard;
    paint.style = PaintingStyle.fill; // Change this to fill

    var path = Path();

    path.moveTo(0, size.height * 0.15);
    path.quadraticBezierTo(size.width * 0.2, size.height * 0.0,
        size.width * 0.5, size.height * 0.0);
    path.quadraticBezierTo(size.width * 0.8, size.height * 0.0,
        size.width * 1.0, size.height * 0.15);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    canvas.drawPath(path, paint);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class PizzaListCurve extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Constants.addPizzaColor;
    paint.style = PaintingStyle.fill; // Change this to fill

    var path = Path();

    path.moveTo(0, size.height * 0.20);
    path.quadraticBezierTo(size.width * 0.2, size.height * 0.15,
        size.width * 0.5, size.height * 0.15);
    path.quadraticBezierTo(size.width * 0.8, size.height * 0.15,
        size.width * 1.0, size.height * 0.20);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    canvas.drawPath(path, paint);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}