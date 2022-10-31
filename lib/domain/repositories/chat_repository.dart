import 'package:gipsy_chat/domain/entities/message.dart';
import 'package:gipsy_chat/domain/entities/user.dart';

abstract class ChatRepository {
  void initConnection(User user);
  Stream<Message> get allMessagesStream;
  Stream<Message> roomMessagesStream(String roomName);
  Future<void> sendMessage(Message message);
  Future<void> closeConnection();
}
