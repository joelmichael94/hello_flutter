import 'package:hello_flutter/data/database/user_db.dart';
import 'package:hello_flutter/data/model/user.dart';
import 'package:hello_flutter/data/repository/user_repo.dart';

class UserRepoImpl2 extends UserRepo {
  static final UserRepoImpl2 _instance = UserRepoImpl2._init();

  factory UserRepoImpl2() {
    return _instance;
  }

  UserRepoImpl2._init();

  @override
  Future<bool> createUser(User user) async {
    await UserDatabase.createUser(user);
    return true;
  }

  @override
  Future<bool> deleteUser(int id) async {
    await UserDatabase.deleteUser(id);
    return true;
  }

  @override
  Future<User?> getUser(int id) async {
    final res = await UserDatabase.getUser(id);
    if (res.isEmpty) {
      return null;
    }
    return User.fromMap(res[0]);
  }

  @override
  Future<List<User>> getUsers() async {
    final res = await UserDatabase.getUsers();
    return res.map((e) => User.fromMap(e)).toList();
  }

  @override
  Future<bool> updateUser(User user) async {
    await UserDatabase.updateUser(user);
    return true;
  }
}
