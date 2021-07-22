import 'package:flutter/material.dart';

class AnimatedSwitcherCounterRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AnimatedSwitcherCounterRouteState();
}

class _AnimatedSwitcherCounterRouteState
    extends State<AnimatedSwitcherCounterRoute> {
  int _count = 0;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // AnimatedSwitcher在2个或者多个子组件之间切换时使用动画
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 400),
            transitionBuilder: (widget, animation) {
              // ScaleTransition 缩放动画 同样的还有 FadeTransiton 渐隐渐显动画 RotationTransition 旋转动画
              return ScaleTransition(
                scale: animation,
                child: widget,
              );
              // return FadeTransition(
              //   opacity: animation,
              //   child: widget,
              // );
              // return RotationTransition(
              //   turns: animation,
              //   child: widget,
              // );
            },
            child: Text(
              "$_count",
              key: ValueKey(_count),
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  _count += 1;
                });
              },
              child: const Text("+1"))
        ],
      ),
    );
  }
}
