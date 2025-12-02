
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/models/product.dart';
import 'package:flutter_e_commerce/widgets/product_card.dart';

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

  }
}
