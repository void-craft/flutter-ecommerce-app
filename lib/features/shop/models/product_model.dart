import 'package:bagit/features/shop/models/brand_model.dart';
import 'package:bagit/features/shop/models/product_attribute_model.dart';
import 'package:bagit/features/shop/models/product_variation_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  final String id;
  final String title;
  final int stock;
  final double price;
  final bool isFeatured;
  final String thumbnail;
  final String description;
  final BrandModel brand;
  final List<String> images;
  final List<ProductVariationModel> variations;
  final List<ProductAttributeModel> attributes;
  final double salePrice;

  ProductModel({
    required this.id,
    required this.title,
    required this.stock,
    required this.price,
    required this.isFeatured,
    required this.thumbnail,
    required this.description,
    required this.brand,
    required this.images,
    required this.variations,
    required this.attributes,
    required this.salePrice, required String productType, required List<ProductVariationModel> productVariations, required List<ProductAttributeModel> productAttributes, required String categoryId, required String sku,
  });

  // Convert a Firestore document snapshot to a ProductModel instance
  factory ProductModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return ProductModel(
      id: data['id'] ?? '',
      title: data['title'] ?? '',
      stock: data['stock'] ?? 0,
      price: data['price']?.toDouble() ?? 0.0,
      isFeatured: data['isFeatured'] ?? false,
      thumbnail: data['thumbnail'] ?? '',
      description: data['description'] ?? '',
      brand: BrandModel.fromJson(data['brand']),
      images: List<String>.from(data['images'] ?? []),
      variations: (data['variations'] as List)
          .map((item) => ProductVariationModel.fromJson(item))
          .toList(),
      attributes: (data['attributes'] as List)
          .map((item) => ProductAttributeModel.fromJson(item))
          .toList(),
      salePrice: data['salePrice']?.toDouble() ?? 0.0, productType: '', productVariations: [], productAttributes: [], categoryId: '', sku: '',
    );
  }

  // Convert a ProductModel instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'stock': stock,
      'price': price,
      'isFeatured': isFeatured,
      'thumbnail': thumbnail,
      'description': description,
      'brand': brand.toJson(),
      'images': images,
      'variations': variations.map((v) => v.toJson()).toList(),
      'attributes': attributes.map((a) => a.toJson()).toList(),
      'salePrice': salePrice,
    };
  }
}
