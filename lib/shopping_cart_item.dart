import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/product.dart';
import 'package:flutter_e_commerce/product_cart_saved.dart';

class ShoppingCartItem extends StatefulWidget {
  final Product product;

  const ShoppingCartItem({super.key, required this.product});

  @override
  State<ShoppingCartItem> createState() => _ShoppingCartItemState();
}

class _ShoppingCartItemState extends State<ShoppingCartItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: <Widget>[
          Image.network(widget.product.imageUrl, height: 100, width: 100),
          Column(
            children: <Widget>[
              Text(widget.product.title),
              Text(widget.product.price.toString()),
              Row(
                children: <Widget>[
                  TextButton(
                    onPressed: () => setState(() {
                      // qty--;
                    }),
                    child: Text("-"),
                  ),
                  // Text("$qty"),
                  TextButton(
                    onPressed: () => setState(() {
                      // qty++;
                    }),
                    child: Text("+"),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
