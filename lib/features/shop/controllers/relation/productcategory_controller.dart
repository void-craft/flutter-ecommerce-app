import 'package:bagit/common/widgets/loaders/loaders.dart';
import 'package:bagit/data/repositories/product/product_repository.dart';
import 'package:bagit/features/shop/controllers/category_controller.dart';
import 'package:bagit/features/shop/controllers/product/product_controller.dart';
import 'package:bagit/data/repositories/relation/productcategory_repository.dart';
import 'package:bagit/features/shop/models/product/product_model.dart';
import 'package:bagit/features/shop/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductCategoryController extends GetxController {
  static ProductCategoryController get instance => Get.find();

  final ProductCategoryRepository _repository = ProductCategoryRepository();
  final ProductRepository productRepository = ProductRepository.instance;
  final CategoryController categoryController = CategoryController.instance;
  final ProductController productController = ProductController.instance;
  final RxList<String> selectedCategories = <String>[].obs;
  final RxList<ProductModel> filteredProducts = <ProductModel>[].obs;
  final GlobalKey<FormState> uploadFormKey = GlobalKey<FormState>();
  RxList<String> get selectedCategoryIds => selectedCategories;
  RxList<ProductModel> get allProducts => productController.featuredProducts;
  RxList<CategoryModel> get categories => categoryController.categories;
  RxString selectedProductId = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchFilteredProducts();
  }

  Future<void> fetchFilteredProducts() async {
    try {
      final assignedProductIds = await _repository.fetchAssignedProductIds();
      filteredProducts.value = allProducts
          .where((product) => !assignedProductIds.contains(product.id))
          .toList();
    } catch (e) {
      CustomLoaders.errorSnackbar(
          title: 'Error', message: 'Failed to load products: $e');
    }
  }

  void selectProduct(String productId) {
    productController.selectedProductId.value = productId;
    selectedProductId.value = productId;
  }

  void toggleCategorySelection(String categoryId) {
    if (selectedCategories.contains(categoryId)) {
      selectedCategories.remove(categoryId);
    } else {
      selectedCategories.add(categoryId);
    }
  }

  Future<void> uploadProductCategoryRelation() async {
    if (selectedProductId.isEmpty || selectedCategories.isEmpty) {
      CustomLoaders.errorSnackbar(
          title: 'Error',
          message: 'Please select a product and at least one category.');
      return;
    }
    try {
      await addProductToCategories(
          selectedProductId.value, selectedCategories.toList());
      resetSelections();
      fetchFilteredProducts();
    } catch (e) {
      CustomLoaders.errorSnackbar(
          title: 'Error', message: 'Failed to add product to categories: $e');
    }
  }

  Future<void> addProductToCategories(
      String productId, List<String> categoryIds) async {
    try {
      for (var categoryId in categoryIds) {
        await _repository.addRelation(productId, categoryId);
      }
      CustomLoaders.successSnackbar(
          title: 'Success',
          message: 'Product added to categories successfully!');
    } catch (e) {
      CustomLoaders.errorSnackbar(
          title: 'Error', message: 'Failed to add product to categories: $e');
    }
  }

  void resetSelections() {
    selectedProductId.value = '';
    selectedCategories.clear();
  }
}
