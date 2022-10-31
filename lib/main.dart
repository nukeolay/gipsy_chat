import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gipsy_chat/app.dart';
import 'package:gipsy_chat/data/repositories/chat_repository_impl.dart';
import 'package:gipsy_chat/data/repositories/user_repository_impl.dart';
import 'package:gipsy_chat/data/storage/local_storage.dart';
import 'package:gipsy_chat/domain/repositories/chat_repository.dart';
import 'package:gipsy_chat/domain/repositories/user_repository.dart';
import 'package:gipsy_chat/data/api/chat_settings_api.dart';
import 'package:gipsy_chat/data/repositories/rooms_repository_impl.dart';
import 'package:gipsy_chat/domain/repositories/rooms_repository.dart';
import 'package:gipsy_chat/data/api/rooms_api.dart';
import 'package:gipsy_chat/data/api/room_history_api.dart';
import 'package:gipsy_chat/data/api/chat_sockets.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final sharedPreferences = await SharedPreferences.getInstance();
  final client = http.Client();

  final LocalStorage localStorage = LocalStorageImpl(sharedPreferences);
  final ChatSettingsApi chatSettingsApi = ChatSettingsApiImpl(client);
  final RoomsApi roomsApi = RoomsApiImpl(client);
  final RoomHistoryApi roomHistoryApi = RoomHistoryApiImpl(client);
  final ChatSockets chatSockets = ChatSocketsImpl();
  
  final UserRepository userRepository = UserRepositoryImpl(
    localStorage: localStorage,
    chatSettingsApi: chatSettingsApi,
  );
  final RoomsRepository roomsRepository = RoomsRepositoryImpl(
    roomsApi: roomsApi,
    roomHistoryApi: roomHistoryApi,
  );
  final ChatRepository chatRepository = ChatRepositoryImpl(
    chatSettingsApi: chatSettingsApi,
    chatSockets: chatSockets,
  );

  runApp(GipsyChatApp(
    userRepository: userRepository,
    roomsRepository: roomsRepository,
    chatRepository: chatRepository,
  ));
}
