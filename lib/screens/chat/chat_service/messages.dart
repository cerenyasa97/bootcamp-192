import 'package:swapy/core/base/model/base_model.dart';

class Messages extends BaseModel {
  Messages({
    this.messages,
  });

  List<Message>? messages;

  fromJson(Map<String, dynamic>? json) => Messages(
        messages: json?["messages"] == null
            ? null
            : List<Message>.from(
                json!["messages"].map((x) => Message.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "messages": messages == null
            ? null
            : List<dynamic>.from(messages!.map((x) => x.toJson())),
      };
}

class Message {
  Message({this.sender, this.message, this.time});

  String? sender;
  String? message;
  DateTime? time;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        sender: json["sender"] == null ? null : json["sender"],
        message: json["message"] == null ? null : json["message"],
        time: json["timestamp"] == null
            ? null
            : DateTime.tryParse(json["timestamp"]),
      );

  Map<String, dynamic> toJson() => {
        "sender": sender == null ? null : sender,
        "message": message == null ? null : message,
        "timestamp": time == null ? null : time.toString(),
      };
}
