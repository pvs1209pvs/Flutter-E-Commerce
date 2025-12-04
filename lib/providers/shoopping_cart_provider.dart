import 'dart:async';
import 'dart:convert';

import 'package:flutter_e_commerce/models/product.dart';
import 'package:flutter_e_commerce/models/product_cart.dart';
import 'package:flutter_e_commerce/models/product_with_quantity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class ShoppingCartNotifier extends AsyncNotifier<List<ProductWithQuantity>> {
  @override
  FutureOr<List<ProductWithQuantity>> build() async {
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

    return prodsWithQuantity;
  }

  void updateQuantity(int id, int q) {
    state = state.whenData((items) {
      return items.map((item) {
        if (item.product.id == id) {
          return ProductWithQuantity(quantity: q, product: item.product);
        }
        return item;
      }).toList();
    });
  }
}

final shoppingCartNotifierProvider =
    AsyncNotifierProvider<ShoppingCartNotifier, List<ProductWithQuantity>>(
      () => ShoppingCartNotifier(),
    );

final cartTotalProvider = Provider<double>((ref) {
  return ref
      .watch(shoppingCartNotifierProvider)
      .maybeWhen(
        data: (state) => state
            .map((prod) => prod.product.price * prod.quantity)
            .fold(0.0, (prev, value) => prev + value),
        orElse: () => 0.0,
      );
});
