import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:swapy/core/navigation/navigation_service.dart';
import 'package:swapy/core/extension/context_extension.dart';

class CustomButton extends StatelessWidget {
  final bool isExpand;
  final String? text;
  final Widget? child;
  final VoidCallback? onTap;
  final double? topLeft;
  final double? topRight;
  final double? bottomLeft;
  final double? bottomRight;
  final Color? color;
  final Color? textColor;

  const CustomButton(
      {Key? key,
      this.isExpand = true,
      this.text,
      this.child,
      this.onTap,
      this.topLeft,
      this.topRight,
      this.bottomLeft,
      this.bottomRight,
      this.color,
      this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isExpand
        ? SizedBox(
            width: MediaQuery.of(context).size.width,
            child: button,
          )
        : button;
  }

  ElevatedButton get button {
    final context = NavigationService.instance.navigationKey.currentContext!;
    return ElevatedButton(
        onPressed: onTap,
        child: child ??
            AutoSizeText(
              text ?? '',
              style: Theme.of(context)
                  .textTheme
                  .button
                  ?.copyWith(fontSize: context.smallHeightPhone ? 16 : 20, color: textColor ?? Colors.white),
            ),
        style: ButtonStyle(
            padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                vertical: context.dynamicHeight(context.smallHeightPhone
                    ? 10
                    : context.mediumHeightPhone
                        ? 16
                        : 20))),
            backgroundColor: MaterialStateProperty.all(color),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
              topRight: Radius.circular(topRight ?? 12),
              bottomRight: Radius.circular(bottomRight ?? 12),
              bottomLeft: Radius.circular(bottomLeft ?? 12),
              topLeft: Radius.circular(topLeft ?? 12),
            )))));
  }
}
