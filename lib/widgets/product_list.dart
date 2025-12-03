import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/models/product.dart';
import 'package:flutter_e_commerce/widgets/product_card.dart';

class ProductsList extends StatelessWidget {
  final List<Product> products;

  const ProductsList({required this.products, super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        cacheExtent: MediaQuery.of(context).size.height * 1,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: products.length,
        itemBuilder: (BuildContext context, int index) {
          log("product: $index");
          return ProductCard(product: products[index]);
        },
      ),
    );
  }
}
