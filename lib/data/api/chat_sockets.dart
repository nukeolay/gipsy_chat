import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:web_socket_channel/io.dart';
import 'package:gipsy_chat/core/errors/exceptions.dart';
import 'package:gipsy_chat/data/api/api_constants.dart';
import 'package:gipsy_chat/data/models/message_model.dart';
import 'package:gipsy_chat/domain/entities/message.dart';

abstract class ChatSockets {
  Stream<Message> openConnection(String userName);
  void sendMessage({required String roomName, required String text});
  Future<void> closeConnection();
}

class ChatSocketsImpl implements ChatSockets {
  IOWebSocketChannel? _socketChannel;
  Stream<dynamic>? _socketStream;
  Stream<Message>? _messageStream;

  @override
  Stream<Message> openConnection(String userName) {
    try {
      if (_socketChannel == null ||
          _socketChannel?.closeCode != null ||
          _socketChannel?.innerWebSocket == null) {
        _socketChannel = IOWebSocketChannel.connect(
          Uri.parse(ApiConstants.webSocketUrl(userName)),
        );
        _socketStream = _socketChannel?.stream.asBroadcastStream();
        _messageStream = _socketStream!
            .map((message) => MessageModel.fromJson(jsonDecode(message)));
      }
      return _messageStream!;
    } catch (error) {
      log(error.toString());
      throw SocketConnectionException(errorMessage: error.toString());
    }
  }

  @override
  void sendMessage({required String roomName, required String text}) async {
    try {
      final map = {"room": roomName, "text": text};
      _socketChannel?.sink.add(jsonEncode(map));
    } catch (error) {
      log(error.toString());
      throw SocketConnectionException(errorMessage: error.toString());
    }
  }

  @override
  Future<void> closeConnection() async {
    try {
      await _socketChannel?.sink.close(1000, 'Say Hello Wave Goodbye');
    } catch (error) {
      log(error.toString());
    }
  }
}
