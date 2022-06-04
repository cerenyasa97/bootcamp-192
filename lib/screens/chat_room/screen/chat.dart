import 'package:flutter/material.dart';
import 'package:swapy/core/base/view/base_view.dart';
import 'package:swapy/core/constants/color/color.dart';
import 'package:swapy/core/constants/image/image_constants.dart';
import 'package:swapy/core/extension/context_extension.dart';
import 'package:swapy/core/extension/widget_extension.dart';
import 'package:swapy/core/widget/button/custom_circle_button.dart';
import 'package:swapy/screens/chat_room/screen/chat_card.dart';
import 'package:swapy/screens/chat/view_model/chat_detail_view_model.dart';
import 'package:swapy/screens/chat_room/view_model/chat_room_view_model.dart';

class ChatUsers extends StatelessWidget {
  const ChatUsers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<ChatroomViewModel>(
        vmBuilder: ChatroomViewModel(), builder: _buildPage);
  }

  Widget _buildPage(BuildContext context, ChatroomViewModel viewModel) => Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomCircleButton(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Icon(Icons.arrow_back_ios),
                    ),
                    onTap: viewModel.navigateBack,
                  ),
                  Image.asset(
                    ImageConstants.appLogo,
                    height: context.dynamicHeight(75),
                  ),
                  SizedBox(
                    width: 50,
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) => ChatCard(
                    chatroom: viewModel.chatrooms[index],
                    color: viewModel.colors[index],
                    onTap: () => viewModel.navigateToMessages(index),
                  ),
                  itemCount: viewModel.chatrooms.length,
                ),
              ),
            ],
          ).pageExpandedPadding(vertical: 0, horizontal: 12),
        ),
      );
}
