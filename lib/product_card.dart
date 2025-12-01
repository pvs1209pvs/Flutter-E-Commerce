import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({required this.product, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Center(
              child: Image.network(product.imageUrl, width: 100, height: 100),
            ),
          ),
          Text(style: TextStyle(fontSize: 16), product.title),
          Text(style: TextStyle(fontSize: 16), "\$${product.price.toString()}"),
        ],
      ),
    );
  }
}
