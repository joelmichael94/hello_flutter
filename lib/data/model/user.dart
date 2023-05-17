import "dart:convert";
import "dart:typed_data";

import "package:crypto/crypto.dart";
import 'package:flutter/material.dart';

@immutable
class User {
  static const tableName = "users";

  final int id;
  final String name;
  final String email;
  final String password;
  final Uint8List? image;

  // final String image;

  const User(
      {this.id = -1,
      required this.password,
      required this.name,
      required this.email,
      this.image});

  User copy(
      {int? id,
      String? name,
      String? email,
      String? password,
      Uint8List? image}) {
    return User(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        password: password ?? this.password,
        image: image ?? this.image);
  }

  @override
  String toString() {
    return "User($id, $name, $email, $password)";
  }

  Map<String, dynamic> toMap() {
    final String hashedPassword = md5.convert(utf8.encode(password)).toString();
    return {
      "name": name,
      "email": email,
      "password": hashedPassword,
      "image": image
    };
  }

  static User fromMap(Map<String, dynamic> map) {
    return User(
        id: map["id"],
        name: map["name"],
        email: map["email"],
        password: map["password"] ?? "",
        image: map["image"]);
  }
}
