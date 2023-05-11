import 'package:hello_flutter/data/model/user.dart';

abstract class UserRepo {
  Future<List<User>> getUsers();

  Future<User?> getUser(int id);

  Future<bool> createUser(User user);

  Future<bool> updateUser(User user);

  Future<bool> deleteUser(int id);
}
