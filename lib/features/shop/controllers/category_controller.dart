import 'dart:io';
import 'package:bagit/common/widgets/loaders/loaders.dart';
import 'package:bagit/data/repositories/categories/category_repository.dart';
import 'package:bagit/data/repositories/product/product_repository.dart';
import 'package:bagit/features/shop/models/category_model.dart';
import 'package:bagit/features/shop/models/product/product_model.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();

  final _categoryRepository = Get.put(CategoryRepository());
  final productRepository = ProductRepository.instance;
  final isLoading = false.obs;
  final RxList<String> selectedCategoryIds = <String>[].obs;
  RxList<CategoryModel> featuredCategories = <CategoryModel>[].obs;
  RxList<ProductModel> categoryProducts = <ProductModel>[].obs;
  RxList<CategoryModel> categories = <CategoryModel>[].obs;
  Rx<CategoryModel?> selectedCategory = Rx<CategoryModel?>(null);

  @override
  void onInit() {
    getAllCategories();
    super.onInit();
  }

  // --- Load all categories
  Future<void> getAllCategories() async {
    try {
      isLoading.value = true;
      final categoriesList = await _categoryRepository.getAllCategories();
      featuredCategories.assignAll(categoriesList);
      categories.assignAll(categoriesList);
    } catch (e) {
      CustomLoaders.errorSnackbar(title: 'Oh, snap!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // --- Set selected categories
  void selectCategory(List<String> categoryIds) {
    selectedCategoryIds.value = categoryIds;
  }

  // --- Load subcategories based on selected category ID
  Future<List<CategoryModel>> getSubCategories(String categoryId) async {
    try {
      final subCategories = await _categoryRepository.getSubCategories(categoryId);
      return subCategories;
    } catch (e) {
      CustomLoaders.errorSnackbar(title: 'Oh, snap!', message: e.toString());
      return [];
    }
  }

  // --- Get products for selected category or subcategory
  Future<List<ProductModel>> getCategoryProducts({required String categoryId, int limit = 4}) async {
    try {
      final products = await productRepository.getProductsForCategory(categoryId: categoryId, limit: limit);
      return products;
    } catch (e) {
      CustomLoaders.errorSnackbar(title: 'Oh, snap!', message: e.toString());
      return [];
    }
  }

  // --- Upload new category with image selection
  Future<void> uploadCategory({String targetScreen = '', bool active = true}) async {
    try {
      isLoading.value = true;
      final ImagePicker picker = ImagePicker();
      final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        File imageFile = File(pickedFile.path);
        await _categoryRepository.uploadCategory(
          imageFile: imageFile,
          targetScreen: targetScreen,
          active: active,
        );
        CustomLoaders.successSnackbar(title: 'Success', message: 'Category uploaded successfully!');
      } else {
        CustomLoaders.errorSnackbar(title: 'Error', message: 'No image selected.');
      }
    } catch (e) {
      CustomLoaders.errorSnackbar(title: 'Error', message: 'Error uploading category: $e');
    } finally {
      isLoading.value = false;
    }
  }
}