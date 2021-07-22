import 'package:flutter/material.dart';
import 'package:flutter_in_action_source_code/widgets/base_app_bar.dart';

class RouterTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: ElevatedButton(
      onPressed: () async {
        var result =
            await Navigator.push(context, MaterialPageRoute(builder: (context) {
          return TipRoute(text: '我是提示XXX');
        }));
        print("路由返回值：$result");
      },
      child: Text('打开提示页'),
    ));
  }
}

class TipRoute extends StatelessWidget {
  final String text;
  TipRoute({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarTool.initBar("提示"),
      body: Padding(
        padding: EdgeInsets.all(18),
        child: Center(
          child: Column(
            children: [
              Text(text),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, '我是返回值');
                },
                child: Text('返回'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
