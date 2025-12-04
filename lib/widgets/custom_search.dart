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
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) => {
        ref.read(searchQueryNotifierProvider.notifier).updateQuery(value),
      },
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.search),
        border: OutlineInputBorder(),
        hintText: 'Enter a search term',
      ),
    );
  }
}
