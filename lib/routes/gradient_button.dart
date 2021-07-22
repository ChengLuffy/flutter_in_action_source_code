import 'package:flutter/material.dart';
import 'package:flutter_in_action_source_code/widgets/gradient_button.dart';

class GradientButtonRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _GradientButtonRouteState();
}

class _GradientButtonRouteState extends State<GradientButtonRoute> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          GradientButton(
            child: Text("Submit"),
            colors: [Colors.orange, Colors.red],
            height: 50,
            borderRadius: BorderRadius.all(Radius.circular(20)),
            onPressed: onTap,
          ),
          GradientButton(
            height: 50.0,
            colors: [Colors.lightGreen, Colors.green[700]!],
            child: Text("Submit"),
            onPressed: onTap,
          ),
          GradientButton(
            height: 50.0,
            colors: [Colors.lightBlue[300]!, Colors.blueAccent],
            child: Text("Submit"),
            onPressed: onTap,
          ),
        ],
      ),
    );
  }

  onTap() {
    print("button click");
  }
}
