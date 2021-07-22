import 'package:flutter/material.dart';
import 'package:flutter_in_action_source_code/routes/form.dart';

class FocusTestRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FocusTestRouteState();
}

class _FocusTestRouteState extends State<FocusTestRoute> {
  FocusNode _focusNode1 = new FocusNode();
  FocusNode _focusNode2 = new FocusNode();
  TextEditingController _controller1 = TextEditingController();
  String _str = "默认值";
  late TextEditingController _controller2 = TextEditingController(text: _str);

  @override
  void initState() {
    super.initState();
    _controller1.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Text("输入文本为：" + _controller1.text),
          TextField(
            autofocus: true,
            controller: _controller1,
            focusNode: _focusNode1,
            decoration: InputDecoration(labelText: 'Input1'),
          ),
          Text("输入文本为：" + _str),
          TextField(
            controller: _controller2,
            focusNode: _focusNode2,
            decoration: InputDecoration(labelText: 'Input2'),
            onChanged: (text) {
              setState(() {
                _str = text;
              });
            },
          ),
          Builder(
            builder: (context) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        FocusScope.of(context).requestFocus(
                            _focusNode1.hasFocus ? _focusNode2 : _focusNode1);
                      },
                      child: Text('移动焦点')),
                  Container(
                    width: 18,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        _focusNode1.unfocus();
                        _focusNode2.unfocus();
                      },
                      child: Text('隐藏键盘')),
                  Container(
                    width: 18,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        FocusScope.of(context).requestFocus(_focusNode1);
                        setState(() {
                          _controller1.text = "测试选中";
                          _controller1.selection =
                              TextSelection(baseOffset: 2, extentOffset: 4);
                        });
                      },
                      child: Text('选中'))
                ],
              );
            },
          ),
          Text("自定义下划线颜色"),
          TextField(
            decoration: InputDecoration(
                labelText: '用户名',
                hintText: '请输入用户名',
                prefixIcon: Icon(Icons.person),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.red))),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return FormTestRoute();
                    }));
                  },
                  child: Text('Form表单'))
            ],
          )
        ],
      ),
    );
  }
}
