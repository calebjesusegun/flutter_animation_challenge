import 'dart:math';

import 'package:flutter/material.dart';

class Challenge1 extends StatefulWidget {
  const Challenge1({Key? key}) : super(key: key);

  @override
  State<Challenge1> createState() => _Challenge1State();
}

class _Challenge1State extends State<Challenge1> {

  double sliderValue = 0.1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF3C3B32),
        body: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Slider(
                inactiveColor: Color(0xFFE3D544).withOpacity(0.1),
                activeColor: Color(0xFFE3D544),
                value: sliderValue,
                onChanged: (v){
                  setState(() {
                    if (v == 0){
                      sliderValue = 0.005;
                    } else {
                      sliderValue = v;
                    }
                    // print((sliderValue * 100).round());
                    // print(sliderValue);
                  });
                },
              ),
              SizedBox(
                width: 300,
                height: 300,
                child: CustomPaint(
                  painter: ProgressIndicatorPainter(
                    progress: sliderValue,
                  ),
                ),
              ),
            ],
          ),
        ),
    );
  }
}

class ProgressIndicatorPainter extends CustomPainter {
  ProgressIndicatorPainter({required this.progress});

  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    double centerX = size.width / 2;
    double centerY = size.height / 2;
    var radius = min(centerX, centerY);

    var center = Offset(centerX, centerX);
    var fillBrush = Paint()..color = const Color(0xFF3C3B32);

    var outlineBrush = Paint()
      ..color = const Color(0xff34332D)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 50;

    double convertRadiusToSigma(double radius) {
      return radius * 0.57735 + 0.5;
    }

    final arcPaint = Paint()
      ..color = const Color(0xFFE3D544)
      ..strokeWidth = 70
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 1)
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(center, radius - 40, fillBrush);
    canvas.drawCircle(center, radius - 40, outlineBrush);


    canvas.drawArc(Rect.fromCircle(center: center, radius: radius - 40),
        - pi / 2, - 2 * pi * progress , false, arcPaint);

    // final path = Path()..addRRect(shape);
    //
    // // Draw the shadow before the path.
    // // shadow color: grey
    // // elevation: 10
    // // opaque object
    // canvas.drawShadow(path, Colors.grey, 10, false);
    // canvas.drawPath(path, Paint()..color = Colors.pink);
    //
    // canvas.drawShadow(path.shift(center), Colors.black, 22.0, true);

  }

  @override
  bool shouldRepaint(covariant ProgressIndicatorPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}