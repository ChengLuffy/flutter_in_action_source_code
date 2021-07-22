import 'package:flutter/material.dart';

class StaggerRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _StaggerRouteState();
}

class _StaggerRouteState extends State<StaggerRoute>
    with TickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 2000));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _playAnimation() async {
    try {
      await _animationController.forward().orCancel;
      await _animationController.reverse().orCancel;
    } on TickerCanceled {
      print("animation canceled");
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => _playAnimation(),
      child: Center(
        child: Container(
          width: 300.0,
          height: 300.0,
          child: StaggerAnimation(
            animationController: _animationController,
          ),
          decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.1),
              border: Border.all(color: Colors.black.withOpacity(0.5))),
        ),
      ),
    );
  }
}

class StaggerAnimation extends StatelessWidget {
  final AnimationController animationController;
  late Animation<double> heightAnimation;
  late Animation<EdgeInsets> paddingAnimation;
  late Animation<Color?> colorAnimation;

  StaggerAnimation({Key? key, required this.animationController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: animationController, builder: _buildAnimation);
  }

  Widget _buildAnimation(BuildContext context, Widget? child) {
    heightAnimation = Tween<double>(begin: 0.0, end: 300.0).animate(
        CurvedAnimation(
            parent: animationController,
            curve: Interval(0.0, 0.6, curve: Curves.ease)));
    colorAnimation = ColorTween(begin: Colors.green, end: Colors.red).animate(
        CurvedAnimation(
            parent: animationController,
            curve: Interval(0.0, 0.6, curve: Curves.ease)));
    paddingAnimation = Tween<EdgeInsets>(
            begin: EdgeInsets.only(left: 0.0),
            end: EdgeInsets.only(left: 100.0))
        .animate(CurvedAnimation(
            parent: animationController,
            curve: Interval(0.6, 1.0, curve: Curves.ease)));
    return Container(
      alignment: Alignment.bottomCenter,
      padding: paddingAnimation.value,
      child: Container(
        color: colorAnimation.value,
        width: 50.0,
        height: heightAnimation.value,
      ),
    );
  }
}
