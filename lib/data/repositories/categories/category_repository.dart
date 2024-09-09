import 'dart:io';
import 'package:bagit/features/shop/models/category_model.dart';
import 'package:bagit/features/shop/models/product/product_model.dart';
import 'package:bagit/utils/exceptions/firebase_exceptions.dart';
import 'package:bagit/utils/exceptions/platform_exceptions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CategoryRepository extends GetxController {
  static CategoryRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // --- Get all categories
  Future<List<CategoryModel>> getAllCategories() async {
    try {
      final snapshot = await _db.collection('Categories').get();
      return snapshot.docs
          .map((document) => CategoryModel.fromSnapshot(document))
          .toList();
    } on FirebaseException catch (e) {
      throw CustomFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw CustomPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  // --- Get products by category or subcategory
  Future<List<ProductModel>> getProductsByCategory(String categoryId) async {
    try {
      final snapshot = await _db
          .collection('Products')
          .where('CategoryId', isEqualTo: categoryId)
          .get();
      return snapshot.docs
          .map((document) => ProductModel.fromSnapshot(document))
          .toList();
    } on FirebaseException catch (e) {
      throw CustomFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw CustomPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  // --- Upload category with automatic ID assignment
  Future<void> uploadCategory({
    required File imageFile,
    required String targetScreen,
    required bool active,
  }) async {
    try {
      // Ensure user is authenticated
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw 'User is not authenticated.';
      }

      // Create a unique file name and upload the image
      String fileName = 'categories/${DateTime.now().millisecondsSinceEpoch}.png';
      UploadTask uploadTask = _storage.ref(fileName).putFile(imageFile);
      TaskSnapshot uploadSnapshot = await uploadTask;

      if (uploadSnapshot.state == TaskState.success) {
        // Get download URL
        String downloadURL = await uploadSnapshot.ref.getDownloadURL();

        // Determine the next document ID
        final categoryCollection = _db.collection('Categories');
        final categoriesSnapshot = await categoryCollection.get();
        final ids = categoriesSnapshot.docs.map((doc) => int.tryParse(doc.id) ?? 0).toList();
        final nextId = (ids.isNotEmpty ? ids.reduce((a, b) => a > b ? a : b) + 1 : 1).toString();

        // Create a new category document with the next ID
        final category = CategoryModel(
          id: nextId,
          name: '',
          image: downloadURL,
          isFeatured: true,
        );

        await categoryCollection.doc(nextId).set(category.toJson());
      }
    } on FirebaseException catch (e) {
      throw CustomFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw CustomPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }
}
