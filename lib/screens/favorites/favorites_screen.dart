import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:buy_it_app/bloc/favorites/favorites_bloc.dart';
import 'package:buy_it_app/bloc/favorites/favorites_state.dart';
import 'package:buy_it_app/widgets/single_product.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: BlocBuilder<FavoritesBloc, FavoritesState>(
        builder: (context, state) {
          if (state.favoriteItems.isEmpty) {
            return const Center(child: Text('No favorite items.'));
          }
          return ListView.builder(
            itemCount: state.favoriteItems.length,
            itemBuilder: (context, index) {
              return SingleProduct(product: state.favoriteItems[index]);
            },
          );
        },
      ),
    );
  }
}
