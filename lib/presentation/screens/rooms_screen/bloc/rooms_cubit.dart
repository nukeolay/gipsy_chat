import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gipsy_chat/domain/entities/message.dart';
import 'package:gipsy_chat/domain/entities/room.dart';
import 'package:gipsy_chat/domain/repositories/chat_repository.dart';
import 'package:gipsy_chat/domain/repositories/rooms_repository.dart';
import 'package:gipsy_chat/domain/repositories/user_repository.dart';
import 'package:gipsy_chat/presentation/screens/rooms_screen/bloc/rooms_state.dart';

class RoomsCubit extends Cubit<RoomsState> {
  final UserRepository _userRepository;
  final RoomsRepository _roomsRepository;
  final ChatRepository _chatRepository;
  StreamSubscription<Message>? _messageSubscription;

  RoomsCubit({
    required UserRepository userRepository,
    required RoomsRepository roomsRepository,
    required ChatRepository chatRepository,
  })  : _userRepository = userRepository,
        _roomsRepository = roomsRepository,
        _chatRepository = chatRepository,
        super(const RoomsState());

  Future<void> init() async {
    emit(state.copyWith(status: RoomsStatus.loading));
    await _loadUser();
    _chatRepository.initConnection(state.user);
    await fetchRooms();
  }

  Future<void> logout() async {
    try {
      emit(const RoomsState(status: RoomsStatus.notLogined));
      _userRepository.logout();
      _chatRepository.closeConnection();
    } catch (error) {
      emit(RoomsState(
        status: RoomsStatus.failure,
        errorMessage: error.toString(),
      ));
      emit(const RoomsState(status: RoomsStatus.notLogined));
    }
  }

  Future<void> _loadUser() async {
    try {
      final user = await _userRepository.user;
      emit(state.copyWith(user: user));
    } catch (error) {
      emit(state.copyWith(
        status: RoomsStatus.failure,
        errorMessage: error.toString(),
      ));
    }
  }

  Future<void> fetchRooms() async {
    try {
      emit(state.copyWith(status: RoomsStatus.loading));
      final rooms = await _roomsRepository.rooms;
      emit(state.copyWith(status: RoomsStatus.success, rooms: rooms));
      _autoUpdateRooms();
    } catch (error) {
      emit(state.copyWith(
        status: RoomsStatus.failure,
        errorMessage: error.toString(),
      ));
    }
  }

  void reconnect() async {
    try {
      _chatRepository.initConnection(state.user);
      emit(state.copyWith(status: RoomsStatus.loading));
      final rooms = await _roomsRepository.rooms;
      _autoUpdateRooms();
      emit(state.copyWith(status: RoomsStatus.success, rooms: rooms));
    } catch (error) {
      emit(state.copyWith(status: RoomsStatus.disconnected));
    }
  }

  void _autoUpdateRooms() {
    _messageSubscription = _chatRepository.allMessagesStream.listen(
      _newMessageHandler,
      onDone: () async {
        if (!state.status.isNotLogined) {
          emit(state.copyWith(status: RoomsStatus.disconnected));
        }
      },
    );
  }

  void _newMessageHandler(Message message) {
    HapticFeedback.vibrate();
    final int roomIndex =
        state.rooms.indexWhere((room) => room.name == message.roomName);
    final updatedRooms = [...state.rooms];
    if (roomIndex != -1) {
      final updatedRoom = state.rooms[roomIndex].copyWith(messages: [message]);
      updatedRooms.removeAt(roomIndex);
      updatedRooms.insert(0, updatedRoom);
      emit(state.copyWith(rooms: updatedRooms));
    } else {
      final newRoom = Room(name: message.roomName, messages: [message]);
      updatedRooms.insert(0, newRoom);
      emit(state.copyWith(rooms: updatedRooms));
    }
  }

  @override
  Future<void> close() async {
    await _messageSubscription?.cancel();
    await _chatRepository.closeConnection();
    return super.close();
  }
}
