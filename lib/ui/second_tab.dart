import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../data/repository/product_repo_impl.dart';

class Tab2 extends StatefulWidget {
  const Tab2({Key? key}) : super(key: key);

  @override
  State<Tab2> createState() => _Tab2State();
}

class _Tab2State extends State<Tab2> {
  final repo = ProductRepoImpl();

  _onClickFoodPage(BuildContext context) {
    context.push("/food");
  }

  @override
  void initState() {
    super.initState();
    repo.getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.red.shade200,
        alignment: Alignment.center,
        child: Column(
          children: [
            const SizedBox(height: 30),
            const Text("Second Tab"),
            const SizedBox(height: 30),
            Card(
              elevation: 10,
              child: Container(
                  color: Colors.red.shade400,
                  padding: const EdgeInsets.all(50),
                  child: const Text("Card")),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
                onPressed: () => _onClickFoodPage(context),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 22, vertical: 15),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15))),
                // style: const ButtonStyle(
                //     fixedSize: MaterialStatePropertyAll(Size.fromWidth(100))),
                child: const Text("Food", style: TextStyle(fontSize: 15)))
          ],
        ));
  }
}
