import 'package:bagit/model/product/product.dart';

abstract class AllProductsRepository {
  Future<List<Product>?> fetchAllProducts();
}