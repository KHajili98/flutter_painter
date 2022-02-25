// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:flutter_painter/sketcher.dart';

// GestureDetector buildCurrentPath(BuildContext context) {
//   void onPanStart(DragStartDetails details) {
//     log('User started drawing');
//     final box = context.findRenderObject() as RenderBox;
//     final point = box.globalToLocal(details.globalPosition);
//     print(point);
//   }

//   void onPanUpdate(DragUpdateDetails details) {
//     final box = context.findRenderObject() as RenderBox;
//     final point = box.globalToLocal(details.globalPosition);
//     log(point.toString());
//   }

//   void onPanEnd(DragEndDetails details) {
//     log('User ended drawing');
//   }

//   return GestureDetector(
//     onPanStart: onPanStart,
//     onPanUpdate: onPanUpdate,
//     onPanEnd: onPanEnd,
//     child: RepaintBoundary(
//       child: Container(
//         color: Colors.transparent,
//         width: MediaQuery.of(context).size.width,
//         height: MediaQuery.of(context).size.height,
//         child: CustomPaint(
//           painter: Sketcher(lines: [line]),
//         ),
//         // CustomPaint widget will go here
//       ),
//     ),
//   );
// }
