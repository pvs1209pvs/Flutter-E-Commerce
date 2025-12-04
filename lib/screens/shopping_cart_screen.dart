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
      appBar: AppBar(title: const Text("Cart")),
      body: cart.when(
        data: (data) {
          if (data.isEmpty) {
            return const Center(child: Text("Your shopping cart is empty"));
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ...data.map((product) => ShoppingCartItem(product: product)),
                if (cartTotal > 0)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Subtotal:",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        "\$$cartTotal",
                        textAlign: TextAlign.end,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) =>
            const Center(child: Text("Something went wrong, please try again")),
      ),
    );
    ;
  }
}
