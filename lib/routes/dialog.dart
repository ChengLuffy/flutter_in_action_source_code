import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogTestRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DialogRouteState();
}

class _DialogRouteState extends State<DialogTestRoute> {
  bool _withTree = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ElevatedButton(
              onPressed: () async {
                bool? deleteTree = await showDeleteConfirmDialog1();
                if (deleteTree == null) {
                  print("取消删除");
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text("取消删除")));
                } else {
                  print("已确认删除");
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text("已确认删除")));
                }
              },
              child: Text("对话框1")),
          ElevatedButton(
              onPressed: () async {
                bool? delete = await showDeleteConfirmDialog2();
                if (delete == null) {
                  print("取消删除");
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text("取消删除")));
                } else {
                  print("同时删除子目录: $delete");
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("同时删除子目录: $delete")));
                }
              },
              child: Text("对话框2")),
          ElevatedButton(
              onPressed: () async {
                bool? delete = await showDeleteConfirmDialog3();
                if (delete == null) {
                  print("取消删除");
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text("取消删除")));
                } else {
                  print("同时删除子目录: $delete");
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("同时删除子目录: $delete")));
                }
              },
              child: Text("对话框3（复选框可点击）")),
          ElevatedButton(
              onPressed: () async {
                bool? delete = await showDeleteConfirmDialog3x();
                if (delete == null) {
                  print("取消删除");
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text("取消删除")));
                } else {
                  print("同时删除子目录: $delete");
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("同时删除子目录: $delete")));
                }
              },
              child: Text("对话框4（复选框可点击）")),
          ElevatedButton(
              onPressed: () async {
                bool? delete = await showDeleteConfirmDialog4();
                if (delete == null) {
                  print("取消删除");
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text("取消删除")));
                } else {
                  print("同时删除子目录: $delete");
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("同时删除子目录: $delete")));
                }
              },
              child: Text("对话框5（复选框可点击）")),
          ElevatedButton(onPressed: changeLanguage, child: Text("选择语言")),
          ElevatedButton(
            child: Text("显示列表对话框"),
            onPressed: () {
              showListDialog();
            },
          ),
          ElevatedButton(
            child: Text("自定义对话框"),
            onPressed: () async {
              bool? deleteTree = await showDeleteConfirmDialog5();
              if (deleteTree == null) {
                print("取消删除");
              } else {
                print("已确认删除");
              }
            },
          ),
          ElevatedButton(
            child: Text("显示底部菜单列表(模态)"),
            onPressed: () async {
              int? type = await _showModalBottomSheet();
              print(type);
            },
          ),
          ElevatedButton(
            child: Text("显示底部菜单列表(非模态)"),
            onPressed: () {
              _showBottomSheet();
            },
          ),
          ElevatedButton(
            child: Text("显示Loading框"),
            onPressed: () {
              showLoadingDialog();
            },
          ),
          ElevatedButton(
            child: Text("打开Material风格的日历选择框"),
            onPressed: () {
              _showDatePicker1();
            },
          ),
          ElevatedButton(
            child: Text("打开iOS风格的日历选择框"),
            onPressed: () {
              _showDatePicker2();
            },
          ),
        ],
      ),
    );
  }

  Future<bool?> showDeleteConfirmDialog1() {
    return showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("提示"),
            content: Text("你确定删除文件吗？"),
            actions: buildActions(),
          );
        });
  }

  Future<bool?> showDeleteConfirmDialog2() {
    _withTree = false;
    return showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("提示"),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("您确定要删除当前文件吗？"),
                Row(
                  children: [
                    Text("同时删除子目录?"),
                    Checkbox(
                        value: _withTree,
                        onChanged: (bool? value) {
                          print("checkbox: $value");
                          setState(() {
                            _withTree = value!;
                          });
                        })
                  ],
                )
              ],
            ),
            actions: buildActions(),
          );
        });
  }

  Future<bool?> showDeleteConfirmDialog3() {
    _withTree = false;
    return showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("提示"),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("您确定要删除当前文件吗？"),
                Row(
                  children: [
                    Text("同时删除子目录?"),
                    DialogCheckbox(
                        value: _withTree,
                        onChanged: (bool? value) {
                          print("checkbox: $value");
                          setState(() {
                            _withTree = !_withTree;
                          });
                        })
                  ],
                )
              ],
            ),
            actions: buildActions(),
          );
        });
  }

  Future<bool?> showDeleteConfirmDialog3x() {
    _withTree = false;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("提示"),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("您确定要删除当前文件吗？"),
                Row(
                  children: [
                    Text("同时删除子目录？"),
                    StatefulBuilder(builder: (context, _setState) {
                      return Checkbox(
                          value: _withTree,
                          onChanged: (checkboxValue) {
                            _setState(() {
                              _withTree = checkboxValue!;
                            });
                          });
                    })
                  ],
                )
              ],
            ),
            actions: buildActions(),
          );
        });
  }

  Future<bool?> showDeleteConfirmDialog4() {
    _withTree = false;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("提示"),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("您确定要删除当前文件吗?"),
                Row(
                  children: [
                    Text("同时删除子目录？"),
                    Builder(builder: (BuildContext context) {
                      return Checkbox(
                          value: _withTree,
                          onChanged: (checkboxValue) {
                            (context as Element).markNeedsBuild();
                            _withTree = checkboxValue!;
                          });
                    })
                  ],
                )
              ],
            ),
            actions: buildActions(),
          );
        });
  }

  Future<bool?> showDeleteConfirmDialog5() {
    _withTree = false;
    return showCustomDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("提示"),
            content: Text("您确定要删除当前文件吗?"),
            actions: <Widget>[
              TextButton(
                child: Text("取消"),
                onPressed: () => Navigator.of(context).pop(),
              ),
              TextButton(
                child: Text("删除"),
                onPressed: () {
                  // 执行删除操作
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          );
        });
  }

  void changeLanguage() async {
    int? i = await showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: Text("请选择语言"),
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(0);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Text(
                    "中国汉语",
                    style: TextStyle(color: Colors.black38),
                  ),
                ),
                style: ButtonStyle(
                    backgroundColor: MaterialStateColor.resolveWith(
                        (states) => Colors.grey[200]!)),
              ),
              SimpleDialogOption(
                  onPressed: () {
                    Navigator.of(context).pop(1);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Text("美国英语"),
                  ))
            ],
          );
        });
    switch (i) {
      case 0:
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("中国简体")));
        break;
      case 1:
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("美国英语")));
        break;
      default:
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("未选择")));
        break;
    }
  }

  showListDialog() async {
    int? i = await showDialog<int>(
        context: context,
        builder: (BuildContext context) {
          var child = Column(
            children: <Widget>[
              ListTile(
                title: Text("请选择"),
              ),
              Expanded(
                  child: ListView.builder(
                itemCount: 30,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text("$index"),
                    onTap: () => Navigator.of(context).pop(index),
                  );
                },
              ))
            ],
          );
          return Dialog(
            child: child,
          );
        });
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("点击了：$i")));
  }

  Future<int?> _showModalBottomSheet() {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return ListView.builder(
            itemCount: 30,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text("$index"),
                onTap: () => Navigator.of(context).pop(index),
              );
            },
          );
        });
  }

  PersistentBottomSheetController<int?> _showBottomSheet() {
    return showBottomSheet(
        context: context,
        builder: (context) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return ListTile(
                title: Text("$index"),
                onTap: () => Navigator.of(context).pop(index),
              );
            },
            itemCount: 30,
          );
        });
  }

  showLoadingDialog() {
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      // false = user must tap button, true = tap outside dialog
      builder: (BuildContext dialogContext) {
        return UnconstrainedBox(
          constrainedAxis: Axis.vertical,
          child: SizedBox(
            width: 300,
            child: AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  CircularProgressIndicator(),
                  Padding(
                    padding: const EdgeInsets.only(top: 26.0),
                    child: Text("正在加载，请稍后..."),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  _showDatePicker1() {
    var date = DateTime.now();
    return showDatePicker(
        context: context,
        initialDate: date,
        firstDate: date,
        lastDate: date.add(Duration(days: 30)));
  }

  Future<DateTime?> _showDatePicker2() {
    var date = DateTime.now();
    return showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
            height: 200,
            child: CupertinoDatePicker(
              backgroundColor: Colors.white,
              mode: CupertinoDatePickerMode.dateAndTime,
              minimumDate: date,
              maximumDate: date.add(
                Duration(days: 30),
              ),
              maximumYear: date.year + 1,
              onDateTimeChanged: (DateTime value) {
                print(value);
              },
            ));
      },
    );
  }

  Future<T?> showCustomDialog<T>({
    required BuildContext context,
    bool barrierDismissible = true,
    required WidgetBuilder builder,
  }) {
    final ThemeData theme = Theme.of(context);
    return showGeneralDialog(
      context: context,
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        final Widget pageChild = Builder(builder: builder);
        return SafeArea(
          child: Builder(builder: (BuildContext context) {
            return Theme(data: theme, child: pageChild);
          }),
        );
      },
      barrierDismissible: barrierDismissible,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black87,
      transitionDuration: const Duration(milliseconds: 150),
      transitionBuilder: _buildMaterialDialogTransitions,
    );
  }

  Widget _buildMaterialDialogTransitions(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    return ScaleTransition(
      scale: CurvedAnimation(
        parent: animation,
        curve: Curves.easeOut,
      ),
      child: child,
    );
  }

  List<ElevatedButton> buildActions() {
    return [
      ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("取消")),
      ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(_withTree);
          },
          child: Text("确定")),
    ];
  }
}

class DialogCheckbox extends StatefulWidget {
  final bool? value;
  final ValueChanged<bool> onChanged;

  DialogCheckbox({Key? key, this.value, required this.onChanged});

  @override
  State<StatefulWidget> createState() => _DialogCheckboxState();
}

class _DialogCheckboxState extends State<DialogCheckbox> {
  late bool value;

  @override
  void initState() {
    value = widget.value!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Checkbox(
        value: value,
        onChanged: (v) {
          widget.onChanged(v!);
          setState(() {
            value = v;
          });
        });
  }
}
