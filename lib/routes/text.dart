import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TextRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TextRouteState();
}

class _TextRouteState extends State<TextRoute> {
  late TapGestureRecognizer _tapGestureRecognizer;

  @override
  void initState() {
    _tapGestureRecognizer = TapGestureRecognizer();
    _tapGestureRecognizer.onTapUp = (details) {
      print(details);
    };
    super.initState();
  }

  @override
  void dispose() {
    _tapGestureRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        // 排除 crossAxisAlignment 默认 Center 对文本对齐方式的干扰
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Hello world',
            textAlign: TextAlign.center,
          ),
          Text(
            "Hello world, I'm jack!" * 4,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            'Hello world',
            textScaleFactor: 1.5,
          ),
          Text(
            'Hello world' * 6,
            textAlign: TextAlign.center,
          ),
          Text(
            'Hello world',
            style: TextStyle(
                color: Colors.blue,
                fontSize: 18.0,
                height: 1.2,
                fontFamily: 'Courier',
                background: new Paint()..color = Colors.yellow,
                decoration: TextDecoration.underline,
                decorationStyle: TextDecorationStyle.dashed),
          ),
          Text.rich(TextSpan(children: [
            TextSpan(
                text: 'Home: ',
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    decorationStyle: TextDecorationStyle.wavy)),
            TextSpan(
                text: 'https://pi.chengluffy.tech',
                style: TextStyle(color: Colors.blue),
                recognizer: _tapGestureRecognizer),
          ])),
          DefaultTextStyle(
              style: TextStyle(color: Colors.red, fontSize: 20.0),
              textAlign: TextAlign.start,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Hello world'),
                  Text("I'm jack"),
                  Text(
                    "I'm jack",
                    style: TextStyle(inherit: false, color: Colors.green),
                  )
                ],
              ))
        ],
      ),
    );
  }
}
