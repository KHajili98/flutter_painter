import 'package:flutter/material.dart';

class Sketcher extends CustomPainter {
  
  // 2
  @override
  void paint(Canvas canvas, Size size) {
    // 1
    Offset startPoint = const Offset(0, 0);
    // 2
    Offset endPoint = Offset(size.width, size.height);
    // 3
    Paint paint1 = Paint()..color = Colors.red;
    // 4
    canvas.drawLine(startPoint, endPoint, paint1);
    // 1
    Paint paint = Paint()..style = PaintingStyle.stroke;
    // 2
    Path path = Path();
    // 3
    path.moveTo(0, 250);
    path.lineTo(100, 200);
    path.lineTo(150, 150);
    path.lineTo(200, 50);
    path.lineTo(250, 150);
    path.lineTo(300, 200);
    path.lineTo(size.width, 250);
    path.lineTo(0, 250);

    // 4
    path.moveTo(100, 100);
    path.addOval(Rect.fromCircle(center: const Offset(100, 100), radius: 25));

    // 5
    canvas.drawPath(path, paint);
  }

  // 4
  @override
  bool shouldRepaint(Sketcher delegate) {
    return true;
  }
}
