// import 'package:bagit/bloc/cart/cart_event.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:bagit/bloc/favorites/favorites_event.dart';
// import 'package:bagit/bloc/favorites/favorites_state.dart';
// import 'package:bagit/bloc/cart/cart_bloc.dart';
// import 'package:bagit/old_items/product/product.dart';
// import 'package:bagit/entities/product_entity/product_entity.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
//   final CartBloc cartBloc;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   FavoritesBloc({required this.cartBloc}) : super(FavoritesState.initial()) {
//     on<AddToFavorites>(_onAddToFavorites);
//     on<RemoveFromFavorites>(_onRemoveFromFavorites);
//     on<MoveToCartEvent>(_onMoveToCart);
//     on<LoadFavorites>(_onLoadFavorites);
//     _loadFavorites(); // Load existing favorites on initialization
//   }

//   Future<void> _loadFavorites() async {
//     final uid = FirebaseAuth.instance.currentUser!.uid;
//     final snapshot = await _firestore
//         .collection('users')
//         .doc(uid)
//         .collection('favorites')
//         .get();

//     final favoriteItems = snapshot.docs.map((doc) {
//       final data = doc.data();
//       final productEntity = ProductEntity.fromJson(data);
//       final product = Product.fromEntity(productEntity);
//       return product;
//     }).toList();

//     // Dispatch an event to update the state
//     add(LoadFavorites(favoriteItems: favoriteItems));
//   }

//   void _onAddToFavorites(AddToFavorites event, Emitter<FavoritesState> emit) {
//     if (!state.favoriteItems.contains(event.product)) {
//       final updatedFavorites = List<Product>.from(state.favoriteItems)
//         ..add(event.product);
//       emit(state.copyWith(favoriteItems: updatedFavorites));
//     }
//   }

//   void _onRemoveFromFavorites(RemoveFromFavorites event, Emitter<FavoritesState> emit) {
//     final updatedFavorites = List<Product>.from(state.favoriteItems)
//       ..remove(event.product);
//     emit(state.copyWith(favoriteItems: updatedFavorites));
//   }

//   void _onLoadFavorites(LoadFavorites event, Emitter<FavoritesState> emit) {
//     emit(state.copyWith(favoriteItems: event.favoriteItems));
//   }

//   void _onMoveToCart(MoveToCartEvent event, Emitter<FavoritesState> emit) {
//     final updatedFavorites = List<Product>.from(state.favoriteItems)
//       ..remove(event.product);
//     emit(state.copyWith(favoriteItems: updatedFavorites));
//     cartBloc.add(AddToCart(product: event.product));
//   }
// }



// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:buy_it_app/bloc/favorites/favorites_event.dart';
// // import 'package:buy_it_app/bloc/favorites/favorites_state.dart';
// // import 'package:buy_it_app/bloc/cart/cart_bloc.dart'; // Import CartBloc
// // import 'package:buy_it_app/bloc/cart/cart_event.dart'; // Import CartEvent
// // import 'package:buy_it_app/model/product/product.dart';
// // class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
// //   final CartBloc cartBloc;

// //   FavoritesBloc({required this.cartBloc}) : super(FavoritesState.initial()) {
// //     on<AddToFavorites>(_onAddToFavorites);
// //     on<RemoveFromFavorites>(_onRemoveFromFavorites);
// //     on<MoveToCartEvent>(_onMoveToCart);
// //   }

// //   void _onAddToFavorites(AddToFavorites event, Emitter<FavoritesState> emit) {
// //     if (!state.favoriteItems.contains(event.product)) {
// //       final updatedFavorites = List<Product>.from(state.favoriteItems)
// //         ..add(event.product);
// //       emit(state.copyWith(favoriteItems: updatedFavorites));
// //     }
// //   }

// //   void _onRemoveFromFavorites(RemoveFromFavorites event, Emitter<FavoritesState> emit) {
// //     final updatedFavorites = List<Product>.from(state.favoriteItems)
// //       ..remove(event.product);
// //     emit(state.copyWith(favoriteItems: updatedFavorites));
// //   }

// //   void _onMoveToCart(MoveToCartEvent event, Emitter<FavoritesState> emit) {
// //     final updatedFavorites = List<Product>.from(state.favoriteItems)
// //       ..remove(event.product);
// //     emit(state.copyWith(favoriteItems: updatedFavorites));

// //     cartBloc.add(AddToCart(product: event.product));
// //   }
// // }
