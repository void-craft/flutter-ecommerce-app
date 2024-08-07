import 'package:buy_it_app/model/product/product.dart';
import 'package:equatable/equatable.dart';

class AllProductsState extends Equatable {
  final List<Product> allProducts;
  final bool loading;
  final bool? sortByPrice; // true for low-to-high, false for high-to-low
  final bool? sortByRating; // true for low-to-high, false for high-to-low

  const AllProductsState({
    this.allProducts = const [],
    this.loading = false,
    this.sortByPrice,
    this.sortByRating,
  });

  AllProductsState copyWith({
    List<Product>? allProducts,
    bool? loading,
    bool? sortByPrice,
    bool? sortByRating,
  }) {
    return AllProductsState(
      allProducts: allProducts ?? this.allProducts,
      loading: loading ?? this.loading,
      sortByPrice: sortByPrice ?? this.sortByPrice,
      sortByRating: sortByRating ?? this.sortByRating,
    );
  }

  @override
  List<Object?> get props => [allProducts, loading, sortByPrice, sortByRating];
}
