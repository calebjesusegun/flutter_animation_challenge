import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class Challenge4 extends StatefulWidget {
  const Challenge4({Key? key}) : super(key: key);

  @override
  State<Challenge4> createState() => _Challenge4State();
}

class _Challenge4State extends State<Challenge4>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _animationController;
  late final Animation<double> _rotationAnimation;

  Timer? timer;

  List<Offset> offsetValues = [Offset(MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width * 0.5, MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.height * 0.45), Offset(MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width * 0.57, MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.height * 0.465), Offset(MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width * 0.6, MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.height * 0.5), Offset(MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width * 0.57, MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.height * 0.535), Offset(MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width * 0.5, MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.height * 0.55), Offset(MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width * 0.43, MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.height * 0.535), Offset(MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width * 0.4, MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.height * 0.5), Offset(MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width * 0.43, MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.height * 0.465) ];
  int count = 0;
  Offset currentOffsetValue = Offset(MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width * 0.5, MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.height * 0.45);


  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 8800),
      vsync: this,
    )..repeat(reverse: false);

    _rotationAnimation = Tween<double>(begin: 1, end: 0).animate(
      _controller
    );

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    );

    _animationController.repeat();

    Timer.periodic(const Duration(milliseconds: 600), (_){
     if(count == 8){
       setState(() {
         count = 0;
         currentOffsetValue = offsetValues[count];
         count++;
     });
     }else {
       setState(() {
         currentOffsetValue = offsetValues[count];
         count++;
       });
     }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer?.cancel();
    _controller.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: CustomPaint(
          painter: CanvasPainter(),
          child: AnimatedBuilder(
  animation: _controller,
  builder: (context, child) {
    return RotationTransition(
      turns: _rotationAnimation,
      child: CustomPaint(
      painter: ProgressIndicatorPainter(offset: currentOffsetValue),
      ),
      );
  },
),
        ),
      ),
    );
  }
}

class ProgressIndicatorPainter extends CustomPainter {

  Offset offset;
  ProgressIndicatorPainter({required this.offset});

  @override
  void paint(Canvas canvas, Size size) {

    final paint = Paint()
      ..color = const Color(0xff263c70);
    final paint1 = Paint()
      ..color = const Color(0xfffedc2b);

    final circleRadius = size.width * 0.018;

    // for (int i = 0)
    final circlePosition = Offset(size.width * 0.5, size.height * 0.45);
    final circlePosition1 = Offset(size.width * 0.57, size.height * 0.465);
    final circlePosition2 = Offset(size.width * 0.6, size.height * 0.5);
    final circlePosition3 = Offset(size.width * 0.57, size.height * 0.535);
    final circlePosition4 = Offset(size.width * 0.5, size.height * 0.55);
    final circlePosition5 = Offset(size.width * 0.43, size.height * 0.535);
    final circlePosition6 = Offset(size.width * 0.4, size.height * 0.5);
    final circlePosition7 = Offset(size.width * 0.43, size.height * 0.465);


    canvas.drawCircle(circlePosition, circleRadius, paint1);
    canvas.drawCircle(circlePosition1, circleRadius, paint1);
    canvas.drawCircle(circlePosition2, circleRadius, paint1);
    canvas.drawCircle(circlePosition3, circleRadius, paint1);
    canvas.drawCircle(circlePosition4, circleRadius, paint1);
    canvas.drawCircle(circlePosition5, circleRadius, paint1);
    canvas.drawCircle(circlePosition6, circleRadius, paint1);
    canvas.drawCircle(circlePosition7, circleRadius, paint1);

    canvas.drawCircle(offset, circleRadius, paint);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}



class CanvasPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    final path = Path();
    final path1 = Path();
    final path2 = Path();

    final paint = Paint()
      ..color = const Color(0xff263c70);
    final paint1 = Paint()
      ..color = const Color(0xfffedc2b);


    path.lineTo(size.width * 0.4, 0);
    path.lineTo(0, size.height  * 0.55);

    path1.moveTo(size.width * 0.4, 0);
    path1.lineTo(size.width * 0.45, 0);
    path1.lineTo(0, size.height  * 0.61);
    path1.lineTo(0, size.height  * 0.55);

    path2.moveTo(size.width, size.height * 0.45);
    path2.lineTo(size.width, size.height);
    path2.lineTo(size.width * 0.6, size.height);

    path.close();
    path1.close();
    path2.close();

    canvas.drawPath(path, paint);
    canvas.drawPath(path1, paint1);
    canvas.drawPath(path2, paint1);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
  
}
