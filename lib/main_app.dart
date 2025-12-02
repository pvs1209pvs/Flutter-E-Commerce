import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/screens/bottom_nav.dart';
import 'package:flutter_e_commerce/screens/home_screen.dart';
import 'package:flutter_e_commerce/screens/shopping_cart_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int crntTab = 0;
  final List<Widget> tabs = [Home(), ShoppingCart()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[crntTab],
      bottomNavigationBar: BottomNavigationBarCustom(
        onTabSelect: (int value) {
          setState(() {
            crntTab = value;
          });
        },
      ),
    );
  }
}
