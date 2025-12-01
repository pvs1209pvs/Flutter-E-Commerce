import 'package:flutter_e_commerce/rating.dart';

class Product {
  int id;
  String title;
  num price;
  String desc;
  String category;
  String imageUrl;
  Rating rating;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.desc,
    required this.category,
    required this.imageUrl,
    required this.rating,
  });

}
