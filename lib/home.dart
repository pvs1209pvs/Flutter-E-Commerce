import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/category_chip.dart';
import 'package:flutter_e_commerce/product.dart';
import 'package:flutter_e_commerce/product_list.dart';
import 'package:flutter_e_commerce/rating.dart';
import 'package:flutter_e_commerce/search.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Product> products = [];
  List<Product> filteredList = [];

  void fetchProduct() async {
    Uri uri = Uri.parse("https://fakestoreapi.com/products");
    http.Response response = await http.get(uri);
    var body = jsonDecode(response.body) as List<dynamic>;

    setState(() {
      var fetchedProducts = body
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
      products = List.from(fetchedProducts);
      filteredList = List.from(fetchedProducts);
    });
  }

  @override
  void initState() {
    super.initState();
    fetchProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ShopEase")),
      body: Column(
        children: <Widget>[
          SearchBarCustom(
            productTitles: products
                .map((toElement) => toElement.title)
                .toList(),
            onSearchSubmit: (String? value) {
              log("onSearchSubmit callback result $value");
              setState(() {
                filteredList = products
                    .where(
                      (test) =>
                          test.title.toLowerCase().contains(value.toString().toLowerCase()),
                    )
                    .toList();
              });

              for (var item in filteredList) {
                log("search bar ${item.title}");
              }
            },
          ),
          CategoryChip(
            onChipSelect: (String? value) {
              if (value == null) {
                setState(() {
                  filteredList = products;
                });
              } else {
                setState(() {
                  filteredList = products
                      .where(
                        (test) =>
                            test.category == value.toLowerCase() ||
                            value == "All",
                      )
                      .toList();
                });
              }
            },
          ),
          ProductsList(products: filteredList),
        ],
      ),
    );
  }
}
