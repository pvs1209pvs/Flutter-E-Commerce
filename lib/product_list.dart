import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/product.dart';
import 'package:flutter_e_commerce/product_card.dart';

class ProductsList extends StatelessWidget {
  
  final List<Product> products;

  const ProductsList({required this.products, super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.count(
        crossAxisCount: 2,
        children: List.generate(products.length, (index) {
          return ProductCard(product: products[index]);
        }),
      ),
    );

    return Expanded(
      child: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ProductCard(product: products[index]);
        },
      ),
    );
  }
}
