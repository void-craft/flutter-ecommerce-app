import 'package:bagit/common/widgets/loaders/loaders.dart';
import 'package:bagit/data/repositories/product/product_repository.dart';
import 'package:bagit/features/shop/models/product/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FavoritesController extends GetxController {
  static FavoritesController get instance => Get.find();

  // Firebase instances
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Variables
  final favorites = <String, bool>{}.obs;

  @override
  void onInit() {
    super.onInit();
    _auth.authStateChanges().listen((User? user) {
      if (user != null) {
        initFavoritesFromFirebase(); // Fetch favorites after user logs in
      } else {
        favorites.clear(); // Clear favorites on logout
      }
    });
  }

  // Method to initialize favorites by reading from Firestore
  void initFavoritesFromFirebase() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        final favoritesCollection = await _firestore
            .collection('Users')
            .doc(user.uid)
            .collection('Favorites')
            .get();

        final fetchedFavorites = <String, bool>{};
        for (var doc in favoritesCollection.docs) {
          fetchedFavorites[doc.id] = true;
        }
        favorites.assignAll(fetchedFavorites);
        favorites.refresh();
      }
    } catch (e) {
      CustomLoaders.errorSnackbar(title: 'Error', message: e.toString());
    }
  }

  // Check if a product is a favorite
  bool isFavorite(String productId) {
    return favorites[productId] ?? false;
  }

  // Toggle favorite status of a product
  void toggleFavoriteProduct(String productId) async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        final userFavorites = _firestore.collection('Users').doc(user.uid).collection('Favorites');

        if (!favorites.containsKey(productId)) {
          // Add to favorites in Firestore
          await userFavorites.doc(productId).set({'favoritedAt': FieldValue.serverTimestamp()});
          favorites[productId] = true;
          CustomLoaders.customToast(message: 'Product added to Wishlist.');
        } else {
          // Remove from favorites in Firestore
          await userFavorites.doc(productId).delete();
          favorites.remove(productId);
          CustomLoaders.customToast(message: 'Product removed from Wishlist.');
        }
        favorites.refresh();
      } else {
        CustomLoaders.errorSnackbar(title: 'Error', message: 'User not logged in.');
      }
    } catch (e) {
      CustomLoaders.errorSnackbar(title: 'Error', message: e.toString());
    }
  }

  // Get a list of favorite products
  Future<List<ProductModel>> favoriteProducts() async {
    return await ProductRepository.instance.getFavoriteProducts(favorites.keys.toList());
  }
}
