import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/product.dart';
import 'package:flutter_e_commerce/product_card.dart';
import 'package:flutter_e_commerce/rating.dart';
import 'package:http/http.dart' as http;

class ProductsList extends StatefulWidget {
  const ProductsList({super.key});

  @override
  State<ProductsList> createState() => _ProductsListState();
}

class _ProductsListState extends State<ProductsList> {
  List<Product> products = [];

  void fetchProduct() async {
    Uri uri = Uri.parse("https://fakestoreapi.com/products");
    http.Response response = await http.get(uri);
    var body = jsonDecode(response.body) as List<dynamic>;

    setState(() {
      products = body
          .map(
            (item) => Product(
              id: item['id'],
              title: item['title'],
              price: item['price'],
              desc: item['description'],
              category: item['category'],
              imageUrl: item['image'],
              rating: Rating(
                rate: item['rating']['rate'],
                count: item['rating']['count'],
              ),
            ),
          )
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    fetchProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.count(
        crossAxisCount: 2,
        children: List.generate(products.length, (index) {
          return ProductCard(product: products[index]);
        }),
      ),
    );

    return Expanded(
      child: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ProductCard(product: products[index]);
        },
      ),
    );
  }
}
