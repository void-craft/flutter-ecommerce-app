import 'package:buy_it_app/bloc/favorites/favorites_bloc.dart';
import 'package:buy_it_app/bloc/favorites/favorites_state.dart';
import 'package:buy_it_app/widgets/appbar/custom_appbar_widget.dart';
import 'package:buy_it_app/widgets/product/favorite_product_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        showBackButton: true,
        isTitleCentered: false,
        title: "Favorites",
      ),
      body: BlocBuilder<FavoritesBloc, FavoritesState>(
        builder: (context, state) {
          if (state.favoriteItems.isEmpty) {
            return const Center(child: Text('No favorite items.'));
          }
          return ListView.builder(
            itemCount: state.favoriteItems.length,
            itemBuilder: (context, index) {
              return FavoriteProduct(product: state.favoriteItems[index]);
            },
          );
        },
      ),
    );
  }
}
