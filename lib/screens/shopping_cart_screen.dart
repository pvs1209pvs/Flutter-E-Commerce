import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/models/product.dart';
import 'package:flutter_e_commerce/models/product_cart.dart';
import 'package:flutter_e_commerce/models/product_cart_saved.dart';
import 'package:flutter_e_commerce/models/product_with_quantity.dart';
import 'package:flutter_e_commerce/providers/products_provider.dart';
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
  Widget build(BuildContext context) {

    final AsyncValue<List<ProductWithQuantity>> cartProduct = ref.watch(
      shoppingCartNotifierProvider,
    );

    final double cartTotal = ref.watch(cartTotalProvider);

    return cartProduct.when(
      loading: () => CircularProgressIndicator(),
      error: (e, _) => Text(e.toString()),
      data: (data) => Scaffold(
        appBar: AppBar(title: Text("Cart")),
        body: ListView(
          children: <Widget>[
            ListView.builder(
              shrinkWrap: true,
              itemCount: data.length,
              itemBuilder: (context, index) {
                return ShoppingCartItem(product: data[index]);
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
                    "\$$cartTotal",
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
