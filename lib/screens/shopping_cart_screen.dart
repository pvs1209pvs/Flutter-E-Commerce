import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/models/product.dart';
import 'package:flutter_e_commerce/models/product_cart.dart';
import 'package:flutter_e_commerce/models/product_cart_saved.dart';
import 'package:flutter_e_commerce/models/product_with_quantity.dart';
import 'package:flutter_e_commerce/providers/shoopping_cart_provider.dart';
import 'package:flutter_e_commerce/widgets/shopping_cart_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class ShoppingCart extends ConsumerStatefulWidget {
  const ShoppingCart({super.key});

  @override
  ConsumerState<ShoppingCart> createState() => _ShoppingCartState();
}

class _ShoppingCartState extends ConsumerState<ShoppingCart> {
  // List<ProductWithQuantity> cart = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AsyncValue<List<ProductWithQuantity>> cart = ref.watch(
      shoppingCartNotifierProvider,
    );

    var cartTotal = ref.watch(cartTotalProvider);

    return Scaffold(
      appBar: AppBar(title: Text("Cart")),
      body: ListView(
        children: <Widget>[
          cart.when(
            data: (data) => ListView.builder(
              shrinkWrap: true,
              itemCount: data.length,
              itemBuilder: (context, index) {
                return ShoppingCartItem(product: data[index]);
              },
            ),
            error: (error, stackStack) => Text(error.toString()),
            loading: () => CircularProgressIndicator(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  style: const TextStyle(
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
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                  "\$$cartTotal",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
