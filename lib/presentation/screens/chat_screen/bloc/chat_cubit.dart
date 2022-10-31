import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gipsy_chat/domain/entities/message.dart';
import 'package:gipsy_chat/domain/entities/room.dart';
import 'package:gipsy_chat/domain/repositories/chat_repository.dart';
import 'package:gipsy_chat/domain/repositories/rooms_repository.dart';
import 'package:gipsy_chat/domain/repositories/user_repository.dart';
import 'package:gipsy_chat/presentation/screens/chat_screen/bloc/chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final UserRepository _userRepository;
  final RoomsRepository _roomsRepository;
  final ChatRepository _chatRepository;
  StreamSubscription<Message>? _messageSubscription;

  ChatCubit({
    required UserRepository userRepository,
    required RoomsRepository roomsRepository,
    required ChatRepository chatRepository,
  })  : _userRepository = userRepository,
        _roomsRepository = roomsRepository,
        _chatRepository = chatRepository,
        super(const ChatState());

  Future<void> init(String roomName) async {
    emit(state.copyWith(
      room: Room(name: roomName, messages: []),
      status: ChatStatus.loading,
    ));
    await _loadUser();
    _chatRepository.initConnection(state.user);
    await _fetchHistory();
  }

  Future<void> _loadUser() async {
    try {
      final user = await _userRepository.user;
      emit(state.copyWith(user: user));
    } catch (error) {
      emit(state.copyWith(
        status: ChatStatus.failure,
        errorMessage: error.toString(),
      ));
    }
  }

  Future<void> _fetchHistory() async {
    try {
      emit(state.copyWith(status: ChatStatus.loading));
      final messages = await _roomsRepository.roomHistory(state.room.name);
      emit(state.copyWith(status: ChatStatus.loaded, messages: messages));
      _autoUpdateMessages();
    } catch (error) {
      emit(state.copyWith(
        status: ChatStatus.failure,
        errorMessage: error.toString(),
      ));
    }
  }

  void _autoUpdateMessages() {
    _messageSubscription =
        _chatRepository.roomMessagesStream(state.room.name).listen((message) {
      final updatedMessages = [...state.messages];
      updatedMessages.insert(0, message);
      emit(state.copyWith(messages: updatedMessages));
    });
  }

  Future<void> sendMessage(String text) async {
    final message = Message(
      text: text,
      sender: state.user,
      createdAt: DateTime.now(),
      roomName: state.room.name,
    );
    await _chatRepository.sendMessage(message);
  }

  @override
  Future<void> close() async {
    await _messageSubscription?.cancel();
    return super.close();
  }
}
