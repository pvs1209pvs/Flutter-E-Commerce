import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/providers/products_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryChip extends ConsumerStatefulWidget {
  const CategoryChip({super.key});

  @override
  ConsumerState<CategoryChip> createState() => _CategoryChipState();
}

class _CategoryChipState extends ConsumerState<CategoryChip> {
  int? _value = 0;
  List<String> chipsNames = [
    "All",
    "Jewelery",
    "Men's Clothing",
    "Women's Clothing",
    "Electronics",
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        spacing: 10,
        children: List<Widget>.generate(chipsNames.length, (int index) {
          return ChoiceChip(
            label: Text(chipsNames[index]),
            selected: _value == index,
            onSelected: (bool selected) {
              ref
                  .read(categoryQueryNotifierProvider.notifier)
                  .updateQuery(selected ? chipsNames[index] : null);
              setState(() {
                _value = selected ? index : null;
              });
            },
          );
        }),
      ),
    );
  }
}
