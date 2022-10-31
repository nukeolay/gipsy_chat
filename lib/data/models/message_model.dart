import 'package:gipsy_chat/data/models/user_model.dart';
import 'package:gipsy_chat/domain/entities/message.dart';

class MessageModel extends Message {
  const MessageModel({
    required super.roomName,
    required super.sender,
    required super.createdAt,
    required super.text,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        roomName: json[MessageModelFields.room],
        sender: UserModel.fromJson(json[MessageModelFields.sender]),
        createdAt: DateTime.parse(json[MessageModelFields.createdAt] as String),
        text: json[MessageModelFields.text],
      );
}

class MessageModelFields {
  static const room = 'room';
  static const createdAt = 'created';
  static const sender = 'sender';
  static const text = 'text';
}
