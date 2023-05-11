import 'package:hello_flutter/data/database/db.dart';
import 'package:hello_flutter/data/model/user.dart';

class UserRepoImpl {
  Future<int> insertUser(User user) async {
    return await TaskDatabase.createUser(user);
  }

  Future<List<User>> getUsers() async {
    final res = await TaskDatabase.getUsers();
    return res.map((e) => User.fromMap(e)).toList();
  }

  Future<User?> getUserByEmail(String email) async {
    final res = await TaskDatabase.getUserByEmail(email);
    if (res.isEmpty) {
      return null;
    }
    return User.fromMap(res[0]);
  }
}
