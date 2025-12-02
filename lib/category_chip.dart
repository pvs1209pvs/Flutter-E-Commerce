import 'package:flutter/material.dart';

class CategoryChip extends StatefulWidget {
  const CategoryChip({super.key, required this.onChipSelect});

  final ValueChanged<String?> onChipSelect;

  @override
  State<CategoryChip> createState() => _CategoryChipState();
}

class _CategoryChipState extends State<CategoryChip> {
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
              widget.onChipSelect(selected ? chipsNames[index] : null);
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
