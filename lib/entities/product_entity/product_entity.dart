import 'package:buy_it_app/entities/rating/rating_entity.dart';
import 'package:buy_it_app/model/rating/rating.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_entity.g.dart';

Rating fromJson(json) {
  final RatingEntity ratingEntity = RatingEntity.fromJson(json);
  final Rating productRating = Rating.fromEntity(ratingEntity);
  return productRating;
}

Map<String, dynamic> productToJson(Rating productRating) {
  return productRating.toEntity().toJson();
}

@JsonSerializable(explicitToJson: true)
class ProductEntity extends Equatable {
  @JsonKey(name: 'id')
  final int productId;
  @JsonKey(name: 'title')
  final String productTitle;
  @JsonKey(name: 'price')
  final double productPrice;
  @JsonKey(name: 'description')
  final String productDescription;
  @JsonKey(name: 'image')
  final String productImage;
  @JsonKey(name: 'rating', fromJson: fromJson, toJson: productToJson)
  final Rating productRating;

  const ProductEntity({
    required this.productId,
    required this.productTitle,
    required this.productPrice,
    required this.productDescription,
    required this.productImage,
    required this.productRating,
  });

  @override
  List<Object?> get props => [
    productId,
    productTitle,
    productPrice,
    productDescription,
    productImage,
    productRating,
  ];

  factory ProductEntity.fromJson(Map<String, dynamic> json) =>
      _$ProductEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ProductEntityToJson(this);
}
