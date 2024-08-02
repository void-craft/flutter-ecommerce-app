import 'package:buy_it_app/entities/product_entity/product_entity.dart';
import 'package:buy_it_app/model/rating/rating.dart';
import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final int productId;
  final String productTitle;
  final double productPrice;
  final String productDescription;
  final String productImage;
  final Rating productRating;

  const Product(
      {required this.productId,
      required this.productTitle,
      required this.productPrice,
      required this.productDescription,
      required this.productImage,
      required this.productRating});

  static Product fromEntity(ProductEntity productEntity) {
    return Product(
        productImage: productEntity.productImage,
        productDescription: productEntity.productDescription,
        productPrice: productEntity.productPrice,
        productId: productEntity.productId,
        productRating: productEntity.productRating,
        productTitle: productEntity.productTitle);
  }

  ProductEntity toEntity() {
    return ProductEntity(
        productId: productId,
        productTitle: productTitle,
        productPrice: productPrice,
        productDescription: productDescription,
        productImage: productImage,
        productRating: productRating);
  }

  @override
  List<Object?> get props => [
        productId,
        productTitle,
        productPrice,
        productDescription,
        productImage,
        productRating
      ];
}
