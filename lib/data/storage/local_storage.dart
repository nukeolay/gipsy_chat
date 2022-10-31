import 'package:gipsy_chat/domain/entities/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalStorage {
  Future<void> saveUser(User user);
  Future<User?> loadUser();
  Future<void> deleteUser();
}

class LocalStorageImpl implements LocalStorage {
  final SharedPreferences _sharedPreferences;

  static const userKey = 'user';

  LocalStorageImpl(this._sharedPreferences);

  @override
  Future<User?> loadUser() async {
    final name = _sharedPreferences.getString(userKey);
    if (name == null || name == '') {
      return null;
    }
    return User(name);
  }

  @override
  Future<void> saveUser(User user) async {
    await _sharedPreferences.setString(userKey, user.name);
  }

  @override
  Future<void> deleteUser() async {
    await _sharedPreferences.setString(userKey, '');
  }
}
