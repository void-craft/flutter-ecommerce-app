import 'package:equatable/equatable.dart';

abstract class AllProductsEvent extends Equatable {

}

class FetchAllProducts extends AllProductsEvent {
  @override
  List<Object?> get props => throw UnimplementedError();
}