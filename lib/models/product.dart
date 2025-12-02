import 'package:flutter_e_commerce/models/rating.dart';

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

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'price': price,
    'description': desc,
    'category': category,
    'image': imageUrl,
    'rating': rating.toJson(),
  };

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json['id'],
    title: json['title'],
    price: json['price'],
    desc: json['description'],
    category: json['category'],
    imageUrl: json['image'],
    rating: Rating.fromJson(json['rating']),
  );
}
