import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:swapy/core/constants/string/string_constants.dart';
import 'package:swapy/screens/chat/chat_service/messages.dart';
import 'package:swapy/screens/chat/model/chat_room_model.dart';
import 'package:uuid/uuid.dart';

class ChatService {
  final db = FirebaseFirestore.instance;

  Future<ChatRoom?> findChatRoomId(List<String?> userIDs) async {
    final chatRooms = (await db
            .collection(StringConstants.chatroom)
            .withConverter<ChatRoom>(
                fromFirestore: (snapshot, _) =>
                    ChatRoom().fromJson(snapshot.data()),
                toFirestore: (ChatRoom model, _) => model.toJson())
            .get())
        .docs;
    var chatRoomRecord;
    await Future.forEach(chatRooms as List<QueryDocumentSnapshot<ChatRoom>>,
        (QueryDocumentSnapshot<ChatRoom> element) async {
      final data = element.data();
      if (data.userId != null &&
          data.userId!.contains(userIDs.first) &&
          data.userId!.contains(userIDs.last)) {
        chatRoomRecord = element.data();
      }
    });
    return chatRoomRecord ?? await createChatroom(userIDs);
  }

  Future<ChatRoom> createChatroom(List<String?> userIDs) async {
    final chatRoomRecord = ChatRoom(chatRoomId: Uuid().v1(), userId: userIDs);
    await db
        .collection(StringConstants.chatroom)
        .doc(userIDs.join("-"))
        .set(chatRoomRecord.toJson());
    return chatRoomRecord;
  }

  Stream<DocumentSnapshot<Messages>> listenMessages(String chatroomID) {
    return db
        .collection(StringConstants.messages)
        .doc(chatroomID)
        .withConverter<Messages>(
            fromFirestore: (snapshot, _) =>
                Messages().fromJson(snapshot.data()),
            toFirestore: (Messages model, _) => model.toJson())
        .snapshots();
  }

  Future sendMessage(String chatroomID, Messages message) async {
    await db
        .collection(StringConstants.messages)
        .doc(chatroomID)
        .set(message.toJson());
  }
}
