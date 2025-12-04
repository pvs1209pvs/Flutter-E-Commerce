import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/providers/products_provider.dart';
import 'package:flutter_e_commerce/widgets/category_chip.dart';
import 'package:flutter_e_commerce/models/product.dart';
import 'package:flutter_e_commerce/widgets/custom_search.dart';
import 'package:flutter_e_commerce/widgets/product_list.dart';
import 'package:flutter_e_commerce/widgets/search.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("ShopEase")),
      body: Container(
        margin: const EdgeInsets.all(8),
        child: Column(
          spacing: 8,
          children: <Widget>[MySeach(), CategoryChip(), ProductsList()],
        ),
      ),
    );
  }
}
