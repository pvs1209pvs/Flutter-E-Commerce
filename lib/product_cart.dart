import 'dart:convert';

import 'package:flutter_e_commerce/product_cart_saved.dart';

class ProductCart {
  final int id;
  final int userId;
  final String date;
  final List<ProductCartSaved> products;

  ProductCart({
    required this.products,
    required this.id,
    required this.userId,
    required this.date,
  });

  factory ProductCart.fromJson(Map<String, dynamic> json) => ProductCart(
    id: json['id'],
    userId: json['userId'],
    date: json['date'],
    products: (json['products'] as List)
        .map((item) => ProductCartSaved.fromJson(item))
        .toList(),
  );
}
