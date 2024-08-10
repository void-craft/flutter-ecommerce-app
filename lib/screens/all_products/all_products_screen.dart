import 'package:buy_it_app/bloc/all_products/all_products_bloc.dart';
import 'package:buy_it_app/bloc/all_products/all_products_event.dart';
import 'package:buy_it_app/bloc/all_products/all_products_state.dart';
import 'package:buy_it_app/bloc/favorites/favorites_bloc.dart';
import 'package:buy_it_app/bloc/favorites/favorites_state.dart';
import 'package:buy_it_app/widgets/single_product_widget.dart';
import 'package:buy_it_app/widgets/sort_options_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class AllProducts extends StatefulWidget {
  const AllProducts({super.key});

  @override
  State<AllProducts> createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  @override
  void initState() {
    super.initState();
    final bloc = BlocProvider.of<AllProductsBloc>(context);
    bloc.add(FetchAllProducts());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: SortOptionsWidget(),
          ),
          Expanded(
            child: BlocBuilder<AllProductsBloc, AllProductsState>(
              builder: (context, state) {
                if (state.loading) {
                  return const Center(child: CircularProgressIndicator());
                }

                final products = state.allProducts;

                if (products.isEmpty) {
                  return const Center(child: Text('No products available.'));
                }

                return BlocBuilder<FavoritesBloc, FavoritesState>(
                  builder: (context, favoritesState) {
                    return ListView.builder(
                      itemCount: products.length,
                      itemBuilder: (BuildContext context, int index) {
                        final product = products[index];
                        final isFavorite = favoritesState.favoriteItems.contains(product);

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SingleProduct(
                            product: product,
                            isFavorite: isFavorite,
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}