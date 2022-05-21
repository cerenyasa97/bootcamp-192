import 'package:flutter/material.dart';
import 'package:swapy/core/extension/context_extension.dart';

class CustomCircleButton extends StatelessWidget {
  final IconData? icon;
  final Widget? child;
  final VoidCallback? onTap;
  final Color? iconColor;

  const CustomCircleButton(
      {Key? key, this.icon, this.child, this.onTap, this.iconColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: context.dynamicWidth(50),
        height: context.dynamicWidth(50),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 2.0,
                spreadRadius: 0.0,
                offset: Offset(0.0, 2.0), // shadow direction: bottom right
              )
            ]),
        child: child ??
            Icon(
              icon,
              color: iconColor,
            ),
      ),
    );
  }
}
