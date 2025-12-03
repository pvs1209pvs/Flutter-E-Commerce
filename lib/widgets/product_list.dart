import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/models/product.dart';
import 'package:flutter_e_commerce/providers/products_provider.dart';
import 'package:flutter_e_commerce/widgets/product_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductsList extends ConsumerStatefulWidget {
  // final List<Product> products;

  const ProductsList({super.key});

  @override
  ConsumerState<ProductsList> createState() => _ProductsListState();
}

class _ProductsListState extends ConsumerState<ProductsList> {
  @override
  Widget build(BuildContext context) {
    AsyncValue<List<Product>> allProducts = ref.watch(filterProd);

    return Expanded(child: 
      allProducts.when(
      data: (data) => GridView.builder(
        cacheExtent: MediaQuery.of(context).size.height * 1,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          return ProductCard(product: data[index]);
        },
      ),
      error: (error, stackTrace) => Center(child: Text("error")),
      loading: () => Center(child: CircularProgressIndicator()),
    )
    );

  }
}
