import 'package:flutter/material.dart';
import 'package:genmote/constants.dart';

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {

    var paint = Paint();

    paint.color = Colors.green;
    paint.style = PaintingStyle.fill;

    var path = Path();
    path.moveTo(0, size.height * 0.25);
    path.quadraticBezierTo(size.width / 2, size.height / 2, size.width, size.height * 0.25);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);

    // Straight line
    /*paint.color = Colors.green;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 2.0;

    path.lineTo(size.width, size.height);*/

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    // throw UnimplementedError();
    return false;
  }

}