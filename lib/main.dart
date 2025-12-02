import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/main_app.dart';
import 'package:flutter_e_commerce/product.dart';
import 'package:flutter_e_commerce/product_details_screen.dart';

void main() {
  runApp(
    MaterialApp(
      home: MainScreen(),
      onGenerateRoute: (settings) {
        if (settings.name == "/details") {
          return MaterialPageRoute(
            builder: (_) =>
                ProductDetailsScreen(product: settings.arguments as Product),
          );
        }
      },
    ),
  );
}
