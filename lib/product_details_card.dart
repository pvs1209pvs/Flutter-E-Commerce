import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/product.dart';
import 'package:http/http.dart';
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
      child: Card(
        child: Column(
          children: <Widget>[
            Image.network(widget.product.imageUrl),
            Text(widget.product.title),
            Text(widget.product.price.toString()),
            Text(widget.product.desc),
            Row(
              children: <Widget>[
                Text("Qty:"),
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
            TextButton(
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
      ),
    );
  }
}
