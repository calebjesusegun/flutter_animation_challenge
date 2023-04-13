import 'dart:math';
import 'package:flutter/material.dart';

class Challenge3 extends StatefulWidget {
  const Challenge3({Key? key}) : super(key: key);

  @override
  State<Challenge3> createState() => _Challenge3State();
}

const widthAndHeight = 150.0;

class _Challenge3State extends State<Challenge3> with TickerProviderStateMixin {

  //FIRST BOX ON TOP
  late AnimationController _controller;
  late AnimationController _controller1;
  late Animation<double> _animation;
  late Animation<Color?> _animationColor;

  //SECOND BOX ON TOP
  late AnimationController _controller3;
  late Animation<double> _animation1;
  late Animation<Color?> _animationColor1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //FIRST BOX ON TOP
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );

    _controller1 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    _animation = Tween<double>(
      begin: 0,
      end: pi * 2,
    ).animate(_controller1);

    _animationColor = ColorTween(
      begin: const Color(0xffc1c605),
      end: const Color(0xfff59c05),
    ).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOutBack))
      ..addListener(() {
        setState(() {});
      });

    //SECOND BOX ON TOP
    _controller3 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    _animation1 = Tween<double>(
      begin: 0,
      end: -pi * 2,
    ).animate(_controller3);

    _animationColor1 = ColorTween(
      begin: const Color(0xffee6217),
      end: Colors.red,
    ).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOutBack))
      ..addListener(() {
        setState(() {});
      });

    //COLOR TWEEN CONTROLLER
    _controller..forward..repeat(reverse: true);

    //FIRST BOX ON TOP
    _controller1..forward..repeat(reverse: false);

    //SECOND BOX ON TOP
    _controller3..forward..repeat(reverse: false);

  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
    _controller1.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Align(
          alignment: Alignment.center,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Stack(
                children: [
                  AnimatedBuilder(
                    builder: (BuildContext context, Widget? child) {
                      return Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.identity()..rotateZ(_animation1.value),
                        child: Container(
                          width: widthAndHeight,
                          height: widthAndHeight,
                          decoration: BoxDecoration(
                              color: _animationColor1.value!,
                              borderRadius: BorderRadius.circular(24),),
                        ),
                      );
                    },
                    animation: _controller3,
                  ),
                  AnimatedBuilder(
                      animation: _controller1,
                      builder: (BuildContext context, Widget? child) {
                        return Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.identity()
                            ..rotateZ(_animation.value),
                          child: Container(
                            width: widthAndHeight,
                            height: widthAndHeight,
                            decoration: BoxDecoration(
                                color: _animationColor.value!,
                                borderRadius: BorderRadius.circular(24)),
                          ),
                        );
                      }),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: size.height * 0.12,),
                child: Transform.rotate(
                        angle: pi / 4,
                        child: Container(
                          width: widthAndHeight,
                          height: widthAndHeight,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                ),
              ),

              Container(
                margin: EdgeInsets.only(top: size.height * 0.13,),
                child: const Text(
                  "Working",
                  style: TextStyle(
                      color: Color(0xff444958),
                      letterSpacing: 1.7,
                      fontSize: 28,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
