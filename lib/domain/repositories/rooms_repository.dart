import 'package:gipsy_chat/domain/entities/message.dart';
import 'package:gipsy_chat/domain/entities/room.dart';

abstract class RoomsRepository {
  Future<List<Room>> get rooms;
  Future<List<Message>> roomHistory(String roomName);
}
