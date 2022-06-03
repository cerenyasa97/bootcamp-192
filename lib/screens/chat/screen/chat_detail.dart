import 'package:flutter/material.dart';
import 'package:swapy/core/base/view/base_view.dart';
import 'package:swapy/core/constants/color/color.dart';
import 'package:swapy/core/extension/context_extension.dart';
import 'package:swapy/core/extension/date_time_extension.dart';
import 'package:swapy/core/extension/widget_extension.dart';
import 'package:swapy/core/widget/button/custom_circle_button.dart';
import 'package:swapy/screens/chat/view_model/chat_detail_view_model.dart';

class ChatDetail extends StatelessWidget {
  const ChatDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<ChatDetailViewModel>(
        vmBuilder: ChatDetailViewModel.instance(), builder: _buildPage);
  }

  Widget _buildPage(BuildContext context, ChatDetailViewModel viewModel) =>
      WillPopScope(
        onWillPop: () => viewModel.navigateBack(),
        child: Scaffold(
          appBar: AppBar(
            title: Text((viewModel.otherUser?.name ?? "")),
            leading: InkWell(
              child: Icon(Icons.arrow_back_ios),
              onTap: viewModel.navigateBack,
            ),
            centerTitle: true,
            backgroundColor: viewModel.color,
          ),
          body: SafeArea(
            child: Column(
              children: [
                if (viewModel.messages.isNotEmpty)
                  Chip(
                    label: Text(viewModel.messages.first.time?.date ?? ''),
                  ),
                Expanded(
                  child: ListView.separated(
                    controller: viewModel.scrollController,
                    itemBuilder: (context, index) {
                      final message = viewModel.messages[index];
                      return Align(
                        alignment: message.sender == viewModel.user?.userUid
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment:
                              message.sender == viewModel.user?.userUid
                                  ? CrossAxisAlignment.start
                                  : CrossAxisAlignment.end,
                          children: [
                            Text(
                              message.time?.time ?? "",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  ?.copyWith(fontSize: 10, color: Colors.grey),
                            ),
                            Card(
                              color: message.sender == viewModel.user?.userUid
                                  ? AppColor.customGrey
                                  : viewModel.color?.shade200,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text(message.message ?? ""),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      final message = viewModel.messages[index + 1];
                      if (viewModel.differentDateIndex.isNotEmpty &&
                          viewModel.differentDateIndex.contains(index))
                        return Chip(
                          label: Text(message.time!.date),
                        );
                      return SizedBox();
                    },
                    itemCount: viewModel.messages.length,
                  ),
                ),
                Row(children: [
                  Expanded(
                      child: TextField(
                    controller: viewModel.messageController,
                    decoration:
                        InputDecoration(labelText: "Mesajınızı giriniz."),
                  )),
                  SizedBox(
                    width: context.dynamicWidth(8),
                  ),
                  CustomCircleButton(
                    onTap: viewModel.sendMessage,
                    icon: Icons.arrow_forward_ios_rounded,
                    iconColor: Colors.white,
                    backgroundColor: viewModel.getColor(),
                  ),
                ]).horizontalPadding(),
              ],
            ).pageStandardPadding(),
          ),
        ),
      );
}
