import 'package:bagit/common/widgets/loaders/loaders.dart';
import 'package:bagit/data/repositories/product/product_repository.dart';
import 'package:bagit/features/shop/models/brand_model.dart';
import 'package:bagit/features/shop/models/product/product_model.dart';
import 'package:bagit/utils/constants/enums.dart';
import 'package:bagit/utils/constants/image_strings.dart';
import 'package:bagit/utils/popups/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProductController extends GetxController {
  static ProductController get instance => Get.find();

  final productRepository = Get.put(ProductRepository());
  final GlobalKey<FormState> uploadFormKey = GlobalKey<FormState>();

  // Observables for various product fields
  final Rx<String> id = ''.obs;
  final Rx<String> title = ''.obs;
  final Rx<int> stock = 0.obs;
  final Rx<double> price = 0.0.obs;
  final Rx<String> sku = ''.obs;
  final Rx<ProductType> productType =
      ProductType.single.obs;
  final Rx<String> description = ''.obs;
  final Rx<double> salePrice = 0.0.obs;
  final Rx<String> thumbnail = ''.obs;
  final Rx<String> brand = ''.obs;
  final Rx<String> categoryId = ''.obs;
  final RxList<XFile> additionalImages = <XFile>[].obs;

  // Loading state
  final RxBool isLoading = false.obs;

  // Image picker for selecting thumbnail and additional images
  final ImagePicker picker = ImagePicker();

  // The main product object
  final Rx<ProductModel> product = ProductModel(
    id: '',
    title: '',
    stock: 0,
    price: 0.0,
    productType: ProductType.single.toString(),
    thumbnail: '',
  ).obs;

  RxList<ProductModel> featuredProducts = <ProductModel>[].obs;

  @override
  void onInit() {
    fetchFeaturedProducts();
    super.onInit();
  }

  // Update specific product fields
  void updateFields({
    required String id,
    required String title,
    required int stock,
    required double price,
    required ProductType productType,
  }) {
    this.id.value = id;
    this.title.value = title;
    this.stock.value = stock;
    this.price.value = price;
    this.productType.value = productType;
  }

  // Fetch featured products
  void fetchFeaturedProducts() async {
    try {
      isLoading.value = true;
      final products = await productRepository.getFeaturedProducts();
      featuredProducts.assignAll(products);
    } catch (e) {
      CustomLoaders.errorSnackbar(title: 'Oh, snap!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Fetch all featured products
  Future<List<ProductModel>> fetchAllFeaturedProducts() async {
    isLoading.value = true;
    try {
      final products = await productRepository.getAllFeaturedProducts();
      return products;
    } catch (e) {
      CustomLoaders.errorSnackbar(title: 'Oh, snap!', message: e.toString());
      return [];
    } finally {
      isLoading.value = false;
    }
  }

  // Get stock status of the product
  String getProductStockStatus(int stock) {
    return stock > 0 ? 'In Stock' : 'Out of Stock';
  }

  // Get product price display, with support for variations
  String getProductPrice(ProductModel product) {
    if (product.productType == ProductType.single.toString()) {
      return (product.salePrice > 0 ? product.salePrice : product.price)
          .toString();
    } else {
      double smallestPrice = product.productVariations
              ?.map((v) => v.salePrice > 0 ? v.salePrice : v.price)
              .reduce((a, b) => a < b ? a : b) ??
          0.0;
      double largestPrice = product.productVariations
              ?.map((v) => v.salePrice > 0 ? v.salePrice : v.price)
              .reduce((a, b) => a > b ? a : b) ??
          0.0;

      return smallestPrice == largestPrice
          ? '$smallestPrice'
          : '$smallestPrice - $largestPrice';
    }
  }

  // Format price to two decimal places
  String formatPrice(double price) {
    return '€${price.toStringAsFixed(2)}';
  }

  // Calculate sale percentage
  String? calculateSalePercentage(double originalPrice, double? salePrice) {
    if (salePrice == null || salePrice <= 0 || originalPrice <= 0) return null;
    return (((originalPrice - salePrice) / originalPrice) * 100)
        .toStringAsFixed(0);
  }

  // Validation for required fields before submitting the form
  bool validateProductFields() {
    if (id.value.isEmpty ||
        title.value.isEmpty ||
        stock.value <= 0 ||
        price.value <= 0 ||
        (productType.value != ProductType.single &&
            productType.value != ProductType.variable) ||
        thumbnail.value.isEmpty) {
      CustomLoaders.errorSnackbar(
          title: 'Error', message: 'Please fill all required fields');
      return false;
    }
    return true;
  }

  // Pick additional images using ImagePicker
  Future<void> pickImages() async {
    final List<XFile> images = await picker.pickMultiImage();

    if (images.isNotEmpty) {
      additionalImages.addAll(images);
    } else {
      CustomLoaders.errorSnackbar(
          title: 'Error', message: 'No images selected');
    }
  }

  // Pick the thumbnail image using ImagePicker
  Future<void> pickThumbnail() async {
    try {
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        thumbnail.value = image.path; // Update thumbnail path
        CustomLoaders.successSnackbar(
            title: 'Success', message: 'Thumbnail selected successfully!');
      } else {
        CustomLoaders.errorSnackbar(
            title: 'Warning', message: 'No thumbnail selected');
      }
    } catch (e) {
      CustomLoaders.errorSnackbar(
          title: 'Error', message: 'Failed to pick thumbnail: $e');
    }
  }
  // Check if thumbnail has been uploaded
  bool isThumbnailUploaded() {
    return thumbnail.value.isNotEmpty;
  }

  // Reset product fields
  void cancelUpload() {
    id.value = '';
    title.value = '';
    stock.value = 0;
    price.value = 0.0;
    sku.value = '';
    productType.value = ProductType.single; // Reset to default type
    description.value = '';
    salePrice.value = 0.0;
    thumbnail.value = '';
    brand.value = '';
    additionalImages.clear();
  }

  // Validation for all required fields and conditions before submitting the form
  bool validateForm() {
    // Check if the form is valid
    if (!uploadFormKey.currentState!.validate()) {
      CustomLoaders.errorSnackbar(
          title: 'Validation Error',
          message: 'Please correct the errors in the form.');
      return false;
    }

    // Check for empty required fields
    if (id.value.isEmpty) {
      CustomLoaders.errorSnackbar(
          title: 'Error', message: 'Product ID is required.');
      return false;
    }
    if (title.value.isEmpty) {
      CustomLoaders.errorSnackbar(
          title: 'Error', message: 'Product title is required.');
      return false;
    }
    if (stock.value <= 0) {
      CustomLoaders.errorSnackbar(
          title: 'Error', message: 'Stock must be greater than zero.');
      return false;
    }
    if (price.value <= 0) {
      CustomLoaders.errorSnackbar(
          title: 'Error', message: 'Price must be greater than zero.');
      return false;
    }
    if (productType.value != ProductType.single &&
        productType.value != ProductType.variable) {
      CustomLoaders.errorSnackbar(
          title: 'Error', message: 'Please select a valid product type.');
      return false;
    }
    if (thumbnail.value.isEmpty) {
      CustomLoaders.errorSnackbar(
          title: 'Error', message: 'Thumbnail must be selected.');
      return false;
    }

    // If all validations pass
    return true;
  }

  Future<void> finishUpload() async {
  if (!validateForm()) return;

  isLoading.value = true;
  CustomFullscreenLoader.openLoadingDialog(
      'Uploading Product...', CustomImages.lottieLoadingllustration);

  try {
    await Future.delayed(Duration.zero); // Ensure we are on the main thread

    if (thumbnail.value.isNotEmpty) {
      String thumbnailUrl = await productRepository.uploadFile(
          thumbnail.value, thumbnail.value.split('/').last);

      List<String> imageUrls = [];
      for (XFile image in additionalImages) {
        String imageUrl = await productRepository.uploadFile(
            image.path, image.path.split('/').last);
        imageUrls.add(imageUrl);
      }

      product.value = ProductModel(
        id: id.value,
        title: title.value,
        stock: stock.value,
        price: price.value,
        sku: sku.value.isNotEmpty ? sku.value : null,
        productType: productType.value.toString(),
        description: description.value.isNotEmpty ? description.value : null,
        thumbnail: thumbnailUrl,
        isFeatured: false,
        images: imageUrls,
        salePrice: salePrice.value,
        brand: BrandModel(
          id: brand.value,
          name: '',
          image: '',
        ),
        productVariations: [],
        productAttributes: [],
        categoryId: categoryId.value,
      );

      // Upload the product to Firestore with the specified ID
      await productRepository.uploadProduct(product.value);
      cancelUpload();
      Get.back();

      // Stop the loading dialog before showing the snackbar
      CustomFullscreenLoader.stopLoading();

       // Show success snackbar after upload completion
      CustomLoaders.successSnackbar(
        title: 'Success',
        message: 'Product upload completed successfully!',
      );

    } else {
      CustomFullscreenLoader.stopLoading();
      CustomLoaders.errorSnackbar(
          message: 'Thumbnail must be selected!', title: 'Error.');
    }
  } catch (e) {
    CustomLoaders.errorSnackbar(title: 'Failed to finish upload: $e');
  } finally {
    isLoading.value = false; // Reset loading state
  }
}

}
