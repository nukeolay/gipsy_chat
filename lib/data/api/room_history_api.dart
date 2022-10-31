import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:gipsy_chat/core/errors/exceptions.dart';
import 'package:gipsy_chat/data/api/api_constants.dart';
import 'package:gipsy_chat/domain/entities/message.dart';
import 'package:gipsy_chat/data/models/message_model.dart';

abstract class RoomHistoryApi {
  Future<List<Message>> fetchRoomHistory(String roomName);
}

class RoomHistoryApiImpl implements RoomHistoryApi {
  final http.Client _client;

  RoomHistoryApiImpl(http.Client client) : _client = client;

  @override
  Future<List<Message>> fetchRoomHistory(String roomName) async {
    try {
      final response = await _client.get(
          Uri.parse(ApiConstants.messageHistoryUrl(roomName)),
          headers: {'Content-Type': 'application/json'});
      if (response.statusCode == 200) {
        return compute(_parseMessages, response.body);
      } else {
        throw RoomsFetchingException(
            errorMessage: 'bad response code: ${response.statusCode}');
      }
    } catch (error) {
      log(error.toString());
      throw RoomsFetchingException(errorMessage: '$error');
    }
  }
}

List<Message> _parseMessages(String responseBody) {
  final result = jsonDecode(responseBody);
  return (result['result'] as List)
      .map((message) => MessageModel.fromJson(message))
      .toList();
}
