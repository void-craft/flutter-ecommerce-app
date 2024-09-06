import 'dart:io';
import 'package:bagit/common/widgets/loaders/loaders.dart';
import 'package:bagit/data/repositories/categories/category_repository.dart';
import 'package:bagit/features/shop/models/category_model.dart';
import 'package:bagit/features/shop/models/product_model.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();
  
  final isLoading = false.obs;
  final _categoryRepository = Get.put(CategoryRepository());
  RxList<CategoryModel> featuredCategories = <CategoryModel>[].obs;
  Rx<CategoryModel?> selectedCategory = Rx<CategoryModel?>(null);
  RxList<ProductModel> categoryProducts = <ProductModel>[].obs;

  @override
  void onInit() {
    getAllCategories();
    super.onInit();
  }

  // --- Load all categories
  Future<void> getAllCategories() async {
    try {
      isLoading.value = true;
      final categories = await _categoryRepository.getAllCategories();
      featuredCategories.assignAll(categories);
    } catch (e) {
      CustomLoaders.errorSnackbar(title: 'Oh, snap!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // --- Load selected category data
  void selectCategory(CategoryModel category) {
    selectedCategory.value = category;
  }

  // --- Get products for selected category or subcategory
  Future<void> getCategoryProducts(String categoryId) async {
    try {
      isLoading.value = true;
      final products = await _categoryRepository.getProductsByCategory(categoryId);
      categoryProducts.assignAll(products);
    } catch (e) {
      CustomLoaders.errorSnackbar(title: 'Oh, snap!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> uploadCategory({
    String targetScreen = '/shop',
    bool active = true,
  }) async {
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
