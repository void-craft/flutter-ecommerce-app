import 'package:buy_it_app/model/product/product.dart';

abstract class AllProductsRepository {
  Future<List<Product>?> fetchAllProducts();
}