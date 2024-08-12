import 'package:equatable/equatable.dart';
import 'package:bagit/model/product/product.dart';

class FavoritesState extends Equatable {
  final List<Product> favoriteItems;

  const FavoritesState({required this.favoriteItems});

  factory FavoritesState.initial() {
    return const FavoritesState(favoriteItems: []);
  }

  FavoritesState copyWith({List<Product>? favoriteItems}) {
    return FavoritesState(
      favoriteItems: favoriteItems ?? this.favoriteItems,
    );
  }

  @override
  List<Object> get props => [favoriteItems];
}
