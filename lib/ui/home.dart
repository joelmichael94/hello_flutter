import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hello_flutter/data/repository/user_repo_impl.dart';
import 'package:hello_flutter/service/auth_service.dart';
import 'package:hello_flutter/ui/home_tabs/tab4.dart';

import 'home_tabs/tab1.dart';
import 'home_tabs/tab2.dart';
import 'home_tabs/tab3.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  Widget _tabBarItem(String s, IconData icon) {
    return SizedBox(
      height: 50,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Icon(icon, size: 30), Text(s)],
      ),
    );
  }

  void _navigateToScene(BuildContext context) {
    Navigator.of(context).pop();
    context.push('/scene');
  }

  void _logout(BuildContext context) {
    AuthService.deauthenticate();
    Navigator.of(context).pop();
    context.go('/login');
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Home"),
            iconTheme: const IconThemeData(color: Colors.black),
            titleTextStyle: const TextStyle(color: Colors.black, fontSize: 20),
            // bottom: const TabBar(tabs: [
            //   Icon(Icons.home_filled),
            //   Icon(Icons.settings),
            //   Icon(Icons.person)
            // ]),
          ),
          body: const TabBarView(
              children: [FirstTab(), SecondTab(), ThirdTab(), FourthTab()]),
          bottomNavigationBar: TabBar(
              padding: const EdgeInsets.symmetric(vertical: 10),
              indicatorPadding: const EdgeInsets.symmetric(vertical: -10),
              indicatorColor: Colors.transparent,
              labelColor: Colors.indigoAccent,
              unselectedLabelColor: Colors.grey,
              tabs: [
                _tabBarItem("Home", Icons.home_filled),
                _tabBarItem("Settings", Icons.settings),
                _tabBarItem("Profile", Icons.person),
                _tabBarItem("Firebase", Icons.local_fire_department_outlined)
              ]),
          drawer: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: const BoxDecoration(color: Colors.white),
            child: ListView(padding: EdgeInsets.zero, children: [
              const DrawerHeaderProfile(),
              Expanded(
                  flex: 1,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                            onTap: () => {_navigateToScene(context)},
                            title: const Text("Scene",
                                style: TextStyle(
                                    color: Colors.indigo, fontSize: 18))),
                        ListTile(
                            onTap: () => {_logout(context)},
                            title: const Text("Logout",
                                style: TextStyle(
                                    color: Colors.indigo, fontSize: 18)))
                      ]))
            ]),
          ),
        ));
  }
}

class DrawerHeaderProfile extends StatefulWidget {
  const DrawerHeaderProfile({super.key});

  @override
  State<DrawerHeaderProfile> createState() => _DrawerHeaderProfileState();
}

class _DrawerHeaderProfileState extends State<DrawerHeaderProfile> {
  var _name = "";
  Uint8List? image;
  String base64ImageString = "";
  final repo = UserRepoImpl();

  @override
  void initState() {
    super.initState();
    _fetchUser();
  }

  Uint8List getImageBytes() {
    return base64Decode(base64ImageString);
  }

  void _fetchUser() async {
    final user = await AuthService.getUser();
    if (user != null) {
      final temp = await repo.getUserByEmail(user.email);
      if (temp != null) {
        setState(() {
          _name = temp.name;
          image = temp.image;
          if (image != null) {
            base64ImageString = base64Encode(image!);
          }
        });
      }
    }
  }

  void _navigateToProfile() {
    Navigator.of(context).pop();
    context.push('/profile');
  }

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
        decoration: BoxDecoration(color: Colors.blue.shade200),
        child: Expanded(
          flex: 1,
          child: Column(
            children: [
              Text('Welcome $_name'),
              image != null
                  ? Material(
                      child: Ink.image(
                        image: MemoryImage(image!),
                        width: 75,
                        height: 75,
                        fit: BoxFit.fitHeight,
                        child: InkWell(
                          onLongPress: () => {_navigateToProfile()},
                        ),
                      ),
                    )
                  : Icon(
                      Icons.person,
                      size: 125,
                      color: Colors.grey.shade500,
                    ),
              const Text("Profile")
            ],
          ),
        ));
  }
}
