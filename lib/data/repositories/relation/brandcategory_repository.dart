import 'package:bagit/features/shop/models/relations/brand_category_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BrandCategoryRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Fetch all brand-category relations
  Future<List<BrandCategoryModel>> getAllRelations() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await _db.collection('BrandCategories').get();
      return snapshot.docs
          .map((doc) => BrandCategoryModel.fromSnapshot(doc))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch brand-category relations: $e');
    }
  }

  // Fetch all assigned brand IDs to filter displayed brands
  Future<List<String>> fetchAssignedBrandIds() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await _db.collection('BrandCategories').get();
      return snapshot.docs
          .map((doc) => doc['brandId'] as String)
          .toSet() // Use Set to eliminate duplicates
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch assigned brand IDs: $e');
    }
  }

  // Check if a specific brand-category relation exists
  Future<bool> relationExists(String brandId, String categoryId) async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await _db
          .collection('BrandCategories')
          .where('brandId', isEqualTo: brandId)
          .where('categoryId', isEqualTo: categoryId)
          .get();
      return snapshot.docs.isNotEmpty;
    } catch (e) {
      throw Exception('Failed to check relation existence: $e');
    }
  }

  // Add brand-category relation
  Future<void> addRelation(String brandId, String categoryId) async {
    try {
      if (!await relationExists(brandId, categoryId)) {
        await _db.collection('BrandCategories').add({
          'brandId': brandId,
          'categoryId': categoryId,
        });
      }
    } catch (e) {
      throw Exception('Failed to add relation: $e');
    }
  }

  // Remove brand-category relation
  Future<void> removeRelation(String brandId, String categoryId) async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await _db
          .collection('BrandCategories')
          .where('brandId', isEqualTo: brandId)
          .where('categoryId', isEqualTo: categoryId)
          .get();

      for (var doc in snapshot.docs) {
        await doc.reference.delete();
      }
    } catch (e) {
      throw Exception('Failed to remove relation: $e');
    }
  }

  // Add multiple brand-category relations
  Future<void> addBrandToCategories(String brandId, List<String> categoryIds) async {
    try {
      WriteBatch batch = _db.batch();
      final collection = _db.collection('BrandCategories');

      for (String categoryId in categoryIds) {
        final docRef = collection.doc();
        batch.set(docRef, {
          'brandId': brandId,
          'categoryId': categoryId,
        });
      }

      await batch.commit(); // Commit all writes in a single batch
    } catch (e) {
      throw Exception('Failed to add brand to multiple categories: $e');
    }
  }
}
