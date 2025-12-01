import 'package:flutter/material.dart';

class CategoryChip extends StatefulWidget {
  const CategoryChip({super.key});

  @override
  State<CategoryChip> createState() => _CategoryChipState();
}

class _CategoryChipState extends State<CategoryChip> {

  int? _value = 0;
  List<String> chipsNames = ["All", "Electronics", "Clothing", "Books"];

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      children: List<Widget>.generate(chipsNames.length, (int index) {
        return ChoiceChip(
          label: Text(chipsNames[index]),
          selected: _value == index,
          onSelected: (bool selected) {
            setState(() {
              _value = selected ? index : null;
            });
          },
        );
      }),
    );
  }
}
