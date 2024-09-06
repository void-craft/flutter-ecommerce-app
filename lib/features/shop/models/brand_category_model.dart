import 'package:cloud_firestore/cloud_firestore.dart';

class BrandCategoryModel {
  final String brandId;
  final String categoryId;

  BrandCategoryModel({
    required this.brandId,
    required this.categoryId,
  });

  // Converts a Firestore document snapshot into a BrandCategoryModel instance
  factory BrandCategoryModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return BrandCategoryModel(
      brandId: data['brandId'] ?? '',
      categoryId: data['categoryId'] ?? '',
    );
  }

  // Converts a BrandCategoryModel instance into a JSON map
  Map<String, dynamic> toJson() {
    return {
      'brandId': brandId,
      'categoryId': categoryId,
    };
  }
}
