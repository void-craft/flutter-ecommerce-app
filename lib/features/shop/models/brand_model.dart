import 'package:cloud_firestore/cloud_firestore.dart';

class BrandModel {
  final String id;
  final String name;
  final String image;
  final int productsCount;
  final bool isFeatured;

  BrandModel({
    required this.id,
    required this.name,
    required this.image,
    required this.productsCount,
    required this.isFeatured,
  });

  // Convert JSON to BrandModel
  factory BrandModel.fromJson(Map<String, dynamic> json) {
    return BrandModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      productsCount: json['productsCount'] ?? 0,
      isFeatured: json['isFeatured'] ?? false,
    );
  }

  // Convert BrandModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'productsCount': productsCount,
      'isFeatured': isFeatured,
    };
  }

  // Convert a Firestore document snapshot to a BrandModel instance
  factory BrandModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return BrandModel(
      id: data['id'] ?? '',
      name: data['name'] ?? '',
      image: data['image'] ?? '',
      productsCount: data['productsCount'] ?? 0,
      isFeatured: data['isFeatured'] ?? false,
    );
  }
}
