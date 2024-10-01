import 'dart:convert';
import 'package:bagit/common/widgets/loaders/loaders.dart';
import 'package:bagit/data/repositories/product/product_repository.dart';
import 'package:bagit/features/shop/models/product/product_model.dart';
import 'package:bagit/utils/local_storage/storage_utility.dart';
import 'package:get/get.dart';

class FavoritesController extends GetxController {
  // Singleton instance
  static FavoritesController get instance => Get.find();

  // Variables
  final favorites = <String, bool>{}.obs;

  @override
  void onInit() {
    super.onInit();
    initFavorites(); // Initialize favorites when the controller is initialized
  }

  // Method to initialize favorites by reading from storage
  void initFavorites() {
    final json = CustomLocalStorage.instance().readData('favorites');
    if (json != null) {
      final storedFavorites = jsonDecode(json) as Map<String, dynamic>;
      favorites.assignAll(storedFavorites.map((key, value) => MapEntry(key, value as bool)));
    }
  }

  // Check if a product is a favorite
  bool isFavorite(String productId) {
    return favorites[productId] ?? false;
  }

  // Toggle favorite status of a product
  void toggleFavoriteProduct(String productId) {
    if (!favorites.containsKey(productId)) {
      // Add to favorites
      favorites[productId] = true;
      saveFavoritesToStorage();
      CustomLoaders.customToast(message: 'Product added to Wishlist.');
    } else {
      // Remove from favorites
      favorites.remove(productId); 
      saveFavoritesToStorage();
      CustomLoaders.customToast(message: 'Product removed from wishlist.');
    }
  }

  // Get a list of favorite products
  Future<List<ProductModel>> favoriteProducts() async {
    return await ProductRepository.instance.getFavoriteProducts(favorites.keys.toList());
  }

  // Save the favorites list to storage
  void saveFavoritesToStorage() {
    final encodedFavorites = json.encode(favorites);
    CustomLocalStorage.instance().writeData('favorites', encodedFavorites);
  }
}
