import 'package:flutter/material.dart';
import 'package:swapy/core/constants/color/color.dart';
import 'package:swapy/core/extension/date_time_extension.dart';
import 'package:swapy/core/widget/image_view/circle_image.dart';
import 'package:swapy/screens/chat/model/chat_room_model.dart';

class ChatCard extends StatelessWidget {
  final VoidCallback? onTap;
  final ChatRoom chatroom;
  final MaterialColor color;

  ChatCard({Key? key, this.onTap, required this.chatroom, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        onTap: onTap,
        isThreeLine: true,
        leading: CircleImage(
          image: NetworkImage(
              "https://cdn2.vectorstock.com/i/1000x1000/20/76/man-avatar-profile-vector-21372076.jpg"),
        ),
        title: Text(
          DateTime.now().dateAndTime,
          style: Theme.of(context)
              .textTheme
              .bodyText2
              ?.copyWith(fontSize: 10, color: Colors.grey),
          textAlign: TextAlign.left,
        ),
        subtitle: Text(
          chatroom.otherUserName ?? "",
          style: Theme.of(context).textTheme.subtitle1?.copyWith(
            color: color,
          ),
        ),
      ),
    );
  }
}
