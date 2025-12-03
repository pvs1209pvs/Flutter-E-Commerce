import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/models/product.dart';
import 'package:flutter_e_commerce/models/product_cart.dart';
import 'package:flutter_e_commerce/models/product_cart_saved.dart';
import 'package:flutter_e_commerce/models/product_with_quantity.dart';
import 'package:flutter_e_commerce/widgets/shopping_cart_item.dart';
import 'package:http/http.dart' as http;

class ShoppingCart extends StatefulWidget {
  const ShoppingCart({super.key});

  @override
  State<ShoppingCart> createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  List<ProductWithQuantity> cart = [];

  void fetchCartItems() async {
    // get id of product in cart
    http.Response response = await http.get(
      Uri.parse("https://fakestoreapi.com/carts/1"),
    );

    // products from id
    var productsInCart = ProductCart.fromJson(
      jsonDecode(response.body),
    ).products;

    var products = productsInCart
        .map(
          (productCartSaved) => http.get(
            Uri.parse(
              "https://fakestoreapi.com/products/${productCartSaved.productId}",
            ),
          ),
        )
        .toList();

    var temp = (await Future.wait(
      products,
    )).map((response) => Product.fromJson(jsonDecode(response.body))).toList();

    List<ProductWithQuantity> prodsWithQuantity = [];

    for (var i = 0; i < products.length; i++) {
      prodsWithQuantity.add(
        ProductWithQuantity(
          product: temp[i],
          quantity: productsInCart[i].quantity!,
        ),
      );
    }

    setState(() {
      cart = prodsWithQuantity;
    });
  }

  double subtotal() {
    double total = 0.0;

    for (final item in cart) {
      total += item.quantity * item.product.price;
    }
    return total;
  }

  @override
  void initState() {
    super.initState();
    fetchCartItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cart")),
      body: ListView(
        children: <Widget>[
          ListView.builder(
            shrinkWrap: true,
            itemCount: cart.length,
            itemBuilder: (context, index) {
              return ShoppingCartItem(product: cart[index]);
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                  "Subtotal:",
                ),
              ),
              Expanded(
                child: Text(
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                  "\$${subtotal()}",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
