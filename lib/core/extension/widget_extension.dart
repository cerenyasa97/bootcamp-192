import 'package:flutter/cupertino.dart';
import 'package:swapy/core/navigation/navigation_service.dart';
import 'package:swapy/core/extension/context_extension.dart';

extension WidgetExtension on Widget {
  BuildContext get context => NavigationService.instance.navigationKey.currentContext!;

  Widget pagePadding(
          {EdgeInsetsGeometry? edgeInsetsGeometry,
          double horizontal = 20,
          double vertical = 50}) =>
      Padding(
        padding: edgeInsetsGeometry ??
            EdgeInsets.symmetric(
                horizontal: context.dynamicWidth(horizontal), vertical: context.dynamicHeight(context.heightAccordingToSize(vertical))),
        child: this,
      );

  Widget widgetPadding(
          {EdgeInsetsGeometry? edgeInsetsGeometry,
          double horizontal = 0,
          double vertical = 10}) =>
      Padding(
        padding: edgeInsetsGeometry ??
            EdgeInsets.symmetric(
                horizontal: context.dynamicWidth(horizontal), vertical: context.dynamicHeight(context.heightAccordingToSize(vertical))),
        child: this,
      );
}
