import 'package:flutter/material.dart';
import 'package:flutter_in_action_source_code/widgets/base_app_bar.dart';

class PageScaffold extends StatelessWidget {
  final String title;
  final Widget body;
  final bool padding;

  PageScaffold(this.title, this.body, this.padding);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarTool.initBar(this.title),
      body: padding
          ? Padding(padding: const EdgeInsets.all(18), child: body)
          : body,
    );
  }
}

class PageInfo {
  String title;
  WidgetBuilder builder;
  bool withScaffold;
  bool padding;

  PageInfo(this.title, this.builder,
      {this.withScaffold = true, this.padding = true});
}
