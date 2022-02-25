// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:flutter_colorpicker/flutter_colorpicker.dart';

// void main() => runApp(const MyApp());

// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const MyHomePage(),
//     );
//   }
// }

// class DrawingArea {
//   Offset point;
//   Paint areaPaint;

//   DrawingArea({required this.point, required this.areaPaint});
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key}) : super(key: key);

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   List<DrawingArea?>? points = [];

//   ValueNotifier<List<DrawingArea?>?> pointsNotifier = ValueNotifier([]);
//   Color? selectedColor;
//   double? strokeWidth;

//   @override
//   void initState() {
//     super.initState();
//     selectedColor = Colors.black;
//     strokeWidth = 2.0;
//   }

//   void selectColor() {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Color Chooser'),
//         content: SingleChildScrollView(
//           child: BlockPicker(
//             pickerColor: selectedColor!,
//             onColorChanged: (color) {
//               setState(() {
//                 selectedColor = color;
//               });
//             },
//           ),
//         ),
//         actions: <Widget>[
//           FlatButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: const Text("Close"))
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final double width = MediaQuery.of(context).size.width;
//     final double height = MediaQuery.of(context).size.height;

//     return Scaffold(
//       body: ValueListenableBuilder<List<DrawingArea?>?>(
//           valueListenable: pointsNotifier,
//           builder: (context, v, c) {
//             return Stack(
//               children: <Widget>[
//                 Container(
//                   decoration: const BoxDecoration(
//                       gradient: LinearGradient(
//                           begin: Alignment.topCenter,
//                           end: Alignment.bottomCenter,
//                           colors: [
//                         Color.fromRGBO(138, 35, 135, 1.0),
//                         Color.fromRGBO(233, 64, 87, 1.0),
//                         Color.fromRGBO(242, 113, 33, 1.0),
//                       ])),
//                 ),
//                 Center(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Container(
//                           width: width * 0.80,
//                           height: height * 0.80,
//                           decoration: BoxDecoration(
//                               borderRadius:
//                                   const BorderRadius.all(Radius.circular(20.0)),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.black.withOpacity(0.4),
//                                   blurRadius: 5.0,
//                                   spreadRadius: 1.0,
//                                 )
//                               ]),
//                           child: GestureDetector(
//                             onPanDown: (details) {
//                               pointsNotifier.value =
//                                   List.from(pointsNotifier.value!)
//                                     ..add(DrawingArea(
//                                         point: details.localPosition,
//                                         areaPaint: Paint()
//                                           ..strokeCap = StrokeCap.round
//                                           ..isAntiAlias = true
//                                           ..color = selectedColor!
//                                           ..strokeWidth = strokeWidth!));
//                               // pointsNotifier.value!.add(DrawingArea(
//                               //     point: details.localPosition,
//                               //     areaPaint: Paint()
//                               //       ..strokeCap = StrokeCap.round
//                               //       ..isAntiAlias = true
//                               //       ..color = selectedColor!
//                               //       ..strokeWidth = strokeWidth!));
//                             },
//                             onPanUpdate: (details) {
//                               pointsNotifier.value =
//                                   List.from(pointsNotifier.value!)
//                                     ..add(DrawingArea(
//                                         point: details.localPosition,
//                                         areaPaint: Paint()
//                                           ..strokeCap = StrokeCap.round
//                                           ..isAntiAlias = true
//                                           ..color = selectedColor!
//                                           ..strokeWidth = strokeWidth!));

//                               // pointsNotifier.value!.add(DrawingArea(
//                               //     point: details.localPosition,
//                               //     areaPaint: Paint()
//                               //       ..strokeCap = StrokeCap.round
//                               //       ..isAntiAlias = true
//                               //       ..color = selectedColor!
//                               //       ..strokeWidth = strokeWidth!));
//                             },
//                             onPanEnd: (details) {
//                               pointsNotifier.value =
//                                   List.from(pointsNotifier.value!)..add(null);
//                             },
//                             child: SizedBox.expand(
//                               child: ClipRRect(
//                                 borderRadius: const BorderRadius.all(
//                                     Radius.circular(20.0)),
//                                 child: CustomPaint(
//                                   painter: MyCustomPainter(points: v),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       Container(
//                         width: width * 0.80,
//                         decoration: const BoxDecoration(
//                             color: Colors.white,
//                             borderRadius:
//                                 BorderRadius.all(Radius.circular(20.0))),
//                         child: Row(
//                           children: <Widget>[
//                             IconButton(
//                                 icon: Icon(
//                                   Icons.color_lens,
//                                   color: selectedColor,
//                                 ),
//                                 onPressed: () {
//                                   selectColor();
//                                 }),
//                             Expanded(
//                               child: Slider(
//                                 min: 1.0,
//                                 max: 5.0,
//                                 label: "Stroke $strokeWidth",
//                                 activeColor: selectedColor,
//                                 value: strokeWidth!,
//                                 onChanged: (double value) {
//                                   setState(() {
//                                     strokeWidth = value;
//                                   });
//                                 },
//                               ),
//                             ),
//                             IconButton(
//                                 icon: const Icon(
//                                   Icons.layers_clear,
//                                   color: Colors.black,
//                                 ),
//                                 onPressed: () {
//                                   pointsNotifier.value =
//                                       List.from(pointsNotifier.value!)..clear();
//                                 }),
//                           ],
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ],
//             );
//           }),
//     );
//   }
// }

// class MyCustomPainter extends CustomPainter {
//   List<DrawingArea?>? points;

//   MyCustomPainter({@required this.points});

//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint background = Paint()..color = Colors.white;
//     Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
//     canvas.drawRect(rect, background);
//     canvas.clipRect(rect);
    

//     for (int x = 0; x < points!.length - 1; x++) {
//       if (points![x] != null && points![x + 1] != null) {
//         canvas.drawLine(
//             points![x]!.point, points![x + 1]!.point, points![x]!.areaPaint);
//       } else if (points![x] != null && points![x + 1] == null) {
//         canvas.drawPoints(
//             PointMode.points, [points![x]!.point], points![x]!.areaPaint);
//       }
//     }
//   }

//   @override
//   bool shouldRepaint(MyCustomPainter oldDelegate) {
//     return oldDelegate.points != points;
//   }
// }
