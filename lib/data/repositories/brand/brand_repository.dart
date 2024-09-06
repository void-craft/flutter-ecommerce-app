import 'package:bagit/data/services/cloud_storage/firebase_storage_service.dart';
import 'package:bagit/features/shop/models/brand_model.dart';
import 'package:bagit/utils/exceptions/firebase_exceptions.dart';
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
      final list = snapshot.docs
          .map((document) => BrandModel.fromSnapshot(document))
          .toList();
      return list;
    } on FirebaseException catch (e) {
      throw CustomFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw CustomPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  Future<void> uploadDummyData(List<BrandModel> brands) async {
  try {
    final storage = Get.put(CustomFirebaseStorageService());

    for (var brand in brands) {
      try {
        // Get image data from assets
        final file = await storage.getImageDataFromAssets(brand.image);

        // Upload image and get its URL
        final url =
            await storage.uploadImageData("Brands", file, brand.name);

        // Create a new BrandModel with the updated image URL
        final updatedBrand = BrandModel(
          id: brand.id,
          image: url,  // Updated URL
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
