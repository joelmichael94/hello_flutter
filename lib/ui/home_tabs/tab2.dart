import 'package:flutter/material.dart';
import 'package:hello_flutter/provider/products_provider.dart';
import 'package:provider/provider.dart';

class SecondTab extends StatelessWidget {
  const SecondTab({Key? key}) : super(key: key);

  Future<bool> _onConfirmDismiss(
      DismissDirection dir, BuildContext context) async {
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
    final products = context.watch<ProductsProvider>().products;
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: Container(
                  color: Colors.indigo,
                  width: double.infinity,
                  child: ListView.builder(
                      padding: const EdgeInsets.only(bottom: 80),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return Card(
                          color: Colors.blue.shade50,
                          margin: const EdgeInsets.all(8),
                          child: Dismissible(
                            // key: Key(product.toString()),
                            key: UniqueKey(),
                            onDismissed: (dir) {
                              Provider.of<ProductsProvider>(context,
                                      listen: false)
                                  .deleteProduct(product.id.toString());
                            },
                            secondaryBackground: Container(
                                color: Colors.green,
                                child: const Center(child: Text("Delete"))),
                            confirmDismiss: (dir) async {
                              return _onConfirmDismiss(dir, context);
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
                                            onTap: () =>
                                                Provider.of<ProductsProvider>(
                                                        context,
                                                        listen: false)
                                                    .toUpdateProduct(
                                                        product.id.toString(),
                                                        context),
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
          onPressed: () => Provider.of<ProductsProvider>(context, listen: false)
              .toAddProduct(context),
          child: const Icon(Icons.add)),
    );
  }
}
