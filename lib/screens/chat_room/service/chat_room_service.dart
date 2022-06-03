import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:swapy/core/constants/string/string_constants.dart';
import 'package:swapy/screens/chat/model/chat_room_model.dart';
import 'package:swapy/screens/login/view_model/login_view_model.dart';

class ChatroomService {
  Future getChatroom() async {
    final db = FirebaseFirestore.instance;
    final user = LoginViewModel.instance.userInfo;
    final rooms = await db
        .collection(StringConstants.chatroom)
        .where(StringConstants.userID, arrayContains: user?.userUid)
        .withConverter<ChatRoom>(
            fromFirestore: (snapshot, _) =>
                ChatRoom().fromJson(snapshot.data()),
            toFirestore: (model, _) => model.toJson()).get();
    var chatRooms = <ChatRoom>[];
    rooms.docs.forEach((element) => chatRooms.add(element.data()));
    return chatRooms;
  }
}
