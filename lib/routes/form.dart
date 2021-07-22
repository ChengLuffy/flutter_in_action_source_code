import 'package:flutter/material.dart';
import 'package:flutter_in_action_source_code/widgets/base_app_bar.dart';

class FormTestRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FormTestRouteState();
}

class _FormTestRouteState extends State<FormTestRoute> {
  TextEditingController _userController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();
  GlobalKey _formKey = GlobalKey();
  String _info = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarTool.initBar("表单输入"),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: <Widget>[
              TextFormField(
                autofocus: true,
                controller: _userController,
                decoration: InputDecoration(
                    labelText: "用户名",
                    hintText: "请输入用户名",
                    icon: Icon(Icons.person)),
                validator: (text) {
                  if (text == null) {
                    return "用户名不能为空";
                  }
                  return text.trim().length > 0 ? null : "用户名不能为空";
                },
              ),
              TextFormField(
                obscureText: true,
                controller: _pwdController,
                decoration: InputDecoration(
                    labelText: "密码",
                    hintText: "请输入密码",
                    icon: Icon(Icons.password)),
                validator: (text) {
                  if (text == null) {
                    return "密码不能为空";
                  }
                  return text.trim().length > 5 ? null : "密码最少为6位";
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 28),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: ElevatedButton(
                        style: ButtonStyle(
                            padding:
                                MaterialStateProperty.all(EdgeInsets.all(10))),
                        child: Text('登录'),
                        onPressed: () {
                          if ((_formKey.currentState as FormState).validate()) {
                            setState(() {
                              _info = "用户名：" +
                                  _userController.text +
                                  "\n密码：" +
                                  _pwdController.text;
                            });
                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
              Text("输入内容为：\n" + _info)
            ],
          ),
        ),
      ),
    );
  }
}
