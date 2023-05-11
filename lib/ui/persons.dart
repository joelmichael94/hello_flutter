import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hello_flutter/data/model/person.dart';
import '../data/repository/persons_repo_impl.dart';

class Persons extends StatefulWidget {
  const Persons({Key? key}) : super(key: key);

  @override
  State<Persons> createState() => _PersonState();
}

class _PersonState extends State<Persons> {
  var _firstName = "";
  var _firstNameError = "";
  var _lastName = "";
  var _lastNameError = "";
  var _title = "";
  var _titleError = "";
  var _age = -1;
  var _ageError = "";
  final repo = PersonsRepoImpl();

  _onFirstNameChanged(value) {
    setState(() {
      _firstName = value;
    });
  }

  _onLastNameChanged(value) {
    setState(() {
      _lastName = value;
    });
  }

  _onTitleChanged(value) {
    setState(() {
      _title = value;
    });
  }

  _onAgeChanged(value) {
    setState(() {
      _age = int.parse(value);
    });
  }

  _onClickAdd() {
    setState(() {
      if (_firstName.isEmpty) {
        _firstNameError = "First Name cannot be empty";
      } else {
        _firstNameError = "";
      }

      if (_lastName.isEmpty) {
        _lastNameError = "Last Name cannot be empty";
      } else {
        _lastNameError = "";
      }

      if (_title.isEmpty) {
        _titleError = "Title cannot be empty";
      } else {
        _titleError = "";
      }

      if (_age.isNaN || _age.isNegative) {
        _ageError = "Age cannot be empty or is an invalid value";
      } else {
        _ageError = "";
      }

      if (_firstNameError == "" &&
          _lastNameError == "" &&
          _titleError == "" &&
          _ageError == "") {
        var person = Person(
            firstName: _firstName,
            lastName: _lastName,
            title: _title,
            age: _age);
        repo.addPerson(person);
        context.pop("true");
      }
    });
  }

  _onClickBack() {
    context.pop("Back from add person");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Person"),
        backgroundColor: Colors.indigo,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: TextField(
                onChanged: (value) => _onFirstNameChanged(value),
                decoration: InputDecoration(
                    suffixIcon: const Icon(Icons.abc_sharp),
                    hintText: "First Name",
                    errorText: _firstNameError.isEmpty ? null : _firstNameError,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
                keyboardType: TextInputType.name,
              ),
            ),
            const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: TextField(
                onChanged: (value) => _onLastNameChanged(value),
                decoration: InputDecoration(
                    suffixIcon: const Icon(Icons.abc_sharp),
                    hintText: "Last Name",
                    errorText: _lastNameError.isEmpty ? null : _lastNameError,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
                keyboardType: TextInputType.name,
              ),
            ),
            const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: TextField(
                onChanged: (value) => _onTitleChanged(value),
                decoration: InputDecoration(
                    suffixIcon: const Icon(Icons.abc_sharp),
                    hintText: "Title",
                    errorText: _titleError.isEmpty ? null : _titleError,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
                keyboardType: TextInputType.name,
              ),
            ),
            const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: TextField(
                onChanged: (value) => _onAgeChanged(value),
                decoration: InputDecoration(
                    suffixIcon: const Icon(Icons.abc_sharp),
                    hintText: "Age",
                    errorText: _ageError.isEmpty ? null : _ageError,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
              ),
            ),
          ]),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: () => _onClickAdd(),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 18),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15))),
                  child: const Text("Add", style: TextStyle(fontSize: 16))),
              ElevatedButton(
                  onPressed: () => _onClickBack(),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 18),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15))),
                  child: const Text("Back", style: TextStyle(fontSize: 16))),
            ],
          )
        ],
      ),
    );
  }
}
