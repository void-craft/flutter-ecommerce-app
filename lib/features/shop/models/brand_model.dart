import 'package:cloud_firestore/cloud_firestore.dart';

class BrandModel {
  String id;
  String name;
  String image;
  bool? isFeatured;
  int? productsCount;
  

  BrandModel({
    required this.id,
    required this.name,
    required this.image,
    this.productsCount,
    this.isFeatured,
  });

  // Empty helper function
  static BrandModel empty() => BrandModel(id: '', name: '', image: '');

  // convert model to JSON
  toJson() {
    return {
      'Id': id,
      'Name': name,
      'Image': image,
      'ProductsCount': productsCount,
      'IsFeatured': isFeatured,
    };
  }

  // Map Json oriented document snapshot from firebase to usermodel
  factory BrandModel.fromJson(Map<String, dynamic> document) {
    final data = document;
    if (data.isEmpty) return BrandModel.empty();
    return BrandModel(
      id: data['Id'] ?? '',
      name: data['Name'] ?? '',
      image: data['Image'] ?? '',
      productsCount: int.parse((data['ProductsCount'] ?? 0).toString()),
      isFeatured: data['IsFeatured'] ?? false,
    );
  }

  // Convert a Firestore document snapshot to a BrandModel instance
  factory BrandModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      // Map JSON record to the model
      return BrandModel(
        id: document.id,
        name: data['Name'] ?? '',
        image: data['Image'] ?? '',
        productsCount: data['productsCount'] ?? '',
        isFeatured: data['isFeatured'] ?? false,
      );
    } else {
      // Return an empty model if the document has no data
      return BrandModel.empty();
    }
  }
}
