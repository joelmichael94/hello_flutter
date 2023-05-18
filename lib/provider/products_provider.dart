import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hello_flutter/data/model/product.dart';
import 'package:hello_flutter/data/repository/product_repo_impl.dart';

class ProductsProvider extends ChangeNotifier {
  var products = <Product>[];
  final repo = ProductRepoImpl();

  ProductsProvider() {
    fetchProducts();
  }

  fetchProducts() async {
    products = await repo.getProducts();
    notifyListeners();
  }

  toAddProduct(BuildContext context) async {
    var res = await context.push("/addProduct");
    if (res == "true") {
      fetchProducts();
      notifyListeners();
    }
  }

  toUpdateProduct(String productId, BuildContext context) async {
    var res = await context.push("/updateProduct/$productId");
    if (res == "true") {
      fetchProducts();
      notifyListeners();
    }
  }

  deleteProduct(String id) async {
    await repo.deleteItem(id);
    fetchProducts();
    notifyListeners();
  }
}
