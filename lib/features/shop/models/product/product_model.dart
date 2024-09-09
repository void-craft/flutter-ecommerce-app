import 'package:bagit/features/shop/models/brand_model.dart';
import 'package:bagit/features/shop/models/product/product_attribute_model.dart';
import 'package:bagit/features/shop/models/product/product_variation_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// DONE
class ProductModel {
  String id;
  int stock;
  String? sku;
  double price;
  String title;
  DateTime? date;
  double salePrice;
  String thumbnail;
  bool? isFeatured;
  BrandModel? brand;
  String? description;
  String? categoryId;
  List<String>? images;
  String productType;
  List<ProductAttributeModel>? productAttributes;
  List<ProductVariationModel>? productVariations;

  ProductModel({
    required this.id,
    required this.title,
    required this.stock,
    required this.price,
    required this.thumbnail,
    required this.productType,
    this.sku,
    this.isFeatured,
    this.description,
    this.date,
    this.brand,
    this.images,
    this.salePrice = 0.0,
    this.productVariations,
    this.productAttributes,
    this.categoryId,
  });

  // Create Empty func for clean code
  static ProductModel empty() => ProductModel(
      id: '', title: '', stock: 0, price: 0, thumbnail: '', productType: '');

  // Convert a ProductModel instance to JSON
  toJson() {
    return {
      'SKU': sku,
      'Id': id,
      'CategoryId': categoryId,
      'Title': title,
      'Stock': stock,
      'Price': price,
      'IsFeatured': isFeatured,
      'Thumbnail': thumbnail,
      'Description': description,
      'Brand': brand!.toJson(),
      'Images': images ?? [],
      'ProductType': productType,
      'ProductVariations': productVariations != null
          ? productVariations!.map((e) => e.toJson()).toList()
          : [],
      'ProductAttributes': productAttributes != null
          ? productAttributes!.map((e) => e.toJson()).toList()
          : [],
      'SalePrice': salePrice,
    };
  }

  // Map Json oriented document snapshot from firebase to model
  factory ProductModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() == null) return ProductModel.empty();
    final data = document.data()!;
    return ProductModel(
      id: document.id,
      sku: data['SKU'] ?? '',
      title: data['Title'] ?? '',
      stock: data['Stock'] ?? 0,
      price: double.parse((data['Price'] ?? 0.0).toString()),
      isFeatured: data['IsFeatured'] ?? false,
      thumbnail: data['Thumbnail'] ?? '',
      description: data['Description'] ?? '',
      categoryId: data['CategoryId'] ?? '',
      salePrice: double.parse((data['SalePrice'] ?? 0.0).toString()),
      productType: data['ProductType'] ?? '',
      brand: BrandModel.fromJson(data['Brand']),
      images: data['Images'] != null ? List<String>.from(data['Images']) : [],
      productAttributes: (data['ProductAttributes'] as List<dynamic>)
          .map((e) => ProductAttributeModel.fromJson(e))
          .toList(),
      productVariations: (data['ProductVariations'] as List<dynamic>)
          .map((e) => ProductVariationModel.fromJson(e))
          .toList(),
    );
  }

  // Map json oriented document snapshot from firebase to model
  factory ProductModel.fromQuerySnapshot(
      QueryDocumentSnapshot<Object?> document) {
    final data = document.data() as Map<String, dynamic>;
    return ProductModel(
      id: document.id,
      sku: data['SKU'] ?? '',
      title: data['Title'] ?? '',
      stock: data['Stock'] ?? 0,
      price: double.parse((data['Price'] ?? 0.0).toString()),
      salePrice: double.parse((data['SalePrice'] ?? 0.0).toString()),
      thumbnail: data['Thumbnail'] ?? '',
      categoryId: data['CategoryId'] ?? '',
      description: data['Description'] ?? '',
      productType: data['ProductType'] ?? '',
      isFeatured: data['IsFeatured'] ?? false,
      brand: BrandModel.fromJson(data['Brand']),
      images: data['Images'] != null ? List<String>.from(data['Images']) : [],
      productAttributes: (data['ProductAttributes'] as List<dynamic>)
          .map((e) => ProductAttributeModel.fromJson(e))
          .toList(),
      productVariations: (data['ProductVariations'] as List<dynamic>)
          .map((e) => ProductVariationModel.fromJson(e))
          .toList(),
    );
  }
}
