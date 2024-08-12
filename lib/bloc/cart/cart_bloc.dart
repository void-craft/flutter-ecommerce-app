import 'package:bagit/model/product/product.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bagit/bloc/cart/cart_event.dart';
import 'package:bagit/bloc/cart/cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState.initial()) {
    on<AddToCart>(_onAddToCart);
    on<RemoveFromCart>(_onRemoveFromCart);
    on<UpdateCart>(_onUpdateCart);
    on<IncreaseQuantity>(_onIncreaseQuantity);
    on<DecreaseQuantity>(_onDecreaseQuantity);
    on<ClearCart>(_onClearCart);
  }

  void _onAddToCart(AddToCart event, Emitter<CartState> emit) {
    final updatedItems = List<Product>.from(state.cartItems);
    final existingItemIndex = updatedItems.indexWhere((item) => item.productId == event.product.productId);

    if (existingItemIndex != -1) {
      updatedItems[existingItemIndex] = updatedItems[existingItemIndex].copyWith(quantity: updatedItems[existingItemIndex].quantity + 1);
    } else {
      updatedItems.add(event.product.copyWith(quantity: 1));
    }
    
    emit(state.copyWith(cartItems: updatedItems));
  }

  void _onRemoveFromCart(RemoveFromCart event, Emitter<CartState> emit) {
    final updatedItems = List<Product>.from(state.cartItems)
      ..removeWhere((product) => product.productId == event.product.productId);
    emit(state.copyWith(cartItems: updatedItems));
  }

  void _onUpdateCart(UpdateCart event, Emitter<CartState> emit) {
    final updatedItems = state.cartItems.map((product) {
      if (product.productId == event.product.productId) {
        if (event.quantity <= 0) {
          return null; // Mark for removal
        } else {
          return product.copyWith(quantity: event.quantity);
        }
      }
      return product;
    }).where((product) => product != null).cast<Product>().toList(); // Remove nulls
    emit(state.copyWith(cartItems: updatedItems));
  }

  void _onIncreaseQuantity(IncreaseQuantity event, Emitter<CartState> emit) {
    final updatedItems = state.cartItems.map((product) {
      return product.productId == event.product.productId
          ? product.copyWith(quantity: product.quantity + 1)
          : product;
    }).toList();
    emit(state.copyWith(cartItems: updatedItems));
  }

  void _onDecreaseQuantity(DecreaseQuantity event, Emitter<CartState> emit) {
    final updatedItems = state.cartItems.map((product) {
      if (product.productId == event.product.productId) {
        final newQuantity = product.quantity > 1 ? product.quantity - 1 : 0;
        return product.copyWith(quantity: newQuantity);
      }
      return product;
    }).where((product) => product.quantity > 0).toList(); // Remove items with quantity 0
    emit(state.copyWith(cartItems: updatedItems));
  }

  void _onClearCart(ClearCart event, Emitter<CartState> emit) {
    emit(state.copyWith(cartItems: []));
  }
}
