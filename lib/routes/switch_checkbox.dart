import 'package:flutter/material.dart';

class SwitchAndCheckBoxRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SwitchAndCheckBoxRouteState();
}

class _SwitchAndCheckBoxRouteState extends State<SwitchAndCheckBoxRoute> {
  bool _switchSelected = true;
  bool _checkboxSelected = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: [
            Checkbox(
                value: _checkboxSelected,
                onChanged: (value) {
                  setState(() {
                    _checkboxSelected = value!;
                  });
                }),
            TextButton(
                onPressed: () {
                  setState(() {
                    _checkboxSelected = !_checkboxSelected;
                  });
                },
                child: Text(_checkboxSelected ? "选中" : "未选中")),
          ],
        ),
        Row(
          children: [
            Switch(
                value: _switchSelected,
                onChanged: (value) {
                  setState(() {
                    _switchSelected = value;
                  });
                }),
            Text(_switchSelected ? "开" : "关")
          ],
        )
      ],
    );
  }
}
