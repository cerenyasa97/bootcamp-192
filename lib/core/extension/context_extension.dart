import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  double get currentWidth => MediaQuery.of(this).size.width;

  double get currentHeight => MediaQuery.of(this).size.height;

  double dynamicWidth(double width) =>
      MediaQuery.of(this).size.width * width / 428;

  double dynamicHeight(double height) =>
      MediaQuery.of(this).size.width * height / 926;

  bool get smallHeightPhone => currentHeight < 600;

  bool get mediumHeightPhone => currentHeight > 600 && currentHeight < 800;

  bool get smallWidthPhone => currentWidth < 350;

  bool get mediumWidthPhone => currentWidth > 350 && currentWidth < 400;

  double heightAccordingToSize(double minSize) => smallHeightPhone
      ? minSize
      : mediumHeightPhone
          ? minSize + 10
          : minSize + 20;

  double widthAccordingToSize(double minSize) => smallWidthPhone
      ? minSize
      : mediumWidthPhone
          ? minSize + 5
          : minSize + 10;
}
