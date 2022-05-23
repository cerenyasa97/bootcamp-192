import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:swapy/core/constants/color/color.dart';
import 'package:swapy/core/constants/image/image_constants.dart';
import 'package:swapy/screens/home/model/toy_model.dart';
import 'package:swapy/screens/home/model/toy_type_model.dart';

class HomeService {
  final db = FirebaseFirestore.instance;

  Future<List<Type>?> getToyTypes() async {
    final toyTypesCollection = db.collection('toy_types');
    final result = await toyTypesCollection.doc('toy_types').get();
    if (result.data() != null) {
      return ToyType.fromJson(result.data()!).type;
    }
    return null;
  }

  Future<List<Toy>?> getToys(Type selectedToyType) async {
    final toysCollection = db.collection('toys');
    final toys = await toysCollection.doc(selectedToyType.typeId).get();
    if(toys.data() != null){
      return ToyResult.fromJson(toys.data()!).toys;
    }
    return null;
  }

  List<MaterialColor> get chipColors =>
      [
        AppColor.customGreen,
        AppColor.customPurple,
        AppColor.customTurquoise,
        AppColor.customYellow,
        AppColor.customPink,
        AppColor.customBlue,
        AppColor.customOrange,
      ];
}
