import 'package:flutter/material.dart';
import 'package:flutter_in_action_source_code/widgets/turn_box.dart';

class TurnBoxRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TurnBixRouteStatue();
}

class _TurnBixRouteStatue extends State<TurnBoxRoute> {
  double _turns = .0;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          TurnBox(
            child: Icon(
              Icons.refresh,
              size: 50,
            ),
            turns: _turns,
            speed: 500,
          ),
          TurnBox(
            child: Icon(
              Icons.refresh,
              size: 150,
            ),
            turns: _turns,
            speed: 1000,
          ),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  _turns += .2;
                });
              },
              child: Text("顺时针旋转1/5圈")),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  _turns -= .2;
                });
              },
              child: Text("逆时针旋转1/5圈")),
        ],
      ),
    );
  }
}
