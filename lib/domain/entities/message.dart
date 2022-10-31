import 'package:gipsy_chat/domain/entities/user.dart';

class Message {
  final String text;
  final User sender;
  final DateTime createdAt;
  final String roomName;

  const Message({
    required this.text,
    required this.sender,
    required this.createdAt,
    required this.roomName,
  });

  @override
  String toString() {
    return '$roomName (${sender.name}, $createdAt): $text';
  }
}
