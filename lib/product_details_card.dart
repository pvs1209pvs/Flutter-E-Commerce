import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/product.dart';
import 'package:http/http.dart' as http;

class ProductDetailsCard extends StatefulWidget {
  final Product product;

  const ProductDetailsCard({super.key, required this.product});

  @override
  State<ProductDetailsCard> createState() => _ProductDetailsCardState();
}

class _ProductDetailsCardState extends State<ProductDetailsCard> {
  int qty = 1;

  Future<http.Response> addToCart(Product product) {
    return http.post(
      Uri.parse("https://fakestoreapi.com/carts"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(<String, dynamic>{"product": product, "qty": "$qty"}),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(8),
      child: Column(
        spacing: 16,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Image.network(widget.product.imageUrl),
          Text(
            style: TextStyle(
              fontSize: 18,
              color: Colors.black87,
              fontWeight: FontWeight.w600,
            ),
            widget.product.title,
          ),
          Text(
            style: TextStyle(fontSize: 24, color: Colors.black87),
            "\$${widget.product.price}",
          ),
          Text(widget.product.desc),
          Row(
            spacing: 16,
            children: <Widget>[
              Text(
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
                "Qty:",
              ),
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
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.purple,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () async {
              final response = await addToCart(widget.product);
              log(
                "Adding to cart ${widget.product.id} status ${response.statusCode} ${response.body}",
              );
            },
            child: Text("Add to cart"),
          ),
        ],
      ),
    );
  }
}
