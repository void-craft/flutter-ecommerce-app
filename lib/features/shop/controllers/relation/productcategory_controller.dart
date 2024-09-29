import 'package:bagit/data/repositories/relation/productcategory_repository.dart';
import 'package:bagit/features/shop/models/product/product_model.dart';
import 'package:bagit/features/shop/models/category_model.dart';
import 'package:get/get.dart';

class ProductCategoryController extends GetxController {
  static ProductCategoryController get instance => Get.find();

  final ProductCategoryRepository _repository = ProductCategoryRepository();
  final RxList<CategoryModel> selectedCategories = <CategoryModel>[].obs;
  final RxList<ProductModel> products = <ProductModel>[].obs;
  final RxList<CategoryModel> categories = <CategoryModel>[].obs;

  @override
  void onInit() {
    fetchProducts();
    fetchCategories();
    super.onInit();
  }

  // Fetch all products
  Future<void> fetchProducts() async {
    try {
      final fetchedProducts = await _repository.getAllProducts();
      products.assignAll(fetchedProducts);
    } catch (e) {
      print('Error fetching products: $e');
    }
  }

  // Fetch all categories
  Future<void> fetchCategories() async {
    try {
      final fetchedCategories = await _repository.getAllCategories();
      categories.assignAll(fetchedCategories);
    } catch (e) {
      print('Error fetching categories: $e');
    }
  }

  // Add product-category relations
  Future<void> addProductToCategories(String productId, List<String> categoryIds) async {
    try {
      for (var categoryId in categoryIds) {
        await _repository.addRelation(productId, categoryId);
      }
      Get.snackbar('Success', 'Product added to categories successfully!');
    } catch (e) {
      Get.snackbar('Error', 'Failed to add product to categories: $e');
    }
  }

  // Remove product-category relation
  Future<void> removeProductFromCategory(String productId, String categoryId) async {
    try {
      await _repository.removeRelation(productId, categoryId);
      Get.snackbar('Success', 'Product removed from category successfully!');
    } catch (e) {
      Get.snackbar('Error', 'Failed to remove product from category: $e');
    }
  }
}
