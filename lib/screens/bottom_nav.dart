import 'package:flutter/material.dart';

class BottomNavigationBarCustom extends StatefulWidget {
  const BottomNavigationBarCustom({super.key, required this.onTabSelect});

  final ValueChanged<int> onTabSelect;

  @override
  State<BottomNavigationBarCustom> createState() =>
      _BottomNavigationBarCustomState();
}

class _BottomNavigationBarCustomState extends State<BottomNavigationBarCustom> {
  int selectWidget = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.shop), label: "Cart"),
      ],
      currentIndex: selectWidget,
      selectedItemColor: Colors.purple[800],
      onTap: (int index) {
        widget.onTabSelect(index);
        setState(() {
          selectWidget = index;
        });
      },
    );
  }
}
