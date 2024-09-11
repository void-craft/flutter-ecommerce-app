import 'dart:io';
import 'package:bagit/common/widgets/loaders/loaders.dart';
import 'package:bagit/features/shop/models/brand_model.dart';
import 'package:bagit/features/shop/models/product/product_attribute_model.dart';
import 'package:bagit/features/shop/models/product/product_model.dart';
import 'package:bagit/features/shop/models/product/product_variation_model.dart';
import 'package:bagit/utils/exceptions/firebase_exceptions.dart';
import 'package:bagit/utils/exceptions/platform_exceptions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ProductRepository extends GetxController {
  static ProductRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Get limited featured products
  Future<List<ProductModel>> getFeaturedProducts() async {
    try {
      final snapshot = await _db
          .collection('Products')
          .where('IsFeatured', isEqualTo: true)
          .limit(4)
          .get();
      return snapshot.docs.map((e) => ProductModel.fromSnapshot(e)).toList();
    } on FirebaseException catch (e) {
      throw CustomFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw CustomPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  // Get all featured products
  Future<List<ProductModel>> getAllFeaturedProducts() async {
    try {
      final snapshot = await _db
          .collection('Products')
          .where('IsFeatured', isEqualTo: true)
          .get();
      return snapshot.docs.map((e) => ProductModel.fromSnapshot(e)).toList();
    } on FirebaseException catch (e) {
      throw CustomFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw CustomPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  // Get products based on the query
  Future<List<ProductModel>> fetchProductsByQuery(Query query) async {
    try {
      final querySnapshot = await query.get();
      final List<ProductModel> productList = querySnapshot.docs
          .map((doc) => ProductModel.fromQuerySnapshot(doc))
          .toList();
      return productList;
    } on FirebaseException catch (e) {
      throw CustomFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw CustomPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  // Get favortie products
  Future<List<ProductModel>> getFavoriteProducts(List<String> productIds) async {
    try {
      final snapshot = await _db.collection('Products').where(FieldPath.documentId, whereIn: productIds).get();
      return snapshot.docs.map((querySnapshot) => ProductModel.fromSnapshot(querySnapshot)).toList();
    } on FirebaseException catch (e) {
      throw CustomFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw CustomPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  // Get products based on the brand
  Future<List<ProductModel>> getProductsForBrand(
      {required String brandId, int limit = -1}) async {
    try {
      final querySnapshot = limit == -1
          ? await _db
              .collection('Products')
              .where('Brand.Id', isEqualTo: brandId)
              .get()
          : await _db
              .collection('Products')
              .where('Brand.Id', isEqualTo: brandId)
              .limit(limit)
              .get();
      final products = querySnapshot.docs
          .map((doc) => ProductModel.fromQuerySnapshot(doc))
          .toList();
      return products;
    } on FirebaseException catch (e) {
      throw CustomFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw CustomPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  // Get products based on the brand
  Future<List<ProductModel>> getProductsForCategory(
      {required String categoryId, int limit = 4}) async {
    try {
      // Query to get all documents where productId matches the provided categoryId & fetch limited or unlimited based on limit
      QuerySnapshot productCategoryQuery = limit == -1
          ? await _db
              .collection('ProductCategory')
              .where('CategoryId', isEqualTo: categoryId)
              .get()
          : await _db
              .collection('ProductCategory')
              .where('CategoryId', isEqualTo: categoryId)
              .limit(limit)
              .get();
      // Extract productIds from the documents
      List<String> productIds = productCategoryQuery.docs
          .map((doc) => doc['productId'] as String)
          .toList();

      // Query to get all documents where the brandId is in the list of brandIds, fieldPath.documentId to query documents in collection
      final productsQuery = await _db
          .collection('Products')
          .where(FieldPath.documentId, whereIn: productIds)
          .get();

      // Extract brand names or other relevant datqa from the documents
      List<ProductModel> products = productsQuery.docs
          .map((doc) => ProductModel.fromSnapshot(doc))
          .toList();
      return products;
    } on FirebaseException catch (e) {
      throw CustomFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw CustomPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  /////////

  Future<void> uploadProduct({
    required String id,
    required String title,
    required int stock,
    required double price,
    required File thumbnail,
    required String productType,
    String? sku,
    bool? isFeatured,
    String? description,
    DateTime? date,
    BrandModel? brand,
    List<File>? images,
    double salePrice = 0.0,
    List<ProductVariationModel>? productVariations,
    List<ProductAttributeModel>? productAttributes,
    String? categoryId,
  }) async {
    try {
      // Ensure user is authenticated
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw 'User is not authenticated.';
      }

      // Upload the thumbnail and get the URL
      final thumbnailUrl = await _uploadFileToStorage(thumbnail,
          'products/thumbnails/${DateTime.now().millisecondsSinceEpoch}_${thumbnail.uri.pathSegments.last}');

      // Upload the images and get their URLs
      final imageUrls = await Future.wait(images?.map((file) async =>
              await _uploadFileToStorage(file,
                  'products/images/${DateTime.now().millisecondsSinceEpoch}_${file.uri.pathSegments.last}')) ??
          []);

      // Ensure imageUrls is a List<String>
      final imageUrlsString = imageUrls.map((url) => url as String).toList();

      // Create and upload product data
      final product = ProductModel(
        id: id,
        title: title,
        stock: stock,
        price: price,
        thumbnail: thumbnailUrl,
        productType: productType,
        sku: sku,
        isFeatured: isFeatured,
        description: description,
        date: date,
        brand: brand,
        images: imageUrlsString, // List of URLs as Strings
        salePrice: salePrice,
        productVariations: productVariations,
        productAttributes: productAttributes,
        categoryId: categoryId,
      );

      await _db.collection('Products').doc(id).set(product.toJson());
      CustomLoaders.successSnackbar(
          title: 'Success',
          message: 'Product uploaded and saved successfully!');
    } on FirebaseException catch (e) {
      CustomLoaders.errorSnackbar(
          title: 'Error', message: 'Firebase Exception: ${e.message}');
    } on PlatformException catch (e) {
      CustomLoaders.errorSnackbar(
          title: 'Error', message: 'Platform Exception: ${e.message}');
    } catch (e) {
      CustomLoaders.errorSnackbar(
          title: 'Error', message: 'Something went wrong. Please try again.');
    }
  }

  Future<String> _uploadFileToStorage(File file, String path) async {
    try {
      final storageRef = _storage.ref().child(path);
      final uploadTask = storageRef.putFile(file);
      final snapshot = await uploadTask.whenComplete(() => {});
      final downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      throw 'Error uploading file: $e';
    }
  }
}
