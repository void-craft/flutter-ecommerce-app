// // ignore_for_file: avoid_print

// import 'dart:convert';
// import 'package:bagit/entities/product_entity/product_entity.dart';
// import 'package:bagit/old_items/product/product.dart';
// import 'package:bagit/old_items/repositories/all_products_repo/all_products_repository.dart';
// import 'package:http/http.dart' as http;

// class AllProductsActions extends AllProductsRepository {
//   @override
//   Future<List<Product>?> fetchAllProducts() async {
//     print('Making network request...'); // Debug print
//     final response =
//         await http.get(Uri.parse('https://fakestoreapi.com/products'));
//     if (response.statusCode == 200) {
//       final json = jsonDecode(response.body);
//       print('Received JSON: $json'); // Debug print
//       return json
//           .map<Product>((e) => Product.fromEntity(ProductEntity.fromJson(e)))
//           .toList();
//     }
//     print('Failed to fetch products. Status code: ${response.statusCode}');
//     return null;
//   }
// }
