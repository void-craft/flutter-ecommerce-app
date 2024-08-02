// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductEntity _$ProductEntityFromJson(Map<String, dynamic> json) =>
    ProductEntity(
      productId: (json['id'] as num).toInt(),
      productTitle: json['title'] as String,
      productPrice: (json['price'] as num).toDouble(),
      productDescription: json['description'] as String,
      productImage: json['image'] as String,
      productRating: fromJson(json['rating']),
    );

Map<String, dynamic> _$ProductEntityToJson(ProductEntity instance) =>
    <String, dynamic>{
      'id': instance.productId,
      'title': instance.productTitle,
      'price': instance.productPrice,
      'description': instance.productDescription,
      'image': instance.productImage,
      'rating': productToJson(instance.productRating),
    };
