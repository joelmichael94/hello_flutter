import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ThirdTab extends StatelessWidget {
  const ThirdTab({Key? key}) : super(key: key);

  _onClickPicturePage(BuildContext context) {
    context.push('/scene');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.green,
        child: Column(children: [
          ElevatedButton(
              onPressed: () => _onClickPicturePage(context),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 22, vertical: 15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15))),
              // style: const ButtonStyle(
              //     fixedSize: MaterialStatePropertyAll(Size.fromWidth(100))),
              child: const Text("Scenes", style: TextStyle(fontSize: 15)))
        ]));
  }
}
