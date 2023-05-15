import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:hello_flutter/service/auth_service.dart";

import "../data/model/user.dart";

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var _email = "";
  var _emailError = "";
  var _password = "";
  var _passwordError = "";
  var _name = "Joe";

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

  _onClickLogin() {
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

      AuthService.authenticate(
          User(password: _password, name: _name, email: _email),
          (status) => {
                if (status)
                  {context.go('/home/$_name')}
                else
                  {debugPrint("Wrong credentials")}
              });
    });
  }

  _onClickRegister() {
    context.push('/register');
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
          size: 150,
          color: Colors.grey.shade500,
        ),
        Text("You entered $_email",
            textDirection: TextDirection.ltr,
            style:
                const TextStyle(fontWeight: FontWeight.w400, fontSize: 20.0)),
        Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: TextField(
                onChanged: (value) => {_onEmailChanged(value)},
                decoration: InputDecoration(
                    hintText: "Email",
                    errorText: _emailError.isEmpty ? null : _emailError,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              )),
          Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
                onPressed: () => _onClickLogin(),
                style: ElevatedButton.styleFrom(
                    // minimumSize: const Size.fromHeight(50),
                    backgroundColor: Colors.indigo,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 18),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15))),
                // style: const ButtonStyle(
                //     fixedSize: MaterialStatePropertyAll(Size.fromWidth(100))),
                child: const Text("Login", style: TextStyle(fontSize: 16))),
          ],
        ),
        const SizedBox(
          height: 25,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("New user?"),
            GestureDetector(
              child: const Text("Register here"),
              onTap: () {
                _onClickRegister();
              },
            )
          ],
        )
      ]),
    );
  }
}
