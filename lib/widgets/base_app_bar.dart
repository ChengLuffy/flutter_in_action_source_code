import 'package:flutter/material.dart';

class AppBarTool {
  static AppBar initBar(String title) {
    return AppBar(
      title: Text(title),
      brightness: Brightness.dark,
    );
  }
}
