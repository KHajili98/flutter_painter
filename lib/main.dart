import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class DrawingArea {
  Offset point;
  Paint areaPaint;

  DrawingArea({required this.point, required this.areaPaint});
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<DrawingArea?>? points = [];

  ValueNotifier<List<DrawingArea?>?> pointsNotifier = ValueNotifier([]);
  Color? selectedColor;
  double? strokeWidth;

  @override
  void initState() {
    super.initState();
    selectedColor = Colors.black;
    strokeWidth = 2.0;
  }

  void selectColor() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Color Chooser'),
        content: SingleChildScrollView(
          child: BlockPicker(
            pickerColor: selectedColor!,
            onColorChanged: (color) {
              setState(() {
                selectedColor = color;
              });
            },
          ),
        ),
        actions: <Widget>[
          FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Close"))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: ValueListenableBuilder<List<DrawingArea?>?>(
          valueListenable: pointsNotifier,
          builder: (context, v, c) {
            return Stack(
              children: <Widget>[
                Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                        Color.fromRGBO(138, 35, 135, 1.0),
                        Color.fromRGBO(233, 64, 87, 1.0),
                        Color.fromRGBO(242, 113, 33, 1.0),
                      ])),
                ),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: width * 0.80,
                          height: height * 0.80,
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20.0)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.4),
                                  blurRadius: 5.0,
                                  spreadRadius: 1.0,
                                )
                              ]),
                          child: GestureDetector(
                            onPanDown: (details) {
                              pointsNotifier.value =
                                  List.from(pointsNotifier.value!)
                                    ..add(DrawingArea(
                                        point: details.localPosition,
                                        areaPaint: Paint()
                                          // ..strokeCap = StrokeCap.butt
                                          ..style = PaintingStyle.stroke
                                          // ..isAntiAlias = true
                                          ..color = selectedColor!
                                          ..strokeWidth = strokeWidth!));
                              // pointsNotifier.value =
                              //     List.from(pointsNotifier.value!)
                              //       ..add(DrawingArea(
                              //           point: details.localPosition,
                              //           areaPaint: Paint()
                              //             ..strokeCap = StrokeCap.round
                              //             ..isAntiAlias = true
                              //             ..color = selectedColor!
                              //             ..strokeWidth = strokeWidth!));
                            },
                            onPanUpdate: (details) {
                              pointsNotifier
                                  .value = List.from(pointsNotifier.value!)
                                ..add(DrawingArea(
                                    point: details.localPosition,
                                    areaPaint: Paint()
                                      // ..strokeCap = StrokeCap.butt
                                      ..style = PaintingStyle.fill
                                      ..strokeJoin = StrokeJoin.bevel
                                      // ..isAntiAlias = true
                                      ..color = selectedColor!.withOpacity(0.1)
                                      ..strokeWidth = strokeWidth!));
                            },
                            onPanEnd: (details) {
                              pointsNotifier.value =
                                  List.from(pointsNotifier.value!)..add(null);
                            },
                            child: SizedBox.expand(
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(20.0)),
                                child: CustomPaint(
                                  painter: MyCustomPainter(points: v),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: width * 0.80,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0))),
                        child: Row(
                          children: <Widget>[
                            IconButton(
                                icon: Icon(
                                  Icons.color_lens,
                                  color: selectedColor,
                                ),
                                onPressed: () {
                                  selectColor();
                                }),
                            Expanded(
                              child: Slider(
                                min: 1.0,
                                max: 5.0,
                                label: "Stroke $strokeWidth",
                                activeColor: selectedColor,
                                value: strokeWidth!,
                                onChanged: (double value) {
                                  setState(() {
                                    strokeWidth = value;
                                  });
                                },
                              ),
                            ),
                            IconButton(
                                icon: const Icon(
                                  Icons.layers_clear,
                                  color: Colors.black,
                                ),
                                onPressed: () {
                                  pointsNotifier.value =
                                      List.from(pointsNotifier.value!)..clear();
                                }),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }
}

class MyCustomPainter extends CustomPainter {
  List<DrawingArea?>? points;

  MyCustomPainter({@required this.points});

  @override
  void paint(Canvas canvas, Size size) {
    Paint background = Paint()..color = Colors.white;
    Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.drawRect(rect, background);
    canvas.clipRect(rect);

    Path path = Path();
    path.moveTo(points![0]!.point.dx, points![0]!.point.dy);

    for (int x = 0; x < points!.length - 1; x++) {
      if (points![x] != null && points![x + 1] != null) {
        // path.lineTo(
        //   points![x]!.point.dx,
        //   points![x]!.point.dy,
        // );
        // canvas.drawPath(path, points![x]!.areaPaint);
        // canvas.drawPoints(
        //     PointMode.points, [points![x]!.point], points![x]!.areaPaint);
        // canvas.drawLine(
        //     points![x]!.point, points![x + 1]!.point, points![x]!.areaPaint);
      } else if (points![x] != null && points![x + 1] == null) {
        path.lineTo(
          points![x]!.point.dx,
          points![x]!.point.dy,
        );
        canvas.drawPath(path, points![x]!.areaPaint);
        log("x: ${points![x]!.point.dx} - y: ${points![x]!.point.dy}");

        // canvas.drawPoints(
        //     PointMode.points, [points![x]!.point], points![x]!.areaPaint);
      }
    }

    // for (int x = 0; x < points!.length - 1; x++) {
    //   if (points![x] != null && points![x + 1] != null) {
    //     canvas.drawLine(
    //         points![x]!.point, points![x + 1]!.point, points![x]!.areaPaint);
    //   } else if (points![x] != null && points![x + 1] == null) {
    //     canvas.drawPoints(
    //         PointMode.points, [points![x]!.point], points![x]!.areaPaint);
    //   }
    // }
  }

  @override
  bool shouldRepaint(MyCustomPainter oldDelegate) {
    return oldDelegate.points != points;
  }
}


// import 'package:flutter/material.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MyWidget();
//   }
// }

// class MyWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.yellow[100],
//       child: CustomPaint(
//         painter: MyCustomPainter(),
//       ),
//     );
//   }
// }

// // 1
// class MyCustomPainter extends CustomPainter {
//   // 2
//   @override
//   void paint(Canvas canvas, Size size) {
//     // 1
//     Offset startPoint = const Offset(0, 0);
//     // 2
//     Offset endPoint = Offset(size.width, size.height);
//     // 3
//     Paint paint1 = Paint()..color = Colors.red;
//     // 4
//     canvas.drawLine(startPoint, endPoint, paint1);
//     // 1
//     Paint paint = Paint()..style = PaintingStyle.stroke;
//     // 2
//     Path path = Path();
//     // 3
//     path.moveTo(0, 250);
//     path.lineTo(100, 200);
//     path.lineTo(150, 150);
//     path.lineTo(200, 50);
//     path.lineTo(250, 150);
//     path.lineTo(300, 200);
//     path.lineTo(size.width, 250);
//     path.lineTo(0, 250);

//     // 4
//     path.moveTo(100, 100);
//     path.addOval(Rect.fromCircle(center: const Offset(100, 100), radius: 25));

//     // 5
//     canvas.drawPath(path, paint);
//   }

//   // 4
//   @override
//   bool shouldRepaint(MyCustomPainter delegate) {
//     return true;
//   }
// }
