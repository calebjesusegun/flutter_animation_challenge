import 'dart:math';

import 'package:flutter/material.dart';

extension on VoidCallback {
  Future<void> delayed(Duration duration) => Future.delayed(duration, this);
}

class Challenge2 extends StatefulWidget {
  const Challenge2({Key? key}) : super(key: key);

  @override
  State<Challenge2> createState() => _Challenge2State();
}

class _Challenge2State extends State<Challenge2>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late final Animation<AlignmentGeometry> _alignAnimation;
  late final Animation<double> _rotationAnimation;
  late Animation<Color?> _animation2;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    )..repeat(reverse: true);

    _alignAnimation = Tween<AlignmentGeometry>(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOutCubic,
      ),
    );

    _rotationAnimation = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: _controller,
        // curve: Curves.easeInOutCubic,
        curve: Curves.ease,
      ),
    );

    _animation2 = ColorTween(
      end: const Color(0xffadf802),
      begin: const Color(0xff107b79),
    ).animate(_controller)
      ..addListener(() {
        Future.delayed(const Duration(seconds: 1), () => setState(() {}));
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: SizedBox(
          height: size.height,
          width: size.width / 1.1,
          child: AlignTransition(
            alignment: _alignAnimation,
            child: RotationTransition(
              turns: _rotationAnimation,
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: _animation2.value!,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 0,
                      blurRadius: 0,
                      offset: const Offset(0, 2),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(
                    (_rotationAnimation.value < 0.3
                        ? 16
                        : _rotationAnimation.value * 80),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
