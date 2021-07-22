import 'package:flutter/material.dart';

class AnimatedSwitcherRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AnimatedSwitcherRouteState();
}

class _AnimatedSwitcherRouteState extends State<AnimatedSwitcherRoute> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          AnimatedSwitcher(
            duration: Duration(milliseconds: 600),
            transitionBuilder: (Widget child, Animation<double> animation) {
              var tween = Tween<Offset>(begin: Offset(1, 0), end: Offset(0, 0));
              // return MySlideTransition(child,
              //     position: tween.animate(animation));
              return SlideTransitionX(
                child,
                position: animation,
                direction: AxisDirection.down,
              );
            },
            child: Text(
              "$_count",
              key: ValueKey(_count),
              textScaleFactor: 3,
            ),
          ),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  _count += 1;
                });
              },
              child: const Text(
                'Increment',
              ))
        ],
      ),
    );
  }
}

/// 实现横向切换组件动画
/// 由于 AnimatedWidget 在切换时其实就是一个反向动画一个正向动画，所以我们需要更改其反向操作时的动画位置才能实现横向平移动画
class MySlideTransition extends AnimatedWidget {
  final Widget child;
  final bool transformHitTests;
  Animation<Offset> get position => listenable as Animation<Offset>;
  MySlideTransition(this.child,
      {Key? key,
      required Animation<Offset> position,
      this.transformHitTests = true})
      : super(key: key, listenable: position);

  @override
  Widget build(BuildContext context) {
    Offset offset = position.value;
    if (position.status == AnimationStatus.reverse) {
      offset = Offset(-offset.dx, offset.dy);
    }
    return FractionalTranslation(
      translation: offset,
      transformHitTests: transformHitTests,
      child: child,
    );
  }
}

/// 基于上面的实现，进一步封装可指定动画方向
class SlideTransitionX extends AnimatedWidget {
  Animation<double> get position => listenable as Animation<double>;
  final bool transformHitTests;
  final Widget child;
  final AxisDirection direction;
  late final Tween<Offset> tween;

  SlideTransitionX(this.child,
      {Key? key,
      required Animation<double> position,
      this.transformHitTests = true,
      this.direction = AxisDirection.down})
      : super(key: key, listenable: position) {
    switch (direction) {
      case AxisDirection.up:
        tween = Tween(begin: Offset(0, 1), end: Offset(0, 0));
        break;
      case AxisDirection.right:
        tween = Tween(begin: Offset(-1, 0), end: Offset(0, 0));
        break;
      case AxisDirection.down:
        tween = Tween(begin: Offset(0, -1), end: Offset(0, 0));
        break;
      case AxisDirection.left:
        tween = Tween(begin: Offset(1, 0), end: Offset(0, 0));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    Offset offset = tween.evaluate(position);
    if (position.status == AnimationStatus.reverse) {
      switch (direction) {
        case AxisDirection.up:
          offset = Offset(offset.dx, -offset.dy);
          break;
        case AxisDirection.right:
          offset = Offset(-offset.dx, offset.dy);
          break;
        case AxisDirection.down:
          offset = Offset(offset.dx, -offset.dy);
          break;
        case AxisDirection.left:
          offset = Offset(-offset.dx, offset.dy);
          break;
      }
    }
    return FractionalTranslation(
      translation: offset,
      transformHitTests: transformHitTests,
      child: child,
    );
  }
}
