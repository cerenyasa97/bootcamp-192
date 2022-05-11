import 'package:flutter/cupertino.dart';

extension WidgetExtension on Widget {
  Widget pagePadding(
          {EdgeInsetsGeometry? edgeInsetsGeometry,
          double horizontal = 20,
          double vertical = 50}) =>
      Padding(
        padding: edgeInsetsGeometry ??
            EdgeInsets.symmetric(
                horizontal: horizontal, vertical: vertical),
        child: this,
      );

  Widget widgetPadding(
          {EdgeInsetsGeometry? edgeInsetsGeometry,
          double horizontal = 0,
          double vertical = 20}) =>
      Padding(
        padding: edgeInsetsGeometry ??
            EdgeInsets.symmetric(
                horizontal: horizontal, vertical: vertical),
        child: this,
      );
}
