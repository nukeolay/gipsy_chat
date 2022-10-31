import 'package:gipsy_chat/core/errors/exceptions.dart';
import 'package:gipsy_chat/data/api/chat_settings_api.dart';
import 'package:gipsy_chat/data/storage/local_storage.dart';
import 'package:gipsy_chat/domain/entities/user.dart';
import 'package:gipsy_chat/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final LocalStorage _localStorage;
  final ChatSettingsApi _chatSettingsApi;

  UserRepositoryImpl({
    required LocalStorage localStorage,
    required ChatSettingsApi chatSettingsApi,
  })  : _localStorage = localStorage,
        _chatSettingsApi = chatSettingsApi;

  @override
  Future<void> login(User user) async {
    final chatSettings = await _chatSettingsApi.chatSettings;
    if (user.name.length > chatSettings.maxUserNameLength) {
      throw UserException(
        errorMessage:
            'Too long, true gipsy name can`t be more than ${chatSettings.maxUserNameLength} characters',
      );
    }
    await _localStorage.saveUser(user);
  }

  @override
  Future<void> logout() async {
    await _localStorage.deleteUser();
  }

  @override
  Future<User?> get user => _localStorage.loadUser();
}
