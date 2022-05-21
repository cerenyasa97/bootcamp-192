import 'package:flutter/material.dart';
import 'package:swapy/core/constants/color/color.dart';
import 'package:swapy/core/constants/image/image_constants.dart';

class HomeService {
  Future<List<String>> getToyTypes() async =>
      await Future.delayed(Duration(seconds: 2), () => dummyToyTypes);

  List<String> get dummyToyTypes =>
      ["Tümü", "Eğitici Oyuncaklar", "Kutu Oyunları", "Oyuncaklar Arabalar"];

  List<MaterialColor> get chipColors => [
    AppColor.customGreen,
    AppColor.customPurple,
    AppColor.customTurquoise,
    AppColor.customYellow,
    AppColor.customPink,
    AppColor.customBlue,
    AppColor.customOrange,
  ];
}
