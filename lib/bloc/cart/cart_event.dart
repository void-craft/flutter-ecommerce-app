import 'package:equatable/equatable.dart';
import 'package:buy_it_app/model/product/product.dart';

abstract class CartEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddProductToCart extends CartEvent {
  final Product product;

  AddProductToCart(this.product);

  @override
  List<Object?> get props => [product];
}

class RemoveProductFromCart extends CartEvent {
  final Product product;

  RemoveProductFromCart(this.product);

  @override
  List<Object?> get props => [product];
}

class ClearCart extends CartEvent {}
