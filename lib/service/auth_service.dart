import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:hello_flutter/data/database/db.dart';
import 'package:hello_flutter/data/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static SharedPreferences? sharedPref;

  static Future<SharedPreferences> createPref() async {
    if (sharedPref != null) return sharedPref!;
    sharedPref = await SharedPreferences.getInstance();
    return sharedPref!;
  }

  static Future<bool> isLoggedIn() async {
    final user = await getUser();
    return user != null;
  }

  static Future createUser(User user) async {
    await TaskDatabase.createUser(user);
  }

  static Future authenticate(
      String email, String password, Function(bool) callback) async {
    final String hashedPassword = md5.convert(utf8.encode(password)).toString();
    final res = await TaskDatabase.getUserByEmail(email);
    if (res.isEmpty) callback(false);
    final User authUser = User.fromMap(res[0]);
    if (authUser.password != hashedPassword) callback(false);
    final sharedPref = await createPref();
    final user = authUser.toMap();
    user["id"] = authUser.id;
    final userString = jsonEncode(user);
    sharedPref.setString("user", userString);
    callback(true);
  }

  static Future deauthenticate() async {
    final sharedPref = await createPref();
    sharedPref.remove("user");
  }

  static Future<User?> getUser() async {
    final sharedPref = await createPref();
    final userString = sharedPref.getString("user");
    if (userString != null) return User.fromMap(jsonDecode(userString));
    return null;
  }
}
