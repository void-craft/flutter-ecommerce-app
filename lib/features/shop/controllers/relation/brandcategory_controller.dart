import 'package:bagit/common/widgets/loaders/loaders.dart';
import 'package:bagit/data/repositories/brand/brand_repository.dart';
import 'package:bagit/features/shop/controllers/brand_controller.dart';
import 'package:bagit/features/shop/controllers/category_controller.dart';
import 'package:bagit/data/repositories/relation/brandcategory_repository.dart';
import 'package:bagit/features/shop/models/brand_model.dart';
import 'package:bagit/features/shop/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BrandCategoryController extends GetxController {
  static BrandCategoryController get instance => Get.find();

  final BrandCategoryRepository _repository = BrandCategoryRepository();
  final BrandRepository brandRepository = BrandRepository.instance;
  final CategoryController categoryController = CategoryController.instance;
  final BrandController brandController = BrandController.instance;
  final RxList<String> selectedCategories = <String>[].obs;
  final RxList<BrandModel> filteredBrands = <BrandModel>[].obs;
  final GlobalKey<FormState> uploadFormKey = GlobalKey<FormState>();
  RxList<String> get selectedCategoryIds => selectedCategories;
  RxList<BrandModel> get allBrands => brandController.featuredBrands;
  RxList<CategoryModel> get categories => categoryController.categories;
  RxString selectedBrandId = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchFilteredBrands();
  }

  Future<void> fetchFilteredBrands() async {
    try {
      final assignedBrandIds = await _repository.fetchAssignedBrandIds();
      filteredBrands.value = allBrands
          .where((brand) => !assignedBrandIds.contains(brand.id))
          .toList();
    } catch (e) {
      CustomLoaders.errorSnackbar(
          title: 'Error', message: 'Failed to load brands: $e');
    }
  }

  void selectBrand(String brandId) {
    brandController.selectedBrandId.value = brandId;
    selectedBrandId.value = brandId;
  }

  void toggleCategorySelection(String categoryId) {
    if (selectedCategories.contains(categoryId)) {
      selectedCategories.remove(categoryId);
    } else {
      selectedCategories.add(categoryId);
    }
  }

  Future<void> uploadBrandCategoryRelation() async {
    if (selectedBrandId.isEmpty || selectedCategories.isEmpty) {
      CustomLoaders.errorSnackbar(
          title: 'Error',
          message: 'Please select a brand and at least one category.');
      return;
    }
    try {
      await addBrandToCategories(
          selectedBrandId.value, selectedCategories.toList());
      resetSelections();
      fetchFilteredBrands();
    } catch (e) {
      CustomLoaders.errorSnackbar(
          title: 'Error', message: 'Failed to add brand to categories: $e');
    }
  }

  Future<void> addBrandToCategories(
      String brandId, List<String> categoryIds) async {
    try {
      for (var categoryId in categoryIds) {
        await _repository.addRelation(brandId, categoryId);
      }
      CustomLoaders.successSnackbar(
          title: 'Success',
          message: 'Brand added to categories successfully!');
    } catch (e) {
      CustomLoaders.errorSnackbar(
          title: 'Error', message: 'Failed to add brand to categories: $e');
    }
  }

  void resetSelections() {
    selectedBrandId.value = '';
    selectedCategories.clear();
  }
}
