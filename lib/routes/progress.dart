import 'package:flutter/material.dart';

class ProgressRoute extends StatefulWidget {
  @override
  _ProgressRouteState createState() => _ProgressRouteState();
}

class _ProgressRouteState extends State<ProgressRoute>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    _animationController.forward();
    _animationController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          LinearProgressIndicator(
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation(Colors.blue),
          ),
          LinearProgressIndicator(
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation(Colors.blue),
            value: 0.5,
          ),
          SizedBox(
            height: 10,
            child: LinearProgressIndicator(
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation(Colors.blue),
              value: 0.5,
            ),
          ),
          SizedBox(
            height: 100,
            width: 130,
            child: CircularProgressIndicator(
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation(Colors.blue),
              value: 0.7,
            ),
          ),
          CircularProgressIndicator(
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation(Colors.blue),
            value: 0.5,
          ),
          LinearProgressIndicator(
            backgroundColor: Colors.grey[200],
            valueColor: ColorTween(begin: Colors.grey, end: Colors.blue)
                .animate(_animationController),
            value: _animationController.value,
          ),
          CircularProgressIndicator(
            backgroundColor: Colors.grey[200],
            valueColor: ColorTween(begin: Colors.grey, end: Colors.blue)
                .animate(_animationController),
            value: _animationController.value,
          ),
          CircularProgressIndicator(
            backgroundColor: Colors.grey[200],
            valueColor: ColorTween(begin: Colors.grey, end: Colors.blue)
                .animate(_animationController),
          )
        ]
            .map((e) => Padding(
                  padding: EdgeInsets.all(18),
                  child: e,
                ))
            .toList(),
      ),
    );
  }
}
