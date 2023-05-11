import 'package:flutter/material.dart';

class Food extends StatefulWidget {
  const Food({Key? key}) : super(key: key);

  @override
  State<Food> createState() => _FoodState();
}

class _FoodState extends State<Food> {
  var _number = 0;

  _onAdd() {
    setState(() {
      _number += 1;
    });
  }

  _onMinus() {
    setState(() {
      _number -= 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Food"),
          backgroundColor: Colors.indigo,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 220,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/pizza.jpg'),
                      fit: BoxFit.fill)),
            ),
            Container(
              width: 150,
              height: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 2,
                        offset: const Offset(0, 5))
                  ],
                  color: Colors.red.shade400),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                      onTap: () => _onMinus(),
                      child: const Icon(Icons.remove, color: Colors.white)),
                  Text(_number.toString(),
                      style:
                          const TextStyle(color: Colors.white, fontSize: 20)),
                  InkWell(
                      onTap: () => _onAdd(),
                      child: const Icon(Icons.add, color: Colors.white))
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text("RM12.00", style: TextStyle(fontSize: 20)),
                Row(children: [
                  Icon(Icons.star_rounded,
                      color: Colors.yellow.shade700, size: 35),
                  const SizedBox(width: 5),
                  const Text("4.9", style: TextStyle(fontSize: 20))
                ])
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("Beef Pizza", style: TextStyle(fontSize: 28)),
                  SizedBox(height: 20),
                  Text("Details",
                      style:
                          TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
                  SizedBox(height: 5),
                  Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla eget est neque. Aliquam erat volutpat. Etiam at ante et ante lobortis interdum. Curabitur et suscipit elit, id congue elit.",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                      textAlign: TextAlign.justify),
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(color: Colors.grey.shade300, width: 2))),
              child: ElevatedButton(
                  onPressed: () => {},
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow.shade800,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 70, vertical: 15),
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25))),
                  child: const Text("Add To Cart",
                      style: TextStyle(fontSize: 20))),
            )
          ],
        ));
  }
}
