import 'package:bloc/bloc.dart';
import 'package:buy_it_app/bloc/cart/cart_event.dart';
import 'package:buy_it_app/bloc/cart/cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState.initial()) {
    on<AddToCart>(_onAddToCart);
    on<RemoveFromCart>(_onRemoveFromCart);
    on<ClearCart>(_onClearCart);
  }

  void _onAddToCart(AddToCart event, Emitter<CartState> emit) {
    emit(state.copyWith(cartItems: List.from(state.cartItems)..add(event.product)));
  }

  void _onRemoveFromCart(RemoveFromCart event, Emitter<CartState> emit) {
    emit(state.copyWith(cartItems: List.from(state.cartItems)..remove(event.product)));
  }

  void _onClearCart(ClearCart event, Emitter<CartState> emit) {
    emit(state.copyWith(cartItems: []));
  }
}
