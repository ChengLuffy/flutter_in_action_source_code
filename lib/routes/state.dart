import 'package:flutter/material.dart';
import 'package:flutter_in_action_source_code/widgets/base_app_bar.dart';

// 由于 Flutter 版本迁移，showSnackBar 方法已更改为 ScaffoldMessager 调用
class RetrieveStateRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarTool.initBar("子树中获取State对象"),
        body: Center(
          child: Builder(builder: (context) {
            return ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context)
                    ..showSnackBar(SnackBar(content: Text('我是SnackBar')));
                },
                child: Text('显示SnackBar'));
          }),
        ));
  }
}
