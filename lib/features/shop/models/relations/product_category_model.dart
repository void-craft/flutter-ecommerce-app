import 'package:cloud_firestore/cloud_firestore.dart';

class ProductCategoryModel {
  final String productId;
  final String categoryId;

  ProductCategoryModel({
    required this.productId,
    required this.categoryId,
  });

  // Convert a ProductCategoryModel instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'categoryId': categoryId,
    };
  }

  // Convert a Firestore document snapshot to a ProductCategoryModel instance
  factory ProductCategoryModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();

    if (data != null) {
      return ProductCategoryModel(
        productId: data['productId'] ?? '',
        categoryId: data['categoryId'] ?? '',
      );
    } else {
      throw Exception('Document does not contain data');
    }
  }
}
