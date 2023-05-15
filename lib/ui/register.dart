import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:hello_flutter/service/auth_service.dart";

import "../data/model/user.dart";

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  var _email = "";
  var _emailError = "";
  var _password = "";
  var _passwordError = "";
  var _name = "";
  var _nameError = "";

  _onPasswordChanged(value) {
    setState(() {
      _password = value;
    });
  }

  _onEmailChanged(value) {
    setState(() {
      _email = value;
    });
  }

  _onNameChanged(value) {
    setState(() {
      _name = value;
    });
  }

  _onClickRegister() {
    setState(() {
      if (_email.isEmpty) {
        _emailError = "Email cannot be empty";
      } else {
        _emailError = "";
      }

      if (_password.isEmpty) {
        _passwordError = "Password cannot be empty";
      } else {
        _passwordError = "";
      }

      if (_name.isEmpty) {
        _nameError = "Name cannot be empty";
      } else {
        _nameError = "";
      }

      if (_nameError == "" && _emailError == "" && _passwordError == "") {
        AuthService.createUser(
            User(name: _name, email: _email, password: _password));
        context.go('/login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hello Flutter!"),
        centerTitle: false,
        backgroundColor: Colors.indigo,
        actions: [
          IconButton(
              onPressed: () => debugPrint("Hello Scaffold email"),
              icon: const Icon(Icons.mail, color: Colors.white)),
          IconButton(
              onPressed: () => debugPrint("Hello Scaffold sms"),
              icon: const Icon(Icons.sms, color: Colors.white))
        ],
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(
          Icons.person,
          size: 125,
          color: Colors.grey.shade500,
        ),
        Text("You entered $_email",
            textDirection: TextDirection.ltr,
            style:
                const TextStyle(fontWeight: FontWeight.w400, fontSize: 20.0)),
        Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              child: TextField(
                onChanged: (value) => {_onNameChanged(value)},
                decoration: InputDecoration(
                    hintText: "Name",
                    errorText: _nameError.isEmpty ? null : _nameError,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              )),
          Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              child: TextField(
                onChanged: (value) => {_onEmailChanged(value)},
                decoration: InputDecoration(
                    hintText: "Email",
                    errorText: _emailError.isEmpty ? null : _emailError,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              )),
          Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              child: TextField(
                obscureText: true,
                onChanged: (value) => {_onPasswordChanged(value)},
                decoration: InputDecoration(
                    hintText: "Password",
                    errorText: _passwordError.isEmpty ? null : _passwordError,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              )),
        ]),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () => _onClickRegister(),
                style: ElevatedButton.styleFrom(
                    // minimumSize: const Size.fromHeight(50),
                    backgroundColor: Colors.indigo,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15))),
                // style: const ButtonStyle(
                //     fixedSize: MaterialStatePropertyAll(Size.fromWidth(100))),
                child: const Text("Register", style: TextStyle(fontSize: 16))),
          ],
        ),
      ]),
    );
  }
}
