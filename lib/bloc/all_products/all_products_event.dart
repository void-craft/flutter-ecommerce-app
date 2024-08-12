import 'package:equatable/equatable.dart';

abstract class AllProductsEvent extends Equatable {
  const AllProductsEvent();
}

class FetchAllProducts extends AllProductsEvent {
  @override
  List<Object?> get props => [];
}

class ToggleSortByPrice extends AllProductsEvent {
  @override
  List<Object?> get props => [];
}

class ToggleSortByRating extends AllProductsEvent {
  @override
  List<Object?> get props => [];
}
