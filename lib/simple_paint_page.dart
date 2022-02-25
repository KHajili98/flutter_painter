import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class SimplPaintWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.indigo,
      child: CustomPaint(
        //                       <-- CustomPaint widget
        size: const Size(600, 600),
        painter: MyPainter(),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    //!--------------------------------------------------------
    const pointMode = ui.PointMode.points;
    final points = [
      const Offset(50, 100),
      const Offset(150, 75),
      const Offset(250, 250),
      const Offset(130, 200),
      const Offset(270, 100),
    ];
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 15
      ..strokeCap = StrokeCap.round;
    canvas.drawPoints(pointMode, points, paint);
    //!--------------------------------------------------------

    const p1 = Offset(50, 50);
    const p2 = Offset(250, 150);
    final paint2 = Paint()
      ..color = Colors.red
      ..strokeWidth = 4;
    canvas.drawLine(p1, p2, paint2);
    //!--------------------------------------------------------
    const left = 2.0;
    const top = 2.0;
    const right = 550.0;
    const bottom = 550.0;
    const rect = Rect.fromLTRB(left, top, right, bottom);
    final paint3 = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawRect(rect, paint3);
    //!--------------------------------------------------------

    const center = Offset(400, 400);
    const radius = 100.0;
    final paintCircle = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;
    canvas.drawCircle(center, radius, paintCircle);

    //!--------------------------------------------------------
    const rectOval = Rect.fromLTRB(50, 100, 250, 200);
    final paintOval = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;
    canvas.drawOval(rectOval, paintOval);
  }

  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
  }
}
