import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_in_action_source_code/widgets/base_app_bar.dart';

class ScaleAnimationRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ScaleAnimationRoute();
}

class _ScaleAnimationRoute extends State<ScaleAnimationRoute>
    with SingleTickerProviderStateMixin {
  late CurvedAnimation _curvedAnimation;
  late Animation<double> _animation;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    _curvedAnimation =
        CurvedAnimation(parent: _animationController, curve: Curves.linear);
    _animation = Tween(begin: 0.0, end: 300.0).animate(_curvedAnimation)
      ..addListener(() {
        setState(() {});
      });
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        title: Text("放大动画-原始版"),
        actions: [
          IconButton(
              onPressed: () async {
                int index = await _showAnimationOptions() ?? 0;
                _changeAnimationOptions(index);
              },
              icon: Icon(Icons.menu))
        ],
      ),
      body: Center(
        child: Image.asset(
          "imgs/avatar.png",
          width: _animation.value,
          height: _animation.value,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: () async {
          await _animationController.reverse();
          _animationController.forward();
        },
      ),
    );
  }

  void _changeAnimationOptions(int index) {
    switch (index) {
      case 0:
        _curvedAnimation.curve = Curves.linear;
        break;
      case 1:
        _curvedAnimation.curve = Curves.decelerate;
        break;
      case 2:
        _curvedAnimation.curve = Curves.fastLinearToSlowEaseIn;
        break;
      case 3:
        _curvedAnimation.curve = Curves.ease;
        break;
      case 4:
        _curvedAnimation.curve = Curves.easeIn;
        break;
      case 5:
        _curvedAnimation.curve = Curves.easeOut;
        break;
      case 6:
        _curvedAnimation.curve = Curves.fastOutSlowIn;
        break;
      case 7:
        _curvedAnimation.curve = Curves.slowMiddle;
        break;
      case 8:
        _curvedAnimation.curve = Curves.bounceIn;
        break;
      case 9:
        _curvedAnimation.curve = Curves.bounceOut;
        break;
      case 10:
        _curvedAnimation.curve = Curves.bounceIn;
        break;
    }
    _animationController.reset();
    Future.delayed(Duration(milliseconds: 750), () {
      _animationController.forward();
    });
  }

  Future<int?> _showAnimationOptions() async {
    var itemNames = [
      "linear",
      "decelerate",
      "fastLinearToSlowEaseIn",
      "ease",
      "easeIn",
      "easeOut",
      "fastOutSlowIn",
      "slowMiddle",
      "bounceIn",
      "bounceOut",
      "bounceInOut"
    ];
    return showModalBottomSheet<int>(
        context: context,
        builder: (BuildContext context) {
          return ListView.builder(
              itemCount: itemNames.length,
              itemBuilder: (BuildContext ctx, int index) {
                return ListTile(
                  title: Text(itemNames[index]),
                  onTap: () => Navigator.of(context).pop(index),
                );
              });
        });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
