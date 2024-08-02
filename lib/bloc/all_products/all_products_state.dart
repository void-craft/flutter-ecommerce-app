import 'package:buy_it_app/model/product/product.dart';
import 'package:equatable/equatable.dart';

class AllProductsState extends Equatable {
  final List<Product>? allProducts;
  final bool loading;

  const AllProductsState({this.allProducts = const [], this.loading = false});

  AllProductsState copyWith({List<Product>? allProducts, bool? loading}) {
    return AllProductsState(
        allProducts: allProducts ?? this.allProducts,
        loading: loading ?? this.loading);
  }

  @override
  List<Object?> get props => [allProducts, loading];
}
