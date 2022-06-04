import 'dart:async';
import 'package:swapy/core/base/view_model/base_view_model.dart';
import 'package:swapy/core/navigation/navigation_service.dart';
import 'package:swapy/core/navigation/router.dart';
import 'package:swapy/core/widget/dialog/util/show_confirm_dialog.dart';
import 'package:swapy/screens/home/model/toy_model.dart';
import 'package:swapy/screens/my_toys/service/my_toys_service.dart';

class MyToysViewModel extends BaseViewModel{
  final navigationService = NavigationService.instance;
  final service = MyToysService();
  List<Toy> toys = [];

  @override
  FutureOr<void> init() async {
    try {
      isLoading = true;
      toys = await service.getMyToys();
    } on Exception catch (e) {
      showConfirmDialog(contentText: e.toString(), isJustConfirm: true);
    } finally{
      isLoading = false;
    }
  }

  Future swapDone(index) async {
    try {
      //await service.deleteToy(toys[index]);
      toys.removeAt(index);
    } on Exception catch (e) {
      showConfirmDialog(contentText: e.toString(), isJustConfirm: true);
    }
  }

  void navigateToDetail(int index) {
    navigationService.navigateTo(AppRouter.productDetail, arg: toys[index]);
  }
}