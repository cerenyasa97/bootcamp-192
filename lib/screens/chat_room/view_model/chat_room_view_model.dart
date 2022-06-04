import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:swapy/core/base/view_model/base_view_model.dart';
import 'package:swapy/core/constants/color/color.dart';
import 'package:swapy/core/navigation/navigation_service.dart';
import 'package:swapy/core/navigation/router.dart';
import 'package:swapy/core/widget/dialog/util/show_confirm_dialog.dart';
import 'package:swapy/screens/chat/model/chat_room_model.dart';
import 'package:swapy/screens/chat/view_model/chat_detail_view_model.dart';
import 'package:swapy/screens/chat_room/service/chat_room_service.dart';
import 'package:swapy/screens/login/service/login_service.dart';
import 'package:swapy/screens/login/view_model/login_view_model.dart';

class ChatroomViewModel extends BaseViewModel {
  final navigationService = NavigationService.instance;
  final service = ChatroomService();
  final user = LoginViewModel.instance.userInfo;
  var chatrooms = <ChatRoom>[];
  List<MaterialColor> colors = [];

  @override
  FutureOr<void> init() async {
    await getChatrooms();
    colors = List.generate(chatrooms.length, (index) => getColor());
  }

  Future getChatrooms() async {
    try {
      chatrooms = await service.getChatroom();
      await Future.forEach(chatrooms, (ChatRoom element) async {
        final userInfo = await LoginService().getUserInfo(
            element.userId!.firstWhere((element) => element != user?.userUid));
        element.otherUserName =
            (userInfo?.name ?? '');
      });
    } on Exception catch (e) {
      showConfirmDialog(contentText: e.toString(), isJustConfirm: true);
    }
  }

  void navigateToMessages(int index) {
    if (chatrooms[index].userId != null &&
        chatrooms[index].userId!.isNotEmpty) {
      ChatDetailViewModel.instance(
          otherUserID: chatrooms[index]
              .userId!
              .firstWhere((element) => element != user?.userUid));
      navigationService.navigateTo(AppRouter.chatDetail);
    }
  }

  void navigateBack() {
    navigationService.navigateBack();
  }

  MaterialColor getColor({int? index}) => AppColor
      .allCustomColors[Random().nextInt(AppColor.allCustomColors.length)];
}
