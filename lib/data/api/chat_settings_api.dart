import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:gipsy_chat/core/errors/exceptions.dart';
import 'package:gipsy_chat/data/api/api_constants.dart';
import 'package:gipsy_chat/data/models/chat_settings.dart';

abstract class ChatSettingsApi {
  Future<ChatSettings> get chatSettings;
}

class ChatSettingsApiImpl implements ChatSettingsApi {
  final http.Client _client;
  ChatSettings? _chatSettings;

  ChatSettingsApiImpl(http.Client client) : _client = client;

  @override
  Future<ChatSettings> get chatSettings async {
    return _chatSettings ??= await _fetchChatSettings();
  }

  Future<ChatSettings> _fetchChatSettings() async {
    final response = await _client.get(Uri.parse(ApiConstants.settingsUrl),
        headers: {'Content-Type': 'application/json'});
    try {
      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        return ChatSettings.fromJson(result['result']);
      } else {
        throw ChatSettingsException(
            errorMessage: 'bad response code: ${response.statusCode}');
      }
    } catch (error) {
      log(error.toString());
      throw ChatSettingsException(errorMessage: '$error');
    }
  }
}
