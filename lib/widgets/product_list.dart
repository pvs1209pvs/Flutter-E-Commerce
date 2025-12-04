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

    return Expanded(
      child: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(productProvider);
        },
        child: LayoutBuilder(
          builder: (context, constrains) {
            return allProducts.when(
              data: (data) => data.isEmpty
                  ? const Center(
                      child: Text(
                        style: TextStyle(fontSize: 24, color: Colors.black87),
                        "No products found",
                      ),
                    )
                  : GridView.builder(
                      cacheExtent: MediaQuery.of(context).size.height * 1,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ProductCard(product: data[index]);
                      },
                    ),
              error: (error, stackTrace) => SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: SizedBox(
                  height: constrains.maxHeight,
                  child: Center(child: Text(error.toString())),
                ),
              ),
              loading: () => SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: SizedBox(
                  height: constrains.maxHeight,
                  child: const Center(child: CircularProgressIndicator()),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
