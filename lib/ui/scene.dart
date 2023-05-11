import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Scene extends StatelessWidget {
  const Scene({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scene"),
        backgroundColor: Colors.indigo,
      ),
      body: Column(
        children: [
          Container(
            height: 250,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/mtfuji.jpg'),
                    fit: BoxFit.fill)),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("Mount Fuji",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600)),
                    SizedBox(height: 10),
                    Text("Fuji-Hakone-Izu National Park",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFFCCCCCC))),
                  ],
                ),
                Row(
                  children: const [
                    Icon(Icons.star, color: Colors.red, size: 30),
                    SizedBox(width: 10),
                    Text("99", style: TextStyle(fontSize: 18))
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: const [
                  Icon(Icons.phone, color: Colors.indigoAccent, size: 30),
                  SizedBox(height: 10),
                  Text("CALL",
                      style:
                          TextStyle(fontSize: 16, color: Colors.indigoAccent))
                ],
              ),
              Column(
                children: const [
                  Icon(CupertinoIcons.location_fill,
                      color: Colors.indigoAccent, size: 30),
                  SizedBox(height: 10),
                  Text("ROUTE",
                      style:
                          TextStyle(fontSize: 16, color: Colors.indigoAccent))
                ],
              ),
              Column(
                children: const [
                  Icon(Icons.share, color: Colors.indigoAccent, size: 30),
                  SizedBox(height: 10),
                  Text("SHARE",
                      style:
                          TextStyle(fontSize: 16, color: Colors.indigoAccent))
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
            child: const Text(
              "Mount Fuji, Japan's highest mountain, is an active volcano with a symmetrical conical shape and snow-capped peak. Considered sacred and a popular pilgrimage site, it is a favorite destination for hikers and tourists due to its stunning beauty and panoramic views from the summit.",
              style: TextStyle(fontSize: 18),
            ),
          )
        ],
      ),
    );
  }
}
