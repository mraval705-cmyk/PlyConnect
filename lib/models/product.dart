import 'dart:convert';

/// One product as an object instead of loose values. This is the class idea
/// from the reading material.
class Product {
  String name;
  String brand;
  String category;
  String thickness;
  String price;
  String image;

  Product({
    required this.name,
    required this.brand,
    required this.category,
    required this.thickness,
    required this.price,
    required this.image,
  });

  /// Firestore document  →  Product
  factory Product.fromMap(Map<String, dynamic> data) {
    return Product(
      name: '${data['name'] ?? ''}',
      brand: '${data['brand'] ?? ''}',
      category: '${data['category'] ?? ''}',
      thickness: '${data['thickness'] ?? ''}',
      price: '${data['price'] ?? 0}',
      image: '${data['image'] ?? 'assets/images/club_prime.png'}',
    );
  }

  /// Product  →  a plain map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'brand': brand,
      'category': category,
      'thickness': thickness,
      'price': price,
      'image': image,
    };
  }

  /// Product  →  json text, used by shared_preferences
  String toJson() {
    return jsonEncode(toMap());
  }

  /// json text  →  Product
  factory Product.fromJson(String text) {
    return Product.fromMap(jsonDecode(text) as Map<String, dynamic>);
  }
}