import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/product.dart';
import 'package:flutter_e_commerce/product_cart.dart';
import 'package:flutter_e_commerce/product_cart_saved.dart';
import 'package:flutter_e_commerce/shopping_cart_item.dart';
import 'package:http/http.dart' as http;

class ShoppingCart extends StatefulWidget {
  const ShoppingCart({super.key});

  @override
  State<ShoppingCart> createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  List<Product> cart = [];

  void fetchCartItems() async {
    // get id of product in cart
    http.Response response = await http.get(
      Uri.parse("https://fakestoreapi.com/carts/1"),
    );

    // products from id
    var productsInCart = ProductCart.fromJson(jsonDecode(response.body))
        .products
        .map(
          (productCartSaved) => http.get(
            Uri.parse(
              "https://fakestoreapi.com/products/${productCartSaved.productId}",
            ),
          ),
        )
        .toList();

    var multipleProducst = await Future.wait(productsInCart);

    setState(() {
      cart = multipleProducst
          .map((response) => Product.fromJson(jsonDecode(response.body)))
          .toList();
    });
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
      body: ListView.builder(
        itemCount: cart.length,
        itemBuilder: (context, index) {
          return ShoppingCartItem(product: cart[index]);
        },
      ),
    );
  }
}
