import 'package:buy_it_app/model/product/product.dart';

abstract class CartRepository {
  Future<void> saveCart(List<Product> cart);
  Future<List<Product>> loadCart();
}

class CartRepositoryImpl implements CartRepository {
  @override
  Future<void> saveCart(List<Product> cart) async {
    // Save the cart (for example, using local storage or shared preferences)
  }

  @override
  Future<List<Product>> loadCart() async {
    // Load the cart (for example, from local storage or shared preferences)
    return [];
  }
}
