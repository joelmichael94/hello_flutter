import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../data/model/product.dart';
import '../../data/repository/product_repo_impl.dart';

class SecondTab extends StatefulWidget {
  const SecondTab({Key? key}) : super(key: key);

  @override
  State<SecondTab> createState() => _SecondTabState();
}

class _SecondTabState extends State<SecondTab> {
  var _products = <Product>[];
  final repo = ProductRepoImpl();

  @override
  void initState() {
    super.initState();
    refresh();
  }

  void refresh() async {
    final products = await repo.getProducts();
    if (products.isNotEmpty) {
      setState(() {
        _products = products;
      });
    }
  }

  _toAddProduct() async {
    var res = await context.push("/addProduct");
    if (res == "true") refresh();
  }

  void _deleteProduct(String id) async {
    await repo.deleteItem(id);
    refresh();
  }

  Future<bool> _onConfirmDismiss(DismissDirection dir) async {
    if (dir == DismissDirection.endToStart) {
      return await showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Confirm delete?"),
              content: const Text("Item will be deleted and cannot be undone"),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red.shade700),
                    child: const Text("YES")),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: const Text("NO"))
              ],
            );
          });
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: Container(
                  color: Colors.indigo,
                  width: double.infinity,
                  child: ListView.builder(
                      itemCount: _products.length,
                      itemBuilder: (context, index) {
                        final product = _products[index];
                        return Card(
                          color: Colors.blue.shade50,
                          margin: const EdgeInsets.all(8),
                          child: Dismissible(
                            key: Key(product.id.toString()),
                            onDismissed: (dir) {
                              _deleteProduct(product.id.toString());
                            },
                            secondaryBackground: Container(
                                color: Colors.green,
                                child: const Center(child: Text("Delete"))),
                            confirmDismiss: (dir) async {
                              return _onConfirmDismiss(dir);
                            },
                            background: Container(
                              color: Colors.red.shade600,
                              child: const Center(child: Text("Cannot Delete")),
                            ),
                            child: Container(
                              decoration:
                                  const BoxDecoration(color: Colors.white),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 15),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Stock: ${product.stock}",
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600)),
                                    const SizedBox(height: 5),
                                    Text("Title: ${product.title}",
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600)),
                                    const SizedBox(height: 5),
                                    Text("Description: ${product.description}",
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 17,
                                            fontWeight: FontWeight.w400)),
                                    const SizedBox(height: 5),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          GestureDetector(
                                            onTap: () => {},
                                            child: Icon(Icons.draw_outlined,
                                                color: Colors.yellow.shade700),
                                          )
                                        ]),
                                  ]),
                            ),
                          ),
                        );
                      }))),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => _toAddProduct(), child: const Icon(Icons.add)),
    );
  }
}
