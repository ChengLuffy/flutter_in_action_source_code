import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  final List<Color>? colors;
  final double? width;
  final double? height;
  final Widget child;
  final BorderRadius borderRadius;
  final GestureTapCallback? onPressed;

  GradientButton(
      {this.colors,
      this.width,
      this.height,
      required this.child,
      this.borderRadius = BorderRadius.zero,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    List<Color> _colors =
        colors ?? [themeData.primaryColor, themeData.primaryColorDark];
    return DecoratedBox(
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: _colors),
          borderRadius: borderRadius),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          splashColor: _colors.last,
          highlightColor: Colors.transparent,
          borderRadius: borderRadius,
          onTap: onPressed,
          child: ConstrainedBox(
            constraints: BoxConstraints.tightFor(width: width, height: height),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: DefaultTextStyle(
                  style: TextStyle(fontWeight: FontWeight.bold),
                  child: child,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
