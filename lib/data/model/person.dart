import 'package:flutter/cupertino.dart';

@immutable
class Person {
  final int id;
  final String firstName;
  final String lastName;
  final String title;
  final int age;

  const Person(
      {this.id = -1,
      required this.firstName,
      required this.lastName,
      required this.title,
      required this.age});

  Person copy(
      {int? id, String? firstName, String? lastName, String? title, int? age}) {
    return Person(
        id: id ?? this.id,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        title: title ?? this.title,
        age: age ?? this.age);
  }
}
