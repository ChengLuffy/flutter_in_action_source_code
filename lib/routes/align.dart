import 'package:flutter/material.dart';

class AlignRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // 此时 Container 指定宽高
        Container(
          height: 120.0,
          width: 120.0,
          color: Colors.blue[50],
          child: Align(
            alignment: Alignment.topRight,
            child: FlutterLogo(
              size: 60,
            ),
          ),
        ),
        Container(
//          height: 120.0,
//          width: 120.0,
          color: Colors.blue[50],
          child: Align(
            // Align 没有直接指定宽高，使用 Factor 意思 Align 的宽度是 ChildWidth * widthFactor
            widthFactor: 2,
            heightFactor: 2,
            // (Alignment.x*childWidth/2+childWidth/2, Alignment.y*childHeight/2+childHeight/2)
            // Alignment(2, 0.0) 用上面的公式计算可得 (90, 30), 以左上为坐标原点
            alignment: Alignment(2, 0.0),
            child: FlutterLogo(
              size: 60,
            ),
          ),
        ),
        Container(
          height: 120.0,
          width: 120.0,
          color: Colors.blue[50],
          child: Align(
            // 实际偏移值，计算公式 (FractionalOffse.x * childWidth, FractionalOffse.y * childHeight)
            alignment: FractionalOffset(0.2, 0.6),
            child: FlutterLogo(
              size: 60,
            ),
          ),
        ),
        // 使用 DecoratedBox 以用 Widget 背景颜色显示 Widget 大小位置
        DecoratedBox(
          decoration: BoxDecoration(color: Colors.red),
          // Center 继承于 Align，相当于对齐方式为 Alignment.center 的 Align
          child: Center(
            child: Text("xxx"),
          ),
        ),
        DecoratedBox(
          decoration: BoxDecoration(color: Colors.red),
          child: Center(
            // 由于制定了大小为 childWidget 大小，所以 Center 不会拉伸
            widthFactor: 1,
            heightFactor: 1,
            child: Text("xxx"),
          ),
        )
      ]
          .map((e) => Padding(padding: EdgeInsets.only(top: 16), child: e))
          .toList(),
    );
  }
}
