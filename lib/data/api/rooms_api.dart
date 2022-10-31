import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:gipsy_chat/core/errors/exceptions.dart';
import 'package:gipsy_chat/data/api/api_constants.dart';
import 'package:gipsy_chat/data/models/room_model.dart';
import 'package:gipsy_chat/domain/entities/room.dart';

abstract class RoomsApi {
  Future<List<Room>> get rooms;
}

class RoomsApiImpl implements RoomsApi {
  final http.Client _client;

  RoomsApiImpl(http.Client client) : _client = client;

  @override
  Future<List<Room>> get rooms async {
    return await _fetchRooms();
  }

  Future<List<Room>> _fetchRooms() async {
    final response = await _client.get(Uri.parse(ApiConstants.roomsUrl),
        headers: {'Content-Type': 'application/json'});
    try {
      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        return (result['result'] as List)
            .map((room) => RoomModel.fromJson(room))
            .toList();
      } else {
        throw RoomsFetchingException(
            errorMessage: 'bad response code: ${response.statusCode}');
      }
    } catch (error) {
      log(error.toString());
      throw RoomsFetchingException(errorMessage: '$error');
    }
  }
}
