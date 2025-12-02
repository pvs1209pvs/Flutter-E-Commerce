import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/models/product.dart';
import 'package:flutter_e_commerce/models/product_cart_saved.dart';
import 'package:flutter_e_commerce/models/product_with_quantity.dart';

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
        spacing: 8,
        children: <Widget>[
          Image.network(
            widget.product.product.imageUrl,
            height: 100,
            width: 100,
          ),
          Expanded(
            child: Column(
              spacing: 8,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black87,
                    fontWeight: FontWeight.w600,
                  ),
                  widget.product.product.title,
                ),
                Text(
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                  "\$${widget.product.product.price*qty}",
                ),
                Container(
                  margin: EdgeInsets.all(8),
                  child: Row(
                    spacing: 8,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.purple[100],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: IconButton(
                          onPressed: () => setState(() {
                            qty--;
                          }),
                          icon: Icon(Icons.remove),
                        ),
                      ),
                      Text(
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                        "$qty",
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.purple[100],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: IconButton(
                          onPressed: () => setState(() {
                            qty++;
                          }),
                          icon: Icon(Icons.add),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
