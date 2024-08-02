import 'package:equatable/equatable.dart';
import 'package:buy_it_app/model/product/product.dart';

class CartState extends Equatable {
  final List<Product> cart;

  const CartState({this.cart = const []});

  CartState copyWith({List<Product>? cart}) {
    return CartState(cart: cart ?? this.cart);
  }

  @override
  List<Object?> get props => [cart];
}
