import 'package:equatable/equatable.dart';
import 'package:bagit/model/product/product.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class AddToCart extends CartEvent {
  final Product product;

  const AddToCart({required this.product});

  @override
  List<Object> get props => [product];
}

class RemoveFromCart extends CartEvent {
  final Product product;

  const RemoveFromCart({required this.product});

  @override
  List<Object> get props => [product];
}

class UpdateCart extends CartEvent {
  final Product product;
  final int quantity;

  const UpdateCart({required this.product, required this.quantity});

  @override
  List<Object> get props => [product, quantity];
}

class IncreaseQuantity extends CartEvent { // Add this event
  final Product product;

  const IncreaseQuantity({required this.product});

  @override
  List<Object> get props => [product];
}

class DecreaseQuantity extends CartEvent { // Add this event
  final Product product;

  const DecreaseQuantity({required this.product});

  @override
  List<Object> get props => [product];
}

class ClearCart extends CartEvent {
  const ClearCart();
}
