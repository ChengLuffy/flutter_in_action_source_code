import 'package:flutter/material.dart';

class PointerRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Listener(
          child: ConstrainedBox(
            constraints: BoxConstraints.tight(Size(300, 300)),
            child: DecoratedBox(
              decoration: BoxDecoration(color: Colors.blue),
            ),
          ),
          onPointerDown: (event) => print("down0: $event"),
        ),
        Listener(
          child: ConstrainedBox(
            constraints: BoxConstraints.tight(Size(200, 100)),
            child: Center(
              child: Text("左上角200*100范围内非文本区域点击"),
            ),
          ),
          onPointerDown: (event) => print("down1: $event"),
          // behavior: HitTestBehavior.translucent, //放开此行注释后可以"点透"
          // behavior: HitTestBehavior.opaque, // 放开此行后只会打印"down1"
        )
      ],
    );
  }
}
