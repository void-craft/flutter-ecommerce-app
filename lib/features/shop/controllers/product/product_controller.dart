import 'dart:io';
import 'package:bagit/common/widgets/loaders/loaders.dart';
import 'package:bagit/data/repositories/product/product_repository.dart';
import 'package:bagit/data/services/cloud_storage/firebase_storage_service.dart';
import 'package:bagit/features/shop/models/brand_model.dart';
import 'package:bagit/features/shop/models/product/product_attribute_model.dart';
import 'package:bagit/features/shop/models/product/product_model.dart';
import 'package:bagit/features/shop/models/product/product_variation_model.dart';
import 'package:bagit/utils/constants/enums.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProductController extends GetxController {
  static ProductController get instance => Get.find();

  final isLoading = false.obs;
  final productRepository = Get.put(ProductRepository());
  RxList<ProductModel> featuredProducts = <ProductModel>[].obs;

  @override
  void onInit() {
    fetchFeaturedProducts();
    super.onInit();
  }

  void fetchFeaturedProducts() async {
    try {
      // Show loader while loading products
      isLoading.value = true;
      // Fetch Products
      final products = await productRepository.getFeaturedProducts();
      // Assign Products
      featuredProducts.assignAll(products);
    } catch (e) {
      CustomLoaders.errorSnackbar(title: 'Oh, snap!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<ProductModel>> fetchAllFeaturedProducts() async {
    try {
      // Fetch Products
      final products = await productRepository.getAllFeaturedProducts();
      return products;
    } catch (e) {
      CustomLoaders.errorSnackbar(title: 'Oh, snap!', message: e.toString());
      return [];
    }
  }

  // Method to upload a product
  Future<void> uploadProduct({
    required String id,
    required String title,
    required String productType,
    required int stock,
    required double price,
    required File thumbnail,
    bool? isFeatured,
    String? sku,
    String? description,
    double? salePrice,
    String? categoryId,
    BrandModel? brand,
    DateTime? date,
    List<File>? images = const [],
    List<ProductVariationModel>? productVariations,
    List<ProductAttributeModel>? productAttributes,
  }) async {
    try {
      isLoading.value = true;

      // Ensure user is authenticated
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        CustomLoaders.errorSnackbar(title: 'Error', message: 'User is not authenticated.');
        return;
      }

      // Upload the thumbnail and get the URL
      final thumbnailUrl = await uploadSingleImage(
        thumbnail,
        'products/Thumbnails/${DateTime.now().millisecondsSinceEpoch}_${thumbnail.uri.pathSegments.last}'
      );

      // Upload the images and get their URLs
      final imageUrls = await uploadMultipleImages(
        images ?? [],
        'products/Images/${DateTime.now().millisecondsSinceEpoch}'
      );

      // Create and upload product data
      final product = ProductModel(
        id: id,
        title: title,
        stock: stock,
        price: price,
        thumbnail: thumbnailUrl,
        productType: productType,
        sku: sku,
        isFeatured: isFeatured ?? false,
        description: description,
        date: date,
        brand: brand,
        images: imageUrls,
        salePrice: salePrice ?? 0.0,
        productVariations: productVariations,
        productAttributes: productAttributes,
        categoryId: categoryId,
      );

      await _firestoreService.collection('Products').doc(id).set(product.toJson());
      CustomLoaders.successSnackbar(title: 'Success', message: 'Product uploaded successfully.');
    } catch (e) {
      CustomLoaders.errorSnackbar(title: 'Error', message: 'Failed to upload product: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Get product stock status
  String getProductStockStatus(int stock) {
    return stock > 0 ? 'In Stock' : 'Out of Stock';
  }

   // Get product price or price range for variations -- DONE
  String getProductPrice(ProductModel product) {
    if (product.productType == ProductType.single.toString()) {
      return (product.salePrice > 0 ? product.salePrice : product.price).toString();
    } else {
      double smallestPrice = product.productVariations?.map((v) => v.salePrice > 0 ? v.salePrice : v.price).reduce((a, b) => a < b ? a : b) ?? 0.0;
      double largestPrice = product.productVariations?.map((v) => v.salePrice > 0 ? v.salePrice : v.price).reduce((a, b) => a > b ? a : b) ?? 0.0;
      
      return smallestPrice == largestPrice
          ? '$smallestPrice'
          : '$smallestPrice - $largestPrice';
    }
  }

  // Method to format price as a string
  String formatPrice(double price) {
    return '€${price.toStringAsFixed(2)}';
  }

  // Calculate discounted price percentage
  String? calculateSalePercentage(double originalPrice, double? salePrice) {
    if (salePrice == null || salePrice <= 0 || originalPrice <= 0) return null;
    return (((originalPrice - salePrice) / originalPrice) * 100).toStringAsFixed(0);
  }

  /////

  // Observables for product properties
  final RxBool isActive = true.obs;
   // Loading state

  // Firebase services
  final CustomFirebaseStorageService _storageService = CustomFirebaseStorageService();
  final FirebaseFirestore _firestoreService = FirebaseFirestore.instance;

  // Reactive variable for featured status
  final RxBool _isFeatured = false.obs;

  // Getter for isFeatured
  bool get isFeatured => _isFeatured.value;

  // Setter for isFeatured
  set isFeatured(bool value) => _isFeatured.value = value;

  // Reactive variable for product type
  final Rx<ProductType> productType = ProductType.single.obs;

  // Getter and Setter for product type
  ProductType get currentProductType => productType.value;
  set currentProductType(ProductType value) => productType.value = value;

  // Placeholder for getting a product by ID
  ProductModel? getProductById(String id) {
    // Implement the logic to retrieve a product by ID from your data source
    return null; // Replace with actual retrieval logic
  }

  /// ---- METHODS ---- ///

  // Method to toggle isFeatured status
  Future<void> toggleIsFeatured() async {
    try {
      _isFeatured.toggle();
      CustomLoaders.successSnackbar(
        title: 'Success',
        message: 'Product featured status updated successfully.',
      );
    } catch (e) {
      CustomLoaders.errorSnackbar(
        title: 'Error',
        message: 'Failed to update featured status: $e',
      );
    }
  }

  // Method to upload a single image (thumbnail or image)
  Future<String> uploadSingleImage(File file, String storagePath) async {
    try {
      return await _storageService.uploadImageFile(storagePath, XFile(file.path));
    } catch (e) {
      throw Exception('Error uploading file: $e');
    }
  }

  // Method to upload multiple images
  Future<List<String>> uploadMultipleImages(List<File> files, String baseStoragePath) async {
    List<String> downloadUrls = [];
    try {
      for (final file in files) {
        final fileName = file.uri.pathSegments.last;
        final storagePath = '$baseStoragePath/$fileName';
        final downloadUrl = await uploadSingleImage(file, storagePath);
        downloadUrls.add(downloadUrl);
      }
      return downloadUrls;
    } catch (e) {
      throw Exception('Failed to upload images: $e');
    }
  }
}