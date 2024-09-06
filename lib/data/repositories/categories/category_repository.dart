import 'dart:io';
import 'package:bagit/features/shop/models/category_model.dart';
import 'package:bagit/features/shop/models/product_model.dart';
import 'package:bagit/utils/exceptions/firebase_exceptions.dart';
import 'package:bagit/utils/exceptions/platform_exceptions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CategoryRepository extends GetxController {
  static CategoryRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

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

  // --- Upload category (already implemented)
  Future<void> uploadCategory({
    required File imageFile,
    required String targetScreen,
    required bool active,
  }) async {
    // Implementation already provided
  }
}




// import 'package:bagit/data/services/cloud_storage/firebase_storage_service.dart';
// import 'package:bagit/features/shop/models/category_model.dart';
// import 'package:bagit/utils/exceptions/firebase_exceptions.dart';
// import 'package:bagit/utils/exceptions/platform_exceptions.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';

// class CategoryRepository extends GetxController {
//   static CategoryRepository get instance => Get.find();

//   // Variables
//   final _db = FirebaseFirestore.instance;

//   // Get all categories
//   Future<List<CategoryModel>> getAllCategories() async {
//     try {
//       final snapshot = await _db.collection('Categories').get();
//       final list = snapshot.docs
//           .map((document) => CategoryModel.fromSnapshot(document))
//           .toList();
//       return list;
//     } on FirebaseException catch (e) {
//       throw CustomFirebaseException(e.code).message;
//     } on PlatformException catch (e) {
//       throw CustomPlatformException(e.code).message;
//     } catch (e) {
//       throw 'Something went wrong. Please try again.';
//     }
//   }

//   // Get sub categories

//   // Upload categories to cloud firestore
//   Future<void> uploadDummyData(List<CategoryModel> categories) async {
//     try {
//       // Upload all the categories along with their images
//       final storage = Get.put(CustomFirebaseStorageService());

//       // Loop through each category
//       for (var category in categories) {
//         try {
//           // Get image data from assets
//           final file = await storage.getImageDataFromAssets(category.image);

//           // Upload image and get its URL
//           final url =
//               await storage.uploadImageData("Categories", file, category.name);

//           // Assign URL to category model before uploading
//           category.image = url;

//           // Upload the category to Firestore
//           await _db
//               .collection("Categories")
//               .doc(category.id)
//               .set(category.toJson());
//         } on FirebaseException catch (e) {
//           throw CustomFirebaseException(e.code).message;
//         } on PlatformException catch (e) {
//           throw CustomPlatformException(e.code).message;
//         } catch (e) {
//           throw "Something went wrong, please try again.";
//         }
//       }
//     } catch (e) {
//       throw 'Something went wrong, please try again.';
//     }
//   }
// }
