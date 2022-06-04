import 'package:swapy/core/base/model/base_model.dart';

class ChatRoom extends BaseModel{
  ChatRoom({
    this.chatRoomId,
    this.userId,
  });

  String? chatRoomId;
  List<String?>? userId;
  String? otherUserName;

  fromJson(Map<String, dynamic>? json) => ChatRoom(
    chatRoomId: json?["chat_room_id"] == null ? null : json!["chat_room_id"],
    userId: json?["userId"] == null ? null : List<String>.from(json!["userId"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "chat_room_id": chatRoomId == null ? null : chatRoomId,
    "userId": userId == null ? null : List<dynamic>.from(userId!.map((x) => x)),
  };
}
