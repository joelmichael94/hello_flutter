import 'dart:convert';

import 'package:hello_flutter/data/model/product.dart';
import 'package:http/http.dart' as http;

class ProductRepoImpl {
  Future<List<Product>> getProducts() async {
    final res = await http.get(
        Uri.parse("https://product-catalogue-hz5q.onrender.com/products/"));

    if (res.statusCode == 200) {
      final List<dynamic> resBody = jsonDecode(res.body);
      final List<Product> products = resBody
          .map((product) => Product.fromMap(product))
          .toList()
          .cast<Product>();
      return products;
    } else {
      throw Exception("Failed to load");
    }
  }

  Future<int> insertItem(Product product) async {
    final res = await http.post(
        Uri.parse("https://product-catalogue-hz5q.onrender.com/products/"),
        headers: {"Content-Type": "application/json; charset=UTF-8"},
        body: jsonEncode(product.toMap()));

    if (res.statusCode == 200) {
      return jsonDecode(res.body)["_id"] ?? -1;
    } else {
      throw Exception("Failed to insert");
    }
  }

  Future<int> deleteItem(String id) async {
    final res = await http.delete(
        Uri.parse("https://product-catalogue-hz5q.onrender.com/products/$id"));

    if (res.statusCode == 200) {
      return jsonDecode(res.body)["_id"] ?? -1;
    } else {
      throw Exception("Failed to delete");
    }
  }

  Future<int> updateItem(int id, Product product) async {
    final res = await http.put(
        Uri.parse("https://product-catalogue-hz5q.onrender.com/products/$id"),
        headers: {"Content-Type": "application/json; charset=UTF-8"},
        body: jsonEncode(product.toMap()));

    if (res.statusCode == 200) {
      return jsonDecode(res.body)["_id"] ?? -1;
    } else {
      throw Exception("Failed to update");
    }
  }

  Future<Product>? getItemById(int id) async {
    final res = await http.get(
        Uri.parse("https://product-catalogue-hz5q.onrender.com/products/$id"));

    if (res.statusCode == 200) {
      return Product.fromMap(jsonDecode(res.body));
    } else {
      throw Exception("Failed to get item by id");
    }
  }
}
