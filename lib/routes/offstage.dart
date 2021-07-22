import 'package:flutter/material.dart';

class SpreadWidget extends StatefulWidget {
  SpreadWidget({Key? key}) : super(key: key);

  @override
  _SpreadWidgetState createState() => _SpreadWidgetState();
}

class _SpreadWidgetState extends State<SpreadWidget>
    with TickerProviderStateMixin {
  bool offstage = true;
  bool zhankai = false;
  final _key = GlobalKey();

  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    controller = new AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    animation = new Tween(begin: 0.0, end: 150.0).animate(controller)
      ..addListener(() {
        if (animation.status == AnimationStatus.dismissed &&
            animation.value == 0.0) {
          offstage = !offstage;
        }
        setState(() => {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: _key,
      width: double.maxFinite,
      height: 100,
      child: Stack(
        children: [
          Positioned(
              top: 10,
              left: 20,
              child: Text(
                "展开/收起",
                style: TextStyle(fontSize: 20),
              )),
          Positioned(
            top: 50,
            left: ((animation.value) > 150 ? 150 : animation.value),
            child: Offstage(
              offstage: offstage,
              child: Image.asset(
                "imgs/avatar.png",
                width: 50,
                height: 50,
              ),
            ),
          ),
          Positioned(
            top: 50,
            left: ((animation.value) > 100 ? 100 : animation.value),
            child: Offstage(
              offstage: offstage,
              child: Image.asset(
                "imgs/avatar.png",
                width: 50,
                height: 50,
              ),
            ),
          ),
          Positioned(
            top: 50,
            left: ((animation.value) > 50 ? 50 : animation.value),
            child: Offstage(
              offstage: offstage,
              child: Image.asset(
                "imgs/avatar.png",
                width: 50,
                height: 50,
              ),
            ),
          ),
          Positioned(
            top: 50,
            left: 0,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  zhankai = !zhankai;
                  if (!zhankai) {
                    //展开
                    offstage = !offstage;
                    //启动动画(正向执行)
                    controller.forward();
                  } else {
                    controller.reverse();
                  }
                });
              },
              child: Image.asset(
                "imgs/avatar.png",
                width: 50,
                height: 50,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
