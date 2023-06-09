import 'package:uuid/uuid.dart';

import 'models/models.dart';

class UserRepository {
  User? _user;
  Future<User?> getUser() async {
    if (_user != null) return _user;
    return Future.delayed(
        Duration(microseconds: 300), () => _user = User(const Uuid().v4()));
  }
}
