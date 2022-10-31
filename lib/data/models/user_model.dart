import 'package:gipsy_chat/domain/entities/user.dart';

class UserModel extends User {
  const UserModel(super.name);

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      UserModel(json[UserModelFields.name]);
}

class UserModelFields {
  static const name = 'username';
}
