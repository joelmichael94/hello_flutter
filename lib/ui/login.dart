import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:hello_flutter/service/auth_service.dart";

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

      _login();
    });
  }

  _onClickRegister() {
    context.go('/register');
  }

  _login() async {
    await AuthService.authenticate(
        _email,
        _password,
        (status) => {
              if (status)
                {context.go('/home')}
              else
                {debugPrint("Wrong credentials")}
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
        Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              child: TextField(
                onChanged: (value) => {_onEmailChanged(value)},
                decoration: InputDecoration(
                    hintText: "Email",
                    errorText: _emailError.isEmpty ? null : _emailError,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              )),
          PasswordField(passwordError: _passwordError, onPasswordChanged: _onPasswordChanged),
          // Container(
          //     padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
          //     child: TextField(
          //       obscureText: true,
          //       onChanged: (value) => {_onPasswordChanged(value)},
          //       decoration: InputDecoration(
          //           hintText: "Password",
          //           errorText: _passwordError.isEmpty ? null : _passwordError,
          //           border: OutlineInputBorder(
          //               borderRadius: BorderRadius.circular(10))),
          //     )),
        ]),
        const SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
                onPressed: () => _onClickLogin(),
                style: ElevatedButton.styleFrom(
                    // minimumSize: const Size.fromHeight(50),
                    backgroundColor: Colors.indigo,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15),
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
            const SizedBox(width: 5),
            GestureDetector(
              child: const Text(
                "Register here",
                style: TextStyle(
                    color: Colors.indigo, fontWeight: FontWeight.w500),
              ),
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

class PasswordField extends StatelessWidget {
  final Function onPasswordChanged;
  final String passwordError;
  const PasswordField({Key? key, required this.passwordError, required this.onPasswordChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        child: TextField(
          obscureText: true,
          onChanged: (value) => {onPasswordChanged(value)},
          decoration: InputDecoration(
              hintText: "Password",
              errorText: passwordError.isEmpty ? null : passwordError,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10))),
        ));
  }
}
