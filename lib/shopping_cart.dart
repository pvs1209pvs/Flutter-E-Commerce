import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/product.dart';
import 'package:flutter_e_commerce/product_cart.dart';
import 'package:flutter_e_commerce/product_cart_saved.dart';
import 'package:flutter_e_commerce/product_with_quantity.dart';
import 'package:flutter_e_commerce/shopping_cart_item.dart';
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

    var multipleProducts = await Future.wait(products);

    var temp = multipleProducts
        .map((response) => Product.fromJson(jsonDecode(response.body)))
        .toList();

    List<ProductWithQuantity> x = [];

    for (var i = 0; i < products.length; i++) {
      x.add(
        ProductWithQuantity(
          product: temp[i],
          quantity: productsInCart[i].quantity!,
        ),
      );
    }

    setState(() {
      cart = x;
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
