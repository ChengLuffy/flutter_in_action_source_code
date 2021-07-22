import 'package:flutter/material.dart';

class ScaleAnimationRoute2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ScaleAnimationRoute2State();
}

class _ScaleAnimationRoute2State extends State<ScaleAnimationRoute2>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    _animation = Tween(begin: 0.0, end: 300.0).animate(_animationController);
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animation,
        child: Image.asset("imgs/avatar.png"),
        builder: (BuildContext context, Widget? child) {
          return Center(
            child: Container(
              width: _animation.value,
              height: _animation.value,
              child: child,
            ),
          );
        });
  }
}
