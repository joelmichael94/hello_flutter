import 'dart:ffi';
import 'package:flutter/cupertino.dart';
import 'package:hello_flutter/data/model/person.dart';
import 'package:hello_flutter/data/repository/persons_repo.dart';

class PersonsRepoImpl extends PersonsRepo {
  static final PersonsRepoImpl _instance = PersonsRepoImpl._internal();
  factory PersonsRepoImpl() {
    return _instance;
  }
  PersonsRepoImpl._internal();

  var counter = 2;

  final _persons = {
    1: const Person(
        id: 1, firstName: "Abc", lastName: "Abc", title: "Student", age: 20),
    2: const Person(
        id: 2, firstName: "Def", lastName: "Def", title: "Teacher", age: 25),
  };

  @override
  bool addPerson(Person person) {
    _persons[++counter] = person.copy(id: counter);
    return true;
  }

  @override
  bool deletePerson(int id) {
    return _persons.remove(id) != null;
  }

  @override
  List<Person> getPersons() {
    return _persons.entries.map((e) => e.value).toList();
  }
}
