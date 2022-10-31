class ChatSettings {
  final int maxMessageLength;
  final int maxRoomTitleLength;
  final int maxUserNameLength;

  ChatSettings({
    required this.maxMessageLength,
    required this.maxRoomTitleLength,
    required this.maxUserNameLength,
  });

  factory ChatSettings.fromJson(Map<String, dynamic> json) => ChatSettings(
        maxMessageLength: json[ChatSettingsFields.maxMessageLength],
        maxRoomTitleLength: json[ChatSettingsFields.maxRoomTitleLength],
        maxUserNameLength: json[ChatSettingsFields.maxUserNameLength],
      );
}

class ChatSettingsFields {
  static const maxMessageLength = 'max_message_length';
  static const maxRoomTitleLength = 'max_room_title_length';
  static const maxUserNameLength = 'max_username_length';
}
