import 'package:gipsy_chat/data/models/message_model.dart';
import 'package:gipsy_chat/domain/entities/room.dart';

class RoomModel extends Room {
  const RoomModel({required super.name, required super.messages});

  factory RoomModel.fromJson(Map<String, dynamic> json) => RoomModel(
        name: json[RoomModelFields.name],
        messages: [MessageModel.fromJson(json[RoomModelFields.lastMessage])],
      );
}

class RoomModelFields {
  static const name = 'name';
  static const lastMessage = 'last_message';
}
