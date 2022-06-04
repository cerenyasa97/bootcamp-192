import 'dart:async';
import 'package:flutter/material.dart';
import 'package:swapy/core/base/view_model/base_view_model.dart';
import 'package:swapy/core/navigation/navigation_service.dart';
import 'package:swapy/core/navigation/router.dart';
import 'package:swapy/core/widget/dialog/util/show_confirm_dialog.dart';
import 'package:swapy/screens/home/model/toy_model.dart';
import 'package:swapy/screens/home/model/toy_type_model.dart';
import 'package:swapy/screens/home/service/home_service.dart';
import 'package:swapy/screens/login/view_model/login_view_model.dart';

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
    try {
      isLoading = true;
      chipColors = service.chipColors;
      toyTypes = (await service.getToyTypes()) ?? [];
      await selectToyType();
      notifyListeners();
    } on Exception catch (e) {
      showConfirmDialog(contentText: e.toString(), isJustConfirm: true);
    } finally{
      isLoading = false;
    }
  }

  int get selectedTab => _selectedTab;

  set selectedTab(int value) {
    _selectedTab = value;
    notifyListeners();
  }

  void navigateToDetail(int index) {
    navigationService.navigateTo(AppRouter.productDetail, arg: toys[index]);
  }

  void messages() {
    navigationService.navigateTo(AppRouter.chat);
  }

  Future<void> selectToyType({int? index}) async {
    try {
      toys = [];
      if (index != null && index != 0) {
        selectedToyType = toyTypes.firstWhere(
            (element) => element.typeId == toyTypes[index].typeId); //
        if (selectedToyType != null) {
          toys = (await service.getToys(selectedToyType!)) ?? [];
        }
      } else {
        await Future.forEach(toyTypes, (Type element) async {
          final allToyByTypes = await service.getToys(element);
          if (allToyByTypes != null) toys.addAll(allToyByTypes);
        });
      }
      if (toys.isNotEmpty) {
        toys = toys
            .where((element) =>
        element.advertiserId !=
            LoginViewModel.instance.userInfo?.userUid)
            .toList();
      }
    } on Exception catch (e) {
      showConfirmDialog(contentText: e.toString(), isJustConfirm: true);
    }
  }
}
