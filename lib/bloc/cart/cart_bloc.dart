import 'package:buy_it_app/bloc/cart/cart_event.dart';
import 'package:buy_it_app/bloc/cart/cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:buy_it_app/model/product/product.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartState()) {
    on<AddProductToCart>((event, emit) {
      final updatedCart = List<Product>.from(state.cart)..add(event.product);
      emit(state.copyWith(cart: updatedCart));
    });

    on<RemoveProductFromCart>((event, emit) {
      final updatedCart = List<Product>.from(state.cart)
        ..remove(event.product);
      emit(state.copyWith(cart: updatedCart));
    });

    on<ClearCart>((event, emit) {
      emit(state.copyWith(cart: []));
    });
  }
}
