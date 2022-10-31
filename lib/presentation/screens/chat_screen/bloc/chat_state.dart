import 'package:equatable/equatable.dart';
import 'package:gipsy_chat/domain/entities/message.dart';
import 'package:gipsy_chat/domain/entities/room.dart';
import 'package:gipsy_chat/domain/entities/user.dart';

enum ChatStatus { loading, loaded, failure }

extension ChatStatusX on ChatStatus {
  bool get isLoading => this == ChatStatus.loading;
  bool get isLoaded => this == ChatStatus.loaded;
  bool get isFailure => this == ChatStatus.failure;
}

class ChatState extends Equatable {
  final ChatStatus status;
  final String? errorMessage;
  final User user;
  final Room room;
  final List<Message> messages;

  const ChatState({
    this.status = ChatStatus.loading,
    this.user = const User(''),
    this.room = const Room(name: '', messages: []),
    this.messages = const [],
    this.errorMessage,
  });

  ChatState copyWith({
    ChatStatus? status,
    String? errorMessage,
    User? user,
    Room? room,
    List<Message>? messages,
  }) {
    return ChatState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      user: user ?? this.user,
      room: room ?? this.room,
      messages: messages ?? this.messages,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage, user, room, messages];
}
