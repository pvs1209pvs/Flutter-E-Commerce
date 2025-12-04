import 'dart:convert';
import 'dart:developer';
import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/models/product.dart';
import 'package:flutter_e_commerce/providers/shoopping_cart_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class ProductDetailsCard extends ConsumerStatefulWidget {
  final Product product;

  const ProductDetailsCard({super.key, required this.product});

  @override
  ConsumerState<ProductDetailsCard> createState() => _ProductDetailsCardState();
}

class _ProductDetailsCardState extends ConsumerState<ProductDetailsCard> {
  int qty = 1;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(8),
      child: Column(
        spacing: 16,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CachedNetworkImage(
            imageUrl: widget.product.imageUrl,
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          Text(
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black87,
              fontWeight: FontWeight.w600,
            ),
            widget.product.title,
          ),
          Text(
            style: const TextStyle(fontSize: 24, color: Colors.black87),
            "\$${widget.product.price}",
          ),
          Text(widget.product.desc),
          Row(
            spacing: 16,
            children: <Widget>[
              const Text(
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
                "Qty:",
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.purple[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: IconButton(
                  onPressed: () => setState(() {
                    qty = max(1, qty - 1);
                  }),
                  icon: const Icon(Icons.remove),
                ),
              ),
              Text(
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
                "$qty",
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.purple[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: IconButton(
                  onPressed: () => setState(() {
                    qty++;
                  }),
                  icon: const Icon(Icons.add),
                ),
              ),
            ],
          ),
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.purple,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () async {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: Duration(seconds: 2),
                  content: Text("${widget.product.title} added to cart"),
                ),
              );

              ref
                  .watch(shoppingCartNotifierProvider.notifier)
                  .addToCart(widget.product, qty);
            },
            child: const Text("Add to cart"),
          ),
        ],
      ),
    );
  }
}
