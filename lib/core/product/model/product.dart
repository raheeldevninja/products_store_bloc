import 'package:products_store_bloc/core/product/model/rating.dart';

class Product {
  final int? id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final Rating? rating;
  final int? quantity;

  Product({
    this.id,
    this.rating,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    this.quantity,

  });

  // Factory constructor for creating a Product instance from JSON
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      price: json['price'].toDouble(),
      description: json['description'],
      category: json['category'],
      image: json['image'],
      rating: Rating.fromJson(json['rating']),
      quantity: json['quantity'],
    );
  }

  // Method to convert a Product instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'description': description,
      'category': category,
      'image': image,
      'rating': rating?.toJson(),
      'quantity': quantity,
    };
  }
}
