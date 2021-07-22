import 'package:flutter/material.dart';

class FutureAndStreamBuilderRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FutureAndStreamBuilderRoute();
  }
}

class _FutureAndStreamBuilderRoute extends State<FutureAndStreamBuilderRoute> {
  var t = Future.delayed(Duration(seconds: 3), () => "我是互联网上获取的数据");

  @override
  Widget build(BuildContext context) {
    var _counter = counter();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: FutureBuilder<String>(
            future: t,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              print(snapshot.connectionState);
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                } else {
                  return Text("Contents: ${snapshot.data}");
                }
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ),
        Center(
          child: StreamBuilder<int>(
            stream: _counter,
            builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
              if (snapshot.hasError) return Text("Error: ${snapshot.error}");
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return Text("没有Stream");
                case ConnectionState.waiting:
                  return Text("等待数据。。。");
                case ConnectionState.active:
                  return Text("active: ${snapshot.data}");
                case ConnectionState.done:
                  return Text("Stream已关闭");
              }
            },
          ),
        )
      ],
    );
  }

  Future<String> mockNetworkData() async {
    return Future.delayed(Duration(seconds: 3), () => "我是互联网上获取的数据");
  }

  Stream<int> counter() {
    return Stream.periodic(Duration(seconds: 1), (i) {
      return i;
    });
  }
}
