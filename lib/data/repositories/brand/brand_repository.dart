import 'package:bagit/data/services/cloud_storage/firebase_storage_service.dart';
import 'package:bagit/features/shop/models/brand_model.dart';
import 'package:bagit/utils/exceptions/firebase_exceptions.dart';
import 'package:bagit/utils/exceptions/format_exceptions.dart';
import 'package:bagit/utils/exceptions/platform_exceptions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class BrandRepository extends GetxController {
  static BrandRepository get instance => Get.find();

  // Variables
  final _db = FirebaseFirestore.instance;

  // Get all brands
  Future<List<BrandModel>> getAllBrands() async {
    try {
      final snapshot = await _db.collection('Brands').get();
      final result = snapshot.docs
          .map((e) => BrandModel.fromSnapshot(e))
          .toList();
      return result;
    } on FirebaseException catch (e) {
      throw CustomFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const CustomFormatException();
    } on PlatformException catch (e) {
      throw CustomPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong while fetching the brands.';
    }
  }

  // Get Brands for category
  Future<List<BrandModel>> getBrandsForCategory(String categoryId) async {
    try {
      // Query to get all documents where categoryId matches the provided categoryId
      QuerySnapshot brandCategoryQuery = await _db.collection('BrandCategory').where('categoryId', isEqualTo: categoryId).get();

      // Extract brandIds from the documents
      List<String> brandIds = brandCategoryQuery.docs.map((doc) => doc['brandId'] as String).toList();

      // Query to get all documents where  the brandId is in the list of brandIds, FieldPath.documentId to query documents in Collection
      final brandsQuery = await _db.collection('Brands').where(FieldPath.documentId, whereIn: brandIds).limit(2).get();

      // Extract brand names or other relevant data from the documents
      List<BrandModel> brands = brandsQuery.docs.map((doc) => BrandModel.fromSnapshot(doc)).toList();

      return brands;

    } on FirebaseException catch (e) {
      throw CustomFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const CustomFormatException();
    } on PlatformException catch (e) {
      throw CustomPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong while fetching the brands.';
    }
  }

//////
  Future<void> uploadDummyData(List<BrandModel> brands) async {
    try {
      final storage = Get.put(CustomFirebaseStorageService());

      for (var brand in brands) {
        try {
          // Get image data from assets
          final file = await storage.getImageDataFromAssets(brand.image);

          // Upload image and get its URL
          final url = await storage.uploadImageData("Brands", file, brand.name);

          // Create a new BrandModel with the updated image URL
          final updatedBrand = BrandModel(
            id: brand.id,
            image: url,
            name: brand.name,
            productsCount: brand.productsCount,
            isFeatured: brand.isFeatured,
          );

          // Upload the brand to Firestore
          await _db
              .collection("Brands")
              .doc(brand.id)
              .set(updatedBrand.toJson());
        } on FirebaseException catch (e) {
          throw CustomFirebaseException(e.code).message;
        } on FormatException catch (_) {
          throw const CustomFormatException();
        } on PlatformException catch (e) {
          throw CustomPlatformException(e.code).message;
        } catch (e) {
          throw "Something went wrong, please try again.";
        }
      }
    } catch (e) {
      throw 'Something went wrong, please try again.';
    }
  }
}
