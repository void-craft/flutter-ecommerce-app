// all_products_bloc.dart

import 'package:buy_it_app/bloc/all_products/all_products_event.dart';
import 'package:buy_it_app/bloc/all_products/all_products_state.dart';
import 'package:buy_it_app/model/product/product.dart';
import 'package:buy_it_app/repositories/all_products_repo/all_products_actions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllProductsBloc extends Bloc<AllProductsEvent, AllProductsState> {
  final AllProductsActions productActions;

  AllProductsBloc({required this.productActions}) : super(const AllProductsState()) {
    on<FetchAllProducts>(_fetchProducts);
    on<SortProductsByPrice>(_sortProductsByPrice);
    on<SortProductsByRating>(_sortProductsByRating);
  }

  Future<void> _fetchProducts(FetchAllProducts event, Emitter<AllProductsState> emit) async {
    emit(state.copyWith(loading: true));
    try {
      final allProducts = await productActions.fetchAllProducts();
      emit(state.copyWith(allProducts: allProducts, loading: false));
    } catch (e) {
      emit(state.copyWith(loading: false));
    }
  }

  void _sortProductsByPrice(SortProductsByPrice event, Emitter<AllProductsState> emit) {
    final sortedProducts = List<Product>.from(state.allProducts);
    sortedProducts.sort((a, b) {
      return event.ascending
          ? a.productPrice.compareTo(b.productPrice)
          : b.productPrice.compareTo(a.productPrice);
    });
    emit(state.copyWith(
      allProducts: sortedProducts,
      sortByPrice: event.ascending,
      sortByRating: null, // Ensure no conflict with rating sorting
    ));
  }

  void _sortProductsByRating(SortProductsByRating event, Emitter<AllProductsState> emit) {
    final sortedProducts = List<Product>.from(state.allProducts);
    sortedProducts.sort((a, b) {
      return event.ascending
          ? a.productRating.productRating.compareTo(b.productRating.productRating)
          : b.productRating.productRating.compareTo(a.productRating.productRating);
    });
    emit(state.copyWith(
      allProducts: sortedProducts,
      sortByRating: event.ascending,
      sortByPrice: null, // Ensure no conflict with price sorting
    ));
  }
}
