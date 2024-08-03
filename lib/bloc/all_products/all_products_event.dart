// all_products_event.dart

import 'package:equatable/equatable.dart';

abstract class AllProductsEvent extends Equatable {
  const AllProductsEvent();
}

class FetchAllProducts extends AllProductsEvent {
  @override
  List<Object?> get props => [];
}

class SortProductsByPrice extends AllProductsEvent {
  final bool ascending;

  const SortProductsByPrice({required this.ascending});

  @override
  List<Object?> get props => [ascending];
}

class SortProductsByRating extends AllProductsEvent {
  final bool ascending;

  const SortProductsByRating({required this.ascending});

  @override
  List<Object?> get props => [ascending];
}
