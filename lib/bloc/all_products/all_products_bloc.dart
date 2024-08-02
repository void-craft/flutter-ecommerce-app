import 'package:buy_it_app/bloc/all_products/all_products_event.dart';
import 'package:buy_it_app/bloc/all_products/all_products_state.dart';
import 'package:buy_it_app/repositories/all_products_repo/all_products_actions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllProductsBloc extends Bloc<AllProductsEvent, AllProductsState> {
  final AllProductsActions productActions;

  AllProductsBloc({required this.productActions})
      : super(const AllProductsState()) {
    on<FetchAllProducts>(_fetchProducts);
  }

  Future<void> _fetchProducts(
      FetchAllProducts event, Emitter<AllProductsState> emit) async {
    print('Fetching products...'); // Debug print
    emit(state.copyWith(loading: true));
    try {
      final allProducts = await productActions.fetchAllProducts();
      print('Fetched products: $allProducts'); // Debug print
      emit(state.copyWith(allProducts: allProducts, loading: false));
    } catch (e) {
      print('Error fetching products: $e'); // Debug print
      emit(state.copyWith(loading: false)); // Ensure loading is set to false
    }
  }
}

