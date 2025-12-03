import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_e_commerce/models/product.dart';
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
  final searchRef = ref.watch(searchQueryNotifierProvider);
  final categoryQuery = ref.watch(categoryQueryNotifierProvider);
  log("search query $searchRef");
  log("category query $categoryQuery");
  final filteredProducts = ref.watch(productProvider).whenData((cb) {
    if ((searchRef == null || searchRef.isEmpty) &&
        (categoryQuery == null || categoryQuery == "All")) {
      log("returning original");
      return cb;
    } else {
      return cb
          .where(
            (test) =>
                test.title.toLowerCase().contains(
                  searchRef.toString().toLowerCase(),
                ) ||
                test.category.toLowerCase().contains(
                  categoryQuery.toString().toLowerCase(),
                ),
          )
          .toList();
    }
  });
  return filteredProducts;
});
