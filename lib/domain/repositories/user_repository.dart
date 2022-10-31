import 'package:gipsy_chat/domain/entities/user.dart';

abstract class UserRepository {
  Future<User?> get user;
  Future<void> login(User user);
  Future<void> logout();
}
