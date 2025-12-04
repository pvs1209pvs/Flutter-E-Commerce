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

    List<Product> l = [];
    l.addAll(result);

    for(final Product item in l){
      log("${item.title} ${item.category}");
    }

    return l;
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

  return ref.watch(productProvider).whenData((cb) {
    var result = cb;

    log("products length ${result.length}");

    if (searchQuery != null && searchQuery.isNotEmpty) {
      result = result
          .where(
            (p) => p.title.toLowerCase().contains(searchQuery.toLowerCase()),
          )
          .toList();
    }

    if (categoryQuery != null && categoryQuery != "All") {
      result = result
          .where(
            (p) =>
                p.category.toLowerCase().startsWith(categoryQuery.toLowerCase()),
          )
          .toList();
    }

    return result;
  });
});
