import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:nativewrappers/_internal/vm/lib/ffi_native_type_patch.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter_e_commerce/models/product.dart';
import 'package:flutter_e_commerce/models/product_cart.dart';
import 'package:flutter_e_commerce/models/product_with_quantity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class SearchQueryNotifier extends Notifier<String?> {
  @override
  String? build() {
    return null;
  }

  void updateQuery(String? text) {
    state = text;
  }
}

class CategoryQueryNotifier extends Notifier<String?> {
  @override
  String? build() {
    return "All";
  }

  void updateQuery(String? newValue) {
    state = newValue;
  }
}

final categoryQueryNotifierProvider = NotifierProvider(
  () => CategoryQueryNotifier(),
);

final searchQueryNotifierProvider = NotifierProvider(
  () => SearchQueryNotifier(),
);

class ProductNotifier extends AsyncNotifier<List<Product>> {
  @override
  FutureOr<List<Product>> build() async {
    Uri uri = Uri.parse("https://fakestoreapi.com/products");
    http.Response response = await http.get(uri);
    var body = jsonDecode(response.body) as List<dynamic>;
    var result = body.map((item) => Product.fromJson(item)).toList();
    return result;
  }
}

final productProvider = AsyncNotifierProvider<ProductNotifier, List<Product>>(
  () => ProductNotifier(),
);

final filterProd = Provider<AsyncValue<List<Product>>>((ref) {

  
  final searchQuery = ref.watch(searchQueryNotifierProvider);
  final categoryQuery = ref.watch(categoryQueryNotifierProvider);

  log("search query $searchQuery");
  log("category query $categoryQuery");

  final filteredProducts = ref.watch(productProvider).whenData((cb) {
    if ((searchQuery == null || searchQuery.isEmpty) &&
        (categoryQuery == null || categoryQuery == "All")) {
      log("returning original");
      return cb;
    }

    return cb
        .where(
          (test) =>
              test.title.toLowerCase().contains(
                searchQuery.toString().toLowerCase(),
              ) ||
              test.category.toLowerCase().contains(
                categoryQuery.toString().toLowerCase(),
              ),
        )
        .toList();
  });

  return filteredProducts;
});

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
}

final shoppingCartNotifierProvider =
    AsyncNotifierProvider<ShoppingCartNotifier, List<ProductWithQuantity>>(
      () => ShoppingCartNotifier(),
    );

final cartTotalProvider = Provider<double>((ref) {
  final cartProducts = ref.watch(shoppingCartNotifierProvider);

  return cartProducts.maybeWhen(
    data: (state) => state
        .map((prod) => prod.product.price * prod.quantity)
        .fold(0.0, (prev, value) => prev + value),
    orElse: () => 0.0,
  );
});
