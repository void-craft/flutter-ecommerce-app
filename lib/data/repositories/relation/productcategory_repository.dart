import 'package:bagit/features/shop/models/category_model.dart';
import 'package:bagit/features/shop/models/product/product_model.dart';
import 'package:bagit/features/shop/models/relations/product_category_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductCategoryRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

   // Fetch all product-category relations
  Future<List<ProductCategoryModel>> getAllRelations() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await _db.collection('ProductCategories').get();
      return snapshot.docs.map((doc) => ProductCategoryModel.fromSnapshot(doc)).toList();
    } catch (e) {
      throw Exception('Failed to fetch product-category relations: $e');
    }
  }

  // Fetch all products from Firestore
  Future<List<ProductModel>> getAllProducts() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await _db.collection('Products').get();
      return snapshot.docs.map((doc) => ProductModel.fromSnapshot(doc)).toList();
    } catch (e) {
      throw Exception('Failed to fetch products: $e');
    }
  }

  // Fetch all categories from Firestore
  Future<List<CategoryModel>> getAllCategories() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await _db.collection('Categories').get();
      return snapshot.docs.map((doc) => CategoryModel.fromSnapshot(doc)).toList();
    } catch (e) {
      throw Exception('Failed to fetch categories: $e');
    }
  }

  // Add product-category relation
  Future<void> addRelation(String productId, String categoryId) async {
    try {
      await _db.collection('ProductCategories').add({
        'productId': productId,
        'categoryId': categoryId,
      });
    } catch (e) {
      throw Exception('Failed to add relation: $e');
    }
  }

  // Remove product-category relation
  Future<void> removeRelation(String productId, String categoryId) async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await _db.collection('ProductCategories')
          .where('productId', isEqualTo: productId)
          .where('categoryId', isEqualTo: categoryId)
          .get();

      for (var doc in snapshot.docs) {
        await doc.reference.delete();
      }
    } catch (e) {
      throw Exception('Failed to remove relation: $e');
    }
  }
}
