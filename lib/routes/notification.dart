import 'package:flutter/material.dart';

class NotificationRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NotificationRouteState();
}

class _NotificationRouteState extends State<NotificationRoute> {
  String _msg = "";

  @override
  Widget build(BuildContext context) {
    return NotificationListener<MyNotification>(
      onNotification: (notification) {
        setState(() {
          _msg += notification.msg + "  ";
        });
        return false;
      },
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
                onPressed: () => MyNotification("Hi").dispatch(context),
                child: Text("Send Notification")),
            Builder(builder: (BuildContext ctx) {
              return ElevatedButton(
                  onPressed: () => MyNotification("Hi").dispatch(ctx),
                  child: Text("Sned Notification 1"));
            }),
            Text(_msg)
          ],
        ),
      ),
    );
  }
}

class MyNotification extends Notification {
  final String msg;
  MyNotification(this.msg);
}
