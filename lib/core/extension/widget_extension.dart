import 'package:flutter/cupertino.dart';
import 'package:swapy/core/navigation/navigation_service.dart';
import 'package:swapy/core/extension/context_extension.dart';

extension WidgetExtension on Widget {
  BuildContext get context =>
      NavigationService.instance.navigationKey.currentContext!;

  Widget pageExpandedPadding(
          {EdgeInsetsGeometry? edgeInsetsGeometry,
          double horizontal = 20,
          double vertical = 50}) =>
      Padding(
        padding: edgeInsetsGeometry ??
            EdgeInsets.symmetric(
                horizontal: context.dynamicWidth(horizontal),
                vertical: context
                    .dynamicHeight(context.heightAccordingToSize(vertical))),
        child: this,
      );

  Widget widgetPadding(
          {EdgeInsetsGeometry? edgeInsetsGeometry,
          double horizontal = 0,
          double vertical = 8}) =>
      Padding(
        padding: edgeInsetsGeometry ??
            EdgeInsets.symmetric(
                horizontal: context.dynamicWidth(horizontal),
                vertical: context
                    .dynamicHeight(context.heightAccordingToSize(vertical))),
        child: this,
      );

  Widget pageStandardPadding(
          {EdgeInsetsGeometry? edgeInsetsGeometry,
          double horizontal = 10,
          double vertical = 0}) =>
      Padding(
        padding: edgeInsetsGeometry ??
            EdgeInsets.symmetric(
                horizontal: context.dynamicWidth(horizontal),
                vertical: context
                    .dynamicHeight(context.heightAccordingToSize(vertical))),
        child: this,
      );

  Widget horizontalPadding(
          {EdgeInsetsGeometry? edgeInsetsGeometry,
          double left = 10,
          double right = 10}) =>
      Padding(
        padding: edgeInsetsGeometry ??
            EdgeInsets.only(
                left: context.dynamicWidth(left),
                right: context.dynamicWidth(right)),
        child: this,
      );
}
