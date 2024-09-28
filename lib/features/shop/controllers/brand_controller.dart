import 'package:bagit/common/widgets/loaders/loaders.dart';
import 'package:bagit/data/repositories/brand/brand_repository.dart';
import 'package:bagit/data/repositories/product/product_repository.dart';
import 'package:bagit/features/shop/models/brand_model.dart';
import 'package:bagit/features/shop/models/product/product_model.dart';
import 'package:bagit/utils/constants/image_strings.dart';
import 'package:bagit/utils/popups/full_screen_loader.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class BrandController extends GetxController {
  static BrandController get instance => Get.find();

  final brandRepository = Get.put(BrandRepository());
  final GlobalKey<FormState> uploadFormKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final isLoading = false.obs;
  RxList<BrandModel> allBrands = <BrandModel>[].obs;
  RxList<BrandModel> featuredBrands = <BrandModel>[].obs;
  RxBool isUploading = false.obs;
  RxBool isFeatured = false.obs;
  var selectedImagePath = ''.obs;
  var brandId = ''.obs;
  final brandImagePath = ''.obs;

  // Observables for brand fields
  final Rx<String> id = ''.obs;
  final Rx<String> name = ''.obs;
  final Rx<String> image = ''.obs;
  final RxInt productsCount = 0.obs;

  final ImagePicker picker = ImagePicker();

  // The main brand object
  final Rx<BrandModel> brand = BrandModel(
    id: '',
    name: '',
    image: '',
  ).obs;

  // --- Load featured brand data
  Future<void> getFeaturedBrands() async {
    try {
      isLoading.value = true;
      final brands = await brandRepository.getAllBrands();
      allBrands.assignAll(brands);
      featuredBrands.assignAll(
          allBrands.where((brand) => brand.isFeatured ?? false).take(4));
    } catch (e) {
      CustomLoaders.errorSnackbar(title: 'Oh, snap!', message: e.toString());
    } finally {
      // Remove loader
      isLoading.value = false;
    }
  }

  // Get Brands for a Category
  Future<List<BrandModel>> getBrandsForCategory(String categoryId) async {
    try {
      final brands = await brandRepository.getBrandsForCategory(categoryId);
      return brands;
    } catch (e) {
      CustomLoaders.errorSnackbar(
        title: 'Oh Snap!',
        message: e.toString(),
      );
      return [];
    }
  }

  // --- Get brand specific products from your data source
  Future<List<ProductModel>> getBrandProducts(
      {required String brandId, int limit = -1}) async {
    try {
      final products = await ProductRepository.instance
          .getProductsForBrand(brandId: brandId, limit: limit);
      return products;
    } catch (e) {
      CustomLoaders.errorSnackbar(title: 'Oh, snap!', message: e.toString());
      return [];
    }
  }

  // Fetch number of products associated with the brand
  Future<void> fetchProductsCount() async {
    if (brandId.value.isNotEmpty) {
      try {
        final querySnapshot = await FirebaseFirestore.instance
            .collection('Products')
            .where('Brand.Id', isEqualTo: brandId.value)
            .get();
        productsCount.value = querySnapshot.docs.length;
      } catch (e) {
        // Handle error
      }
    }
  }

  // Pick the thumbnail image using ImagePicker
  Future<void> pickImage() async {
    try {
      final XFile? imageSelcted = await picker.pickImage(source: ImageSource.gallery);

      if (imageSelcted != null) {
        image.value = imageSelcted.path;
        CustomLoaders.successSnackbar(
            title: 'Success', message: 'Image selected successfully!');
      } else {
        CustomLoaders.errorSnackbar(
            title: 'Warning', message: 'No Image selected');
      }
    } catch (e) {
      CustomLoaders.errorSnackbar(
          title: 'Error', message: 'Failed to pick Image: $e');
    }
  }

  // Cancel brand upload form
  void cancelUpload() {
    id.value = '';
    name.value = '';
    image.value = '';
    isFeatured.value = false;
    productsCount.value = 0;
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

    if (id.value.isEmpty) {
      CustomLoaders.errorSnackbar(
          title: 'Error', message: 'Brand ID is required.');
      return false;
    }
    if (name.value.isEmpty) {
      CustomLoaders.errorSnackbar(
          title: 'Error', message: 'Brand Name is required.');
      return false;
    }
    if (image.value.isEmpty) {
      CustomLoaders.errorSnackbar(
          title: 'Error', message: 'Image must be selected.');
      return false;
    }
    return true;
  }

  // Upload brand
  Future<void> uploadBrand() async {
    if (!validateForm()) return;

    isLoading.value = true;
    CustomFullscreenLoader.openLoadingDialog(
        'Uploading Brand...', CustomImages.lottieLoadingllustration);
    try {
      await Future.delayed(Duration.zero);
      if (image.value.isNotEmpty) {
        String imageUrl = await brandRepository.uploadFile(
            image.value, image.value.split('/').last);
        await fetchProductsCount();
        brand.value = BrandModel(
            id: id.value,
            name: name.value,
            image: imageUrl,
            isFeatured: true,
            productsCount: productsCount.value
            );
        // Upload the product to Firestore with the specified ID
        await brandRepository.uploadBrand(brand.value);
        cancelUpload();
        Get.back();
        // Stop the loading dialog before showing the snackbar
        CustomFullscreenLoader.stopLoading();
        // Show success snackbar after upload completion
        CustomLoaders.successSnackbar(
          title: 'Success',
          message: 'Brand upload completed successfully!',
        );
      } else {
        CustomFullscreenLoader.stopLoading();
        CustomLoaders.errorSnackbar(
            message: 'Image must be selected!', title: 'Error.');
      }
    } catch (e) {
      CustomLoaders.errorSnackbar(title: 'Failed to finish upload: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
