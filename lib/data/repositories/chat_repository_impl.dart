import 'package:gipsy_chat/core/errors/exceptions.dart';
import 'package:gipsy_chat/data/api/chat_settings_api.dart';
import 'package:gipsy_chat/data/api/chat_sockets.dart';
import 'package:gipsy_chat/domain/entities/user.dart';
import 'package:gipsy_chat/domain/entities/message.dart';
import 'package:gipsy_chat/domain/repositories/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatSockets _chatSockets;
  final ChatSettingsApi _chatSettingsApi;
  late Stream<Message> _messageStream;

  ChatRepositoryImpl({
    required ChatSockets chatSockets,
    required ChatSettingsApi chatSettingsApi,
  })  : _chatSockets = chatSockets,
        _chatSettingsApi = chatSettingsApi;

  @override
  void initConnection(User user) {
    _messageStream = _chatSockets.openConnection(user.name);
  }

  @override
  Stream<Message> roomMessagesStream(String roomName) {
    return _messageStream.where((message) => message.roomName == roomName);
  }

  @override
  Future<void> sendMessage(Message message) async {
    final chatSettings = await _chatSettingsApi.chatSettings;
    if (message.roomName.length > chatSettings.maxRoomTitleLength) {
      throw RoomNameLengthException(
        errorMessage:
            'Too long, room name can`t be more than ${chatSettings.maxRoomTitleLength} characters',
      );
    }
    if (message.text.length > chatSettings.maxMessageLength) {
      throw RoomNameLengthException(
        errorMessage:
            'Too long, message can`t be more than ${chatSettings.maxRoomTitleLength} characters',
      );
    }
    _chatSockets.sendMessage(roomName: message.roomName, text: message.text);
  }

  @override
  Stream<Message> get allMessagesStream => _messageStream;

  @override
  Future<void> closeConnection() async {
    await _chatSockets.closeConnection();
  }
}
