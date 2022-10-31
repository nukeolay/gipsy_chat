class GipsyException implements Exception {
  final String? errorMessage;

  const GipsyException({this.errorMessage});

  @override
  String toString() {
    return '$errorMessage';
  }
}

class ChatSettingsException extends GipsyException {
  const ChatSettingsException({super.errorMessage});
}

class UserException extends GipsyException {
  const UserException({super.errorMessage});
}

class RoomsFetchingException extends GipsyException {
  const RoomsFetchingException({super.errorMessage});
}

class RoomHistoryFetchingException extends GipsyException {
  const RoomHistoryFetchingException({super.errorMessage});
}

class SocketConnectionException extends GipsyException {
  const SocketConnectionException({super.errorMessage});
}

class RoomNameLengthException extends GipsyException {
  const RoomNameLengthException({super.errorMessage});
}
