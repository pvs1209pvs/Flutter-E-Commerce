import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/providers/products_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MySeach extends ConsumerStatefulWidget {
  const MySeach({super.key});

  @override
  ConsumerState<MySeach> createState() => _MySeachState();
}

class _MySeachState extends ConsumerState<MySeach> {
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textController,
      onChanged: (value) => {
        ref.read(searchQueryNotifierProvider.notifier).updateQuery(value),
      },
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.search),
        suffixIcon: GestureDetector(
          onTap: () {
            textController.clear();
            ref.read(searchQueryNotifierProvider.notifier).updateQuery('');
            FocusScope.of(context).unfocus();
          },
          child: Icon(Icons.close),
        ),
        border: OutlineInputBorder(),
        hintText: "Search for products",
      ),
    );
  }
}
