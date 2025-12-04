import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/models/product.dart';
import 'package:flutter_e_commerce/models/product_cart_saved.dart';
import 'package:flutter_e_commerce/models/product_with_quantity.dart';
import 'package:flutter_e_commerce/models/rating.dart';
import 'package:flutter_e_commerce/providers/shoopping_cart_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShoppingCartItem extends ConsumerWidget {
  final ProductWithQuantity product;

  const ShoppingCartItem({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: Row(
        spacing: 8,
        children: <Widget>[
          SizedBox(
            width: 100,
            height: 100,
            child: CachedNetworkImage(
              imageUrl: product.product.imageUrl,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          Expanded(
            child: Column(
              spacing: 8,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black87,
                    fontWeight: FontWeight.w600,
                  ),
                  product.product.title,
                ),
                Text(
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                  "\$${product.product.price * product.quantity}",
                ),
                Container(
                  margin: const EdgeInsets.all(8),
                  child: Row(
                    spacing: 8,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.purple[100],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: IconButton(
                          onPressed: () => {
                            ref
                                .read(shoppingCartNotifierProvider.notifier)
                                .updateQuantity(
                                  product.product.id,
                                  product.quantity - 1,
                                ),
                          },
                          icon: const Icon(Icons.remove),
                        ),
                      ),
                      Text(
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                        "${product.quantity}",
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.purple[100],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: IconButton(
                          onPressed: () => {
                            ref
                                .read(shoppingCartNotifierProvider.notifier)
                                .updateQuantity(
                                  product.product.id,
                                  product.quantity + 1,
                                ),
                          },
                          icon: const Icon(Icons.add),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
