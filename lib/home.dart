import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/category_chip.dart';
import 'package:flutter_e_commerce/product_list.dart';
import 'package:flutter_e_commerce/search.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ShopEase")),
      body: Column(
        children: <Widget>[SearchBarCustom(), CategoryChip(), ProductsList()],
      ),
    );
  }
}
