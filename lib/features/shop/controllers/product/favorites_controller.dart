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

  bool isFavorite(String productId) {
    return favorites[productId] ?? false;
  }

  void toggleFavoriteProduct(String productId) {
    if(!favorites.containsKey(productId)) {
      favorites[productId] = true;
      saveFavoritesToStorage();
      CustomLoaders.customToast(message: 'Product has been added to the Wishlist.');
    } else {
      CustomLocalStorage.instance().removeData(productId);
      saveFavoritesToStorage();
      favorites.refresh();
      CustomLoaders.customToast(message: 'Product has been removed from the wishlist');
    }
  }

  Future<List<ProductModel>> favoriteProducts() async {
    return await ProductRepository.instance.getFavoriteProducts(favorites.keys.toList());
  }

  // Method to save the favorites list to storage
  void saveFavoritesToStorage() {
    final encodedFavorites = json.encode(favorites);
    CustomLocalStorage.instance().writeData('favorites', encodedFavorites);
  }

  /////////////////

  // // Local storage for storing favorites
  // final GetStorage _storage = GetStorage();
  // final RxList<int> favouriteItems = <int>[].obs; // List of favorite item IDs

  

  // // Method to add an item to favorites
  // void addToFavourites(int itemId) {
  //   if (!favouriteItems.contains(itemId)) {
  //     favouriteItems.add(itemId);
  //     saveFavourites();
  //   }
  // }

  // // Method to remove an item from favorites
  // void removeFromFavourites(int itemId) {
  //   favouriteItems.remove(itemId);
  //   saveFavourites();
  // }

  
}
