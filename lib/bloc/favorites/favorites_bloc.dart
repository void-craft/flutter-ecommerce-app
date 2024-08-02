import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:buy_it_app/bloc/favorites/favorites_event.dart';
import 'package:buy_it_app/bloc/favorites/favorites_state.dart';
import 'package:buy_it_app/model/product/product.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  FavoritesBloc() : super(FavoritesState.initial()) {
    on<AddToFavorites>(_onAddToFavorites);
    on<RemoveFromFavorites>(_onRemoveFromFavorites);
  }

  void _onAddToFavorites(AddToFavorites event, Emitter<FavoritesState> emit) {
    final updatedFavorites = List<Product>.from(state.favoriteItems)
      ..add(event.product);
    emit(state.copyWith(favoriteItems: updatedFavorites));
  }

  void _onRemoveFromFavorites(RemoveFromFavorites event, Emitter<FavoritesState> emit) {
    final updatedFavorites = List<Product>.from(state.favoriteItems)
      ..remove(event.product);
    emit(state.copyWith(favoriteItems: updatedFavorites));
  }
}
