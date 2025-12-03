import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({required this.product, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, "/details", arguments: product),
      child: Card(
        child: Container(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 80,
                child: Center(child: Image.network(product.imageUrl)),
              ),
              Expanded(
                flex: 10,
                child: Text(
                  style: TextStyle(fontSize: 18, color: Colors.black87),
                  product.title,
                ),
              ),
              Expanded(
                flex: 10,
                child: Text(
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black87,
                    fontWeight: FontWeight.w600,
                  ),
                  "\$${product.price}",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
