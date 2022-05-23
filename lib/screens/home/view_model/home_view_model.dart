import 'dart:async';
import 'package:flutter/material.dart';
import 'package:swapy/core/base/view_model/base_view_model.dart';
import 'package:swapy/core/navigation/navigation_service.dart';
import 'package:swapy/core/navigation/router.dart';
import 'package:swapy/screens/home/model/toy_model.dart';
import 'package:swapy/screens/home/model/toy_type_model.dart';
import 'package:swapy/screens/home/service/home_service.dart';

class HomeViewModel extends BaseViewModel {
  final navigationService = NavigationService.instance;
  final service = HomeService();

  List<Type> toyTypes = [];
  Type? selectedToyType;
  List<Toy> toys = [];
  List<Color> chipColors = [];
  int _selectedTab = 0;

  @override
  FutureOr<void> init() async {
    chipColors = service.chipColors;
    toyTypes = (await service.getToyTypes()) ?? [];
    selectedToyType = toyTypes.firstWhere(
        (element) => element.typeId == 'educational'); // tyoTypes.first
    if (selectedToyType != null) {
      toys = (await service.getToys(selectedToyType!)) ?? [];
      print(toys);
    }
    notifyListeners();
  }

  int get selectedTab => _selectedTab;

  set selectedTab(int value) {
    _selectedTab = value;
    notifyListeners();
  }

  void navigateToDetail(int index) {
    navigationService.navigateTo(AppRouter.productDetail, arg: toys[index]);
  }
}
