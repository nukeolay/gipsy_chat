import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gipsy_chat/domain/entities/message.dart';
import 'package:gipsy_chat/domain/repositories/chat_repository.dart';
import 'package:gipsy_chat/domain/repositories/rooms_repository.dart';
import 'package:gipsy_chat/domain/repositories/user_repository.dart';
import 'package:gipsy_chat/presentation/screens/create_room_screen/bloc/create_room_state.dart';

class CreateRoomCubit extends Cubit<CreateRoomState> {
  final UserRepository _userRepository;
  final ChatRepository _chatRepository;
  final RoomsRepository _roomsRepository;

  CreateRoomCubit({
    required UserRepository userRepository,
    required ChatRepository chatRepository,
    required RoomsRepository roomsRepository,
  })  : _userRepository = userRepository,
        _chatRepository = chatRepository,
        _roomsRepository = roomsRepository,
        super(const CreateRoomState());

  void changeRoomName(String roomName) {
    if (roomName.trim() != '') {
      emit(state.copyWith(
        isButtonActive: true,
        status: CreateRoomStatus.init,
      ));
    } else {
      emit(state.copyWith(
        isButtonActive: false,
        status: CreateRoomStatus.init,
      ));
    }
  }

  Future<void> createRoom(String roomName) async {
    try {
      emit(const CreateRoomState(status: CreateRoomStatus.loading));
      final roomNames = (await _roomsRepository.rooms).map((room) => room.name);
      if (roomNames.contains(roomName)) {
        emit(state.copyWith(
          errorMessage: 'This tabor already exists',
          status: CreateRoomStatus.failure,
        ));
        return;
      }
      final userName = await _userRepository.user;
      final newRoomMessage = Message(
        text: 'This tabor was created by ${userName!.name}',
        sender: userName,
        createdAt: DateTime.now(),
        roomName: roomName,
      );
      await _chatRepository.sendMessage(newRoomMessage);
      emit(const CreateRoomState(status: CreateRoomStatus.success));
    } catch (error) {
      emit(CreateRoomState(
        status: CreateRoomStatus.failure,
        errorMessage: error.toString(),
      ));
    }
  }
}
