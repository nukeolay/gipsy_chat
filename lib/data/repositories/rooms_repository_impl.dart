import 'package:gipsy_chat/data/api/room_history_api.dart';
import 'package:gipsy_chat/data/api/rooms_api.dart';
import 'package:gipsy_chat/domain/entities/room.dart';
import 'package:gipsy_chat/domain/entities/message.dart';
import 'package:gipsy_chat/domain/repositories/rooms_repository.dart';

class RoomsRepositoryImpl implements RoomsRepository {
  final RoomsApi _roomsApi;
  final RoomHistoryApi _roomHistoryApi;

  RoomsRepositoryImpl({
    required RoomsApi roomsApi,
    required RoomHistoryApi roomHistoryApi,
  })  : _roomsApi = roomsApi,
        _roomHistoryApi = roomHistoryApi;

  @override
  Future<List<Message>> roomHistory(String roomName) async {
    return (await _roomHistoryApi.fetchRoomHistory(roomName))
      ..sort(
        (a, b) => b.createdAt.compareTo(a.createdAt),
      );
  }

  @override
  Future<List<Room>> get rooms async {
    return (await _roomsApi.rooms)
      ..sort(
        (a, b) => b.messages[0].createdAt.compareTo(a.messages[0].createdAt),
      );
  }
}
