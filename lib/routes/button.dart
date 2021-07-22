import 'package:flutter/material.dart';

class ButtonRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ButtonRouteState();
}

class _ButtonRouteState extends State<ButtonRoute> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        // 背景填充
        ElevatedButton(
            onPressed: _onPressed, child: Text('ElevatedButton-normal')),
        // 边框线
        OutlinedButton(
            onPressed: _onPressed, child: Text('OutlinedButton-normal')),
        // 图标
        IconButton(onPressed: _onPressed, icon: Icon(Icons.thumb_up)),
        // 文字
        TextButton(
            onPressed: _onPressed,
            child: Text('Submit'),
            style: ButtonStyle(
                // 文字颜色
                foregroundColor: MaterialStateProperty.all(Colors.white),
                // 背景颜色
                backgroundColor: MaterialStateProperty.all(Colors.blue),
                // 高亮颜色
                overlayColor: MaterialStateProperty.all(Colors.blue[700]),
                // 形状
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20))),
                // 内边距
                padding: MaterialStateProperty.all(
                    EdgeInsets.only(left: 20, right: 20)))),
        // 其他按钮带 icon 的方法
        ElevatedButton.icon(
            onPressed: _onPressed, icon: Icon(Icons.send), label: Text('send')),
        OutlinedButton.icon(
            onPressed: _onPressed, icon: Icon(Icons.add), label: Text('add')),
        TextButton.icon(
            onPressed: _onPressed, icon: Icon(Icons.info), label: Text('info'))
      ],
    );
  }

  void _onPressed() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("按钮被点击"),
    ));
  }
}
