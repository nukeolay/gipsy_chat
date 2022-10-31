import 'package:gipsy_chat/core/constants/server_constants.dart';

class ApiConstants {
  static const _httpUrl = ServerConstants.httpUrl;
  static const _socketUrl = ServerConstants.socketUrl;

  static const _settings = '/settings';
  static const _rooms = '/rooms';
  static const _history = '/history';
  static const settingsUrl = '$_httpUrl$_settings';
  static const roomsUrl = '$_httpUrl$_rooms';
  static String messageHistoryUrl(String roomName) =>
      '$roomsUrl/${Uri.encodeComponent(roomName)}$_history';
  static String webSocketUrl(String userName) =>
      '$_socketUrl/ws?username=${Uri.encodeComponent(userName)}';
}
