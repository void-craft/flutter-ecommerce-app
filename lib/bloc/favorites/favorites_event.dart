import 'package:equatable/equatable.dart';
import 'package:bagit/model/product/product.dart';

abstract class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object> get props => [];
}

class AddToFavorites extends FavoritesEvent {
  final Product product;

  const AddToFavorites({required this.product});

  @override
  List<Object> get props => [product];
}

class RemoveFromFavorites extends FavoritesEvent {
  final Product product;

  const RemoveFromFavorites({required this.product});

  @override
  List<Object> get props => [product];
}

class MoveToCartEvent extends FavoritesEvent {
  final Product product;

  const MoveToCartEvent({required this.product});

    @override
  List<Object> get props => [product];
}

class LoadFavorites extends FavoritesEvent {
  final List<Product> favoriteItems;

  const LoadFavorites({required this.favoriteItems});
}
