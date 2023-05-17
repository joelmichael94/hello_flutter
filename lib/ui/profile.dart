import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hello_flutter/data/repository/user_repo_impl.dart';
import 'package:hello_flutter/service/auth_service.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var _name = "";
  var _email = "";
  Uint8List? image;
  var base64ImageString = "";
  final repo = UserRepoImpl();

  @override
  void initState() {
    super.initState();
    _fetchUser();
  }

  Uint8List getImageBytes() {
    return base64Decode(base64ImageString);
  }

  _fetchUser() async {
    final user = await AuthService.getUser();
    if (user != null) {
      final temp = await repo.getUserByEmail(user.email);
      if (temp != null) {
        setState(() {
          _name = temp.name;
          _email = temp.email;
          image = temp.image;
          if (image != null) {
            base64ImageString = base64Encode(image!);
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: Colors.indigo,
        actions: [
          IconButton(
              onPressed: () => debugPrint("Hello Scaffold Heart"),
              icon: const Icon(
                CupertinoIcons.heart,
                color: Colors.white,
              )),
          IconButton(
              onPressed: () => debugPrint("Hello Scaffold Hamburger"),
              icon: const Icon(
                CupertinoIcons.ellipsis_vertical,
                color: Colors.white,
              ))
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  child: image != null
                      ? Image.memory(
                          image!,
                          width: 125,
                          height: 125,
                        )
                      : Icon(
                          Icons.person,
                          size: 125,
                          color: Colors.grey.shade500,
                        )),
              Text("Name: $_name"),
              Text("Email: $_email"),
              ElevatedButton(onPressed: () => {}, child: const Text("Edit"))
            ],
          ),
          const SizedBox(height: 50),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.facebook),
                  Text("101"),
                  Text("Followers"),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.reddit),
                  Text("59"),
                  Text("Followers"),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.account_circle_outlined),
                  Text("40"),
                  Text("Contacts"),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
