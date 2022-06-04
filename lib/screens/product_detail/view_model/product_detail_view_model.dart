import 'dart:async';
import 'package:swapy/core/base/view_model/base_view_model.dart';
import 'package:swapy/core/navigation/navigation_service.dart';
import 'package:swapy/core/navigation/router.dart';
import 'package:swapy/screens/chat/view_model/chat_detail_view_model.dart';
import 'package:swapy/screens/home/model/toy_model.dart';

class ProductDetailViewModel extends BaseViewModel {
  final navigationService = NavigationService.instance;
  final Toy toy;

  ProductDetailViewModel(this.toy);

  @override
  FutureOr<void> init() {}

  void navigateToBack() {
    navigationService.navigateBack();
  }

  void giveOffer() {
    ChatDetailViewModel.instance(otherUserID: toy.advertiserId);
    NavigationService.instance.navigateTo(AppRouter.chatDetail);
  }
}
