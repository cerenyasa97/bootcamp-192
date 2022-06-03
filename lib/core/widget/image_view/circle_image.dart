import 'package:flutter/material.dart';
import 'package:swapy/core/extension/context_extension.dart';

class CircleImage extends StatelessWidget {
  final ImageProvider image;
  final double radius;

  const CircleImage({Key? key, required this.image, this.radius = 75})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.dynamicWidth(radius),
      height: context.dynamicWidth(radius),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(image: image, fit: BoxFit.cover)),
    );
  }
}
