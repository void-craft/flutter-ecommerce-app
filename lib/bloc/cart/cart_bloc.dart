import 'package:buy_it_app/model/product/product.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:buy_it_app/bloc/cart/cart_event.dart';
import 'package:buy_it_app/bloc/cart/cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState.initial()) {
    on<AddToCart>(_onAddToCart);
    on<RemoveFromCart>(_onRemoveFromCart);
    on<UpdateCart>(_onUpdateCart);
    on<IncreaseQuantity>(_onIncreaseQuantity); // Add this handler
    on<DecreaseQuantity>(_onDecreaseQuantity); // Add this handler
    on<ClearCart>(_onClearCart);
  }

  void _onAddToCart(AddToCart event, Emitter<CartState> emit) {
    final updatedItems = List<Product>.from(state.cartItems)
      ..add(event.product.copyWith(quantity: 1)); // Set initial quantity to 1
    emit(state.copyWith(cartItems: updatedItems));
  }

  void _onRemoveFromCart(RemoveFromCart event, Emitter<CartState> emit) {
    final updatedItems = List<Product>.from(state.cartItems)
      ..removeWhere((product) => product.productId == event.product.productId);
    emit(state.copyWith(cartItems: updatedItems));
  }

  void _onUpdateCart(UpdateCart event, Emitter<CartState> emit) {
    final updatedItems = state.cartItems.map((product) {
      return product.productId == event.product.productId
          ? product.copyWith(quantity: event.quantity)
          : product;
    }).toList();
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
      return product.productId == event.product.productId
          ? product.copyWith(quantity: product.quantity > 1 ? product.quantity - 1 : 0)
          : product;
    }).toList();
    emit(state.copyWith(cartItems: updatedItems));
  }

  void _onClearCart(ClearCart event, Emitter<CartState> emit) {
    emit(state.copyWith(cartItems: []));
  }
}



// import 'package:buy_it_app/model/product/product.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:buy_it_app/bloc/cart/cart_event.dart';
// import 'package:buy_it_app/bloc/cart/cart_state.dart';

// class CartBloc extends Bloc<CartEvent, CartState> {
//   CartBloc() : super(CartState.initial()) {
//     on<AddToCart>(_onAddToCart);
//     on<RemoveFromCart>(_onRemoveFromCart);
//     on<IncreaseQuantity>(_onIncreaseQuantity);
//     on<DecreaseQuantity>(_onDecreaseQuantity);
//     on<ClearCart>(_onClearCart);
//   }

//   void _onAddToCart(AddToCart event, Emitter<CartState> emit) {
//     final updatedCartItems = Map<Product, int>.from(state.cartItems);
//     if (updatedCartItems.containsKey(event.product)) {
//       updatedCartItems[event.product] = updatedCartItems[event.product]! + 1;
//     } else {
//       updatedCartItems[event.product] = 1;
//     }
//     emit(state.copyWith(cartItems: updatedCartItems));
//   }

//   void _onRemoveFromCart(RemoveFromCart event, Emitter<CartState> emit) {
//     final updatedCartItems = Map<Product, int>.from(state.cartItems);
//     updatedCartItems.remove(event.product);
//     emit(state.copyWith(cartItems: updatedCartItems));
//   }

//   void _onIncreaseQuantity(IncreaseQuantity event, Emitter<CartState> emit) {
//     final updatedCartItems = Map<Product, int>.from(state.cartItems);
//     if (updatedCartItems.containsKey(event.product)) {
//       updatedCartItems[event.product] = updatedCartItems[event.product]! + 1;
//       emit(state.copyWith(cartItems: updatedCartItems));
//     }
//   }

//   void _onDecreaseQuantity(DecreaseQuantity event, Emitter<CartState> emit) {
//     final updatedCartItems = Map<Product, int>.from(state.cartItems);
//     if (updatedCartItems.containsKey(event.product)) {
//       final currentQuantity = updatedCartItems[event.product]!;
//       if (currentQuantity > 1) {
//         updatedCartItems[event.product] = currentQuantity - 1;
//       } else {
//         updatedCartItems.remove(event.product);
//       }
//       emit(state.copyWith(cartItems: updatedCartItems));
//     }
//   }

//   void _onClearCart(ClearCart event, Emitter<CartState> emit) {
//     emit(state.copyWith(cartItems: {}));
//   }
// }
