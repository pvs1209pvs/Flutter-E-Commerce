import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/product.dart';

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
                child: Center(
                  child: Image.network(product.imageUrl, width: 100, height: 100),
                ),
              ),
              Text(
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black87,
                ),
                product.title,
              ),
              Text(
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                ),
                "\$${product.price.toString()}",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
