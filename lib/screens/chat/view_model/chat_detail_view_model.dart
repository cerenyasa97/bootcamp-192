import 'dart:async';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swapy/core/base/view_model/base_view_model.dart';
import 'package:swapy/core/constants/color/color.dart';
import 'package:swapy/core/navigation/navigation_service.dart';
import 'package:swapy/core/navigation/router.dart';
import 'package:swapy/core/widget/dialog/util/show_confirm_dialog.dart';
import 'package:swapy/screens/chat/chat_service/chat_service.dart';
import 'package:swapy/screens/chat/chat_service/messages.dart';
import 'package:swapy/screens/chat/model/chat_room_model.dart';
import 'package:swapy/screens/login/model/user_info.dart';
import 'package:swapy/screens/login/service/login_service.dart';
import 'package:swapy/core/extension/date_time_extension.dart';
import 'package:swapy/screens/login/view_model/login_view_model.dart';

class ChatDetailViewModel extends BaseViewModel {
  static ChatDetailViewModel? _instance;

  static ChatDetailViewModel instance({String? otherUserID}) =>
      _instance ??= ChatDetailViewModel(otherUserID: otherUserID);

  @override
  ChatDetailViewModel({this.otherUserID}) : super();

  final messageController = TextEditingController();
  final service = ChatService();
  final loginService = LoginService();
  final scrollController = ScrollController();
  final navigationService = NavigationService.instance;
  UserInfoModel? user = LoginViewModel.instance.userInfo;
  UserInfoModel? otherUser;
  String? otherUserID;
  MaterialColor? color;

  int? selectedUserIndex;

  List<Message> messages = [];
  List<int> differentDateIndex = [];
  String? chatroomID;

  @override
  FutureOr<void> init() async {
    if (otherUserID != null) {
      user = LoginViewModel.instance.userInfo;
      otherUser = await loginService.getUserInfo(otherUserID);
      await getChatroomID();
      await listenMessages();
      color = getColor();
    } else {
      showConfirmDialog(
          contentText: 'Kullanıcı bulunamadı', isJustConfirm: true);
    }
  }

  Future getChatroomID() async {
    try {
      final ChatRoom? chatroom =
          await service.findChatRoomId([user?.userUid, otherUser?.userUid]);
      chatroomID = chatroom?.chatRoomId;
    } on Exception catch (e) {
      showConfirmDialog(contentText: e.toString(), isJustConfirm: true);
    }
  }

  Future listenMessages() async {
    try {
      if (chatroomID != null) {
        final data = service.listenMessages(chatroomID ?? '');
        data.listen((event) {
          messages = event.data()?.messages ?? [];
          if (messages.isNotEmpty) findDifferentDatesIndexInMessages();
          notifyListeners();
        });
      }
    } on Exception catch (e) {
      await showConfirmDialog(contentText: e.toString(), isJustConfirm: true);
    }
  }

  void findDifferentDatesIndexInMessages() {
    final dates = messages.map((element) => element.time?.date).toSet();
    dates.remove(messages.first.time?.date);
    dates.forEach((element) {
      if (element != null) {
        final index = messages.indexWhere((e) => e.time?.date == element);
        if (index != -1) differentDateIndex.add(index - 1);
      }
    });
  }

  void sendMessage() async {
    try {
      if (user != null && messageController.text.isNotEmpty) {
        final message = Message(
            message: messageController.text,
            time: DateTime.now(),
            sender: user!.userUid);
        messages.add(message);
        if (chatroomID != null) {
          await service.sendMessage(
              chatroomID ?? '', Messages(messages: messages));
          await listenMessages();
          messageController.clear();
        }
      } else {
        await showConfirmDialog(
            contentText: "Lütfen mesaj alanını boş bırakmayınız.",
            isJustConfirm: true);
      }
    } on Exception catch (e) {
      showConfirmDialog(contentText: e.toString(), isJustConfirm: true);
    }
  }

  void navigateToMessages(int index) {
    selectedUserIndex = index;
    navigationService.navigateTo(AppRouter.chatDetail);
  }

  MaterialColor getColor({int? index}) => AppColor
      .allCustomColors[Random().nextInt(AppColor.allCustomColors.length)];

  Future<bool> navigateBack() async {
    navigationService.navigateBack();
    clean();
    return Future.value(false);
  }

  void clean() {
    _instance = null;
  }
}
