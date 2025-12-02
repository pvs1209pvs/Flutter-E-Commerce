import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/product.dart';
import 'package:flutter_e_commerce/product_cart_saved.dart';
import 'package:flutter_e_commerce/product_with_quantity.dart';

class ShoppingCartItem extends StatefulWidget {
  final ProductWithQuantity product;

  const ShoppingCartItem({super.key, required this.product});

  @override
  State<ShoppingCartItem> createState() => _ShoppingCartItemState();
}

class _ShoppingCartItemState extends State<ShoppingCartItem> {
  late int qty;

  @override
  void initState() {
    super.initState();
    qty = widget.product.quantity;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: <Widget>[
          Image.network(
            widget.product.product.imageUrl,
            height: 100,
            width: 100,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(widget.product.product.title),
              Text(widget.product.product.price.toString()),
              Row(
                children: <Widget>[
                  TextButton(
                    onPressed: () => setState(() {
                      qty--;
                    }),
                    child: Text("-"),
                  ),
                  Text("$qty"),
                  TextButton(
                    onPressed: () => setState(() {
                      qty++;
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
