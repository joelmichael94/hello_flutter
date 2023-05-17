import 'package:flutter/cupertino.dart';

@immutable
class Product {
  final String? id;
  final String title;
  final String brand;
  final String category;
  final String description;
  final double price;
  final double discountPercentage;
  final double rating;
  final int stock;
  final String? thumbnail;

  const Product(
      {this.id,
      required this.title,
      required this.brand,
      required this.category,
      required this.description,
      required this.price,
      required this.discountPercentage,
      required this.rating,
      required this.stock,
      this.thumbnail});

  Product copy(
      {String? id,
      String? title,
      String? brand,
      String? category,
      String? description,
      double? price,
      double? discountPercentage,
      double? rating,
      int? stock,
      String? thumbnail}) {
    return Product(
        id: id ?? this.id,
        title: title ?? this.title,
        brand: brand ?? this.brand,
        category: category ?? this.category,
        description: description ?? this.description,
        price: price ?? this.price,
        discountPercentage: discountPercentage ?? this.discountPercentage,
        rating: rating ?? this.rating,
        stock: stock ?? this.stock,
        thumbnail: thumbnail ?? this.thumbnail);
  }

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "brand": brand,
      "category": category,
      "description": description,
      "price": price,
      "discountPercentage": discountPercentage,
      "rating": rating,
      "stock": stock,
      "thumbnail": thumbnail
    };
  }

  static fromMap(Map<String, dynamic> map) {
    return Product(
        id: map["_id"],
        title: map["title"],
        brand: map["brand"],
        category: map["category"],
        description: map["description"],
        price: map["price"] is int ? map["price"].toDouble() : map["price"],
        discountPercentage: map["discountPercentage"] is int
            ? map["discountPercentage"].toDouble()
            : map["discountPercentage"],
        rating: map["rating"] is int ? map["rating"].toDouble() : map["rating"],
        stock: map["stock"],
        thumbnail: map["thumbnail"]);
  }

  @override
  String toString() {
    return "Product(title: $title, brand: $brand, category: $category, price: $price)";
  }
}
