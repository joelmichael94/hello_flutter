import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hello_flutter/data/model/user.dart';
import 'package:hello_flutter/data/repository/user_repo_impl.dart';
import 'package:hello_flutter/service/auth_service.dart';
import 'package:image_picker/image_picker.dart';

class ThirdTab extends StatefulWidget {
  const ThirdTab({Key? key}) : super(key: key);

  @override
  State<ThirdTab> createState() => _ThirdTabState();
}

class _ThirdTabState extends State<ThirdTab> {
  final repo = UserRepoImpl();
  File? image;
  String base64ImageString = "";
  User? user;

  @override
  void initState() {
    super.initState();
    fetchUser();
  }

  Future fetchUser() async {
    final user = await AuthService.getUser();
    if (user != null) {
      final temp = await repo.getUserByEmail(user.email);
      setState(() {
        this.user = temp;
      });
    }
  }

  Uint8List getImageBytes() {
    return base64Decode(base64ImageString);
  }

  Future _savePic() async {
    if (user != null && image != null) {
      final bytes = image!.readAsBytesSync();
      repo.updateProfilePic(user!.id, bytes);
    }
  }

  Future _pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      final imageFile = File(image.path);
      // final bytes = imageFile.readAsBytesSync();
      // repo.updateProfilePic(user!.id, bytes);
      // final imageString = base64Encode(bytes);
      setState(() {
        this.image = imageFile;
        // base64ImageString = imageString;
      });
    }
  }

  _onClickPicturePage(BuildContext context) {
    context.push('/scene');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            ElevatedButton(
                onPressed: () => _onClickPicturePage(context),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 22, vertical: 15),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15))),
                // style: const ButtonStyle(
                //     fixedSize: MaterialStatePropertyAll(Size.fromWidth(100))),
                child: const Text("Scenes", style: TextStyle(fontSize: 15))),
            ElevatedButton(
                onPressed: () => _pickImage(),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 22, vertical: 15),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15))),
                // style: const ButtonStyle(
                //     fixedSize: MaterialStatePropertyAll(Size.fromWidth(100))),
                child:
                    const Text("Pick Image", style: TextStyle(fontSize: 15))),
            ElevatedButton(
                onPressed: () => _savePic(),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 22, vertical: 15),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15))),
                // style: const ButtonStyle(
                //     fixedSize: MaterialStatePropertyAll(Size.fromWidth(100))),
                child:
                    const Text("Save Image", style: TextStyle(fontSize: 15))),
          ]),
        ),
        Container(
          child: image != null
              ? Image.file(
                  image!,
                  width: 200,
                  height: 200,
                )
              : user?.image != null
                  ? Image.memory(
                      user!.image!,
                      width: 200,
                      height: 200,
                    )
                  : const Text(""),
          // child: image != null ? Image.memory(getImageBytes()) : const Text(""),
        )
      ],
    );
  }
}
