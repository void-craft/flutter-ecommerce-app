import 'package:bagit/features/shop/models/relations/product_category_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductCategoryRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Fetch all product-category relations
  Future<List<ProductCategoryModel>> getAllRelations() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await _db.collection('ProductCategories').get();
      return snapshot.docs
          .map((doc) => ProductCategoryModel.fromSnapshot(doc))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch product-category relations: $e');
    }
  }

  // Fetch all assigned product IDs to filter displayed products
  Future<List<String>> fetchAssignedProductIds() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await _db.collection('ProductCategories').get();
      return snapshot.docs
          .map((doc) => doc['productId'] as String)
          .toSet() // Use Set to eliminate duplicates
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch assigned product IDs: $e');
    }
  }

  // Check if a specific product-category relation exists
  Future<bool> relationExists(String productId, String categoryId) async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await _db
          .collection('ProductCategories')
          .where('productId', isEqualTo: productId)
          .where('categoryId', isEqualTo: categoryId)
          .get();
      return snapshot.docs.isNotEmpty;
    } catch (e) {
      throw Exception('Failed to check relation existence: $e');
    }
  }

  // Add product-category relation
  Future<void> addRelation(String productId, String categoryId) async {
    try {
      if (!await relationExists(productId, categoryId)) {
        await _db.collection('ProductCategories').add({
          'productId': productId,
          'categoryId': categoryId,
        });
      }
    } catch (e) {
      throw Exception('Failed to add relation: $e');
    }
  }

  // Remove product-category relation
  Future<void> removeRelation(String productId, String categoryId) async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await _db
          .collection('ProductCategories')
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

  // Add multiple product-category relations
  Future<void> addProductToCategories(String productId, List<String> categoryIds) async {
    try {
      WriteBatch batch = _db.batch();
      final collection = _db.collection('ProductCategories');

      for (String categoryId in categoryIds) {
        final docRef = collection.doc();
        batch.set(docRef, {
          'productId': productId,
          'categoryId': categoryId,
        });
      }

      await batch.commit(); // Commit all writes in a single batch
    } catch (e) {
      throw Exception('Failed to add product to multiple categories: $e');
    }
  }
  
}
