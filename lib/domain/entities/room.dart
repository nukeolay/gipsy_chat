import 'package:gipsy_chat/domain/entities/message.dart';

class Room {
  final String name;
  final List<Message> messages;

  const Room({
    required this.name,
    required this.messages,
  });

  Room copyWith({
    String? name,
    List<Message>? messages,
  }) {
    return Room(
      name: name ?? this.name,
      messages: messages ?? this.messages,
    );
  }

  @override
  String toString() {
    return 'NAME: $name, MESSAGES: $messages';
  }
}
