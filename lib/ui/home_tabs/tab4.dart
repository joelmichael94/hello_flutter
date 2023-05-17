import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hello_flutter/data/model/product.dart';

class FourthTab extends StatefulWidget {
  const FourthTab({Key? key}) : super(key: key);

  @override
  State<FourthTab> createState() => _FourthTabState();
}

class _FourthTabState extends State<FourthTab> {
  @override
  void initState() {
    super.initState();
    getProducts();
  }

  Future getProducts() async {
    var collection = FirebaseFirestore.instance.collection("products");
    var querySnapshot = await collection.get();

    for (var item in querySnapshot.docs) {
      var data = item.data();
      var product = Product.fromMap(data);
      debugPrint(product.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
