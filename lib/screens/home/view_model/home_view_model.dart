import 'dart:async';
import 'package:flutter/material.dart';
import 'package:swapy/core/base/view_model/base_view_model.dart';
import 'package:swapy/screens/home/service/home_service.dart';

class HomeViewModel extends BaseViewModel {
  final service = HomeService();

  List<String> toyTypes = [];
  List<Color> chipColors = [];
  int _selectedTab = 0;

  @override
  FutureOr<void> init() async {
    chipColors = service.chipColors;
    toyTypes = await service.getToyTypes();
  }

  int get selectedTab => _selectedTab;

  set selectedTab(int value) {
    _selectedTab = value;
    notifyListeners();
  }
}
