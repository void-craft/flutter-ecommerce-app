import 'package:bagit/bloc/all_products/all_products_event.dart';
import 'package:bagit/bloc/all_products/all_products_state.dart';
import 'package:bagit/model/product/product.dart';
import 'package:bagit/repositories/all_products_repo/all_products_actions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllProductsBloc extends Bloc<AllProductsEvent, AllProductsState> {
  final AllProductsActions productActions;

  AllProductsBloc({required this.productActions}) : super(const AllProductsState()) {
    on<FetchAllProducts>(_fetchProducts);
    on<ToggleSortByPrice>(_toggleSortByPrice);
    on<ToggleSortByRating>(_toggleSortByRating);
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

  void _toggleSortByPrice(ToggleSortByPrice event, Emitter<AllProductsState> emit) {
    final sortedProducts = List<Product>.from(state.allProducts);
    final ascending = !(state.sortByPrice ?? true); // Toggle sorting order
    sortedProducts.sort((a, b) {
      return ascending
          ? a.productPrice.compareTo(b.productPrice)
          : b.productPrice.compareTo(a.productPrice);
    });
    emit(state.copyWith(
      allProducts: sortedProducts,
      sortByPrice: ascending,
      sortByRating: null, // Ensure no conflict with rating sorting
    ));
  }

  void _toggleSortByRating(ToggleSortByRating event, Emitter<AllProductsState> emit) {
    final sortedProducts = List<Product>.from(state.allProducts);
    final ascending = !(state.sortByRating ?? true); // Toggle sorting order
    sortedProducts.sort((a, b) {
      return ascending
          ? a.productRating.productRating.compareTo(b.productRating.productRating)
          : b.productRating.productRating.compareTo(a.productRating.productRating);
    });
    emit(state.copyWith(
      allProducts: sortedProducts,
      sortByRating: ascending,
      sortByPrice: null, // Ensure no conflict with price sorting
    ));
  }
}
