import 'package:flutter/material.dart';

class CustomHome extends Widget {
  @override
  Element createElement() => HomeView(this);
}

class HomeView extends ComponentElement {
  HomeView(Widget widget) : super(widget);
  String text = "123456789";

  @override
  Widget build() {
    Color primary = Theme.of(this).primaryColor;
    return GestureDetector(
      child: Center(
        child: TextButton(
          child: Text(
            text,
            style: TextStyle(color: primary),
          ),
          onPressed: () {
            var t = text.split("")..shuffle();
            text = t.join();
            markNeedsBuild();
          },
        ),
      ),
    );
  }
}
