import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:buy_it_app/bloc/cart/cart_bloc.dart';
import 'package:buy_it_app/bloc/cart/cart_event.dart';
import 'package:buy_it_app/bloc/cart/cart_state.dart';
import 'package:buy_it_app/bloc/favorites/favorites_bloc.dart';
import 'package:buy_it_app/bloc/favorites/favorites_event.dart';
import 'package:buy_it_app/bloc/favorites/favorites_state.dart';
import 'package:buy_it_app/model/product/product.dart';

class ItemDetailScreen extends StatelessWidget {
  final Product product;

  const ItemDetailScreen({required this.product, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.productTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Display product image with maximum size of 300x300
            SizedBox(
              height: 300,
              width: 300,
              child: Image.network(
                product.productImage,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            // Display product title
            Text(
              product.productTitle,
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            // Display product price
            Text(
              'Price: \$${product.productPrice}',
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            // Display product rating
            Text(
              'Rating: ${product.productRating.productRating}',
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            // Display product description
            Text(
              product.productDescription,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            // Cart and favorites buttons
            BlocBuilder<CartBloc, CartState>(
              builder: (context, cartState) {
                final cartItem = cartState.cartItems.firstWhere(
                  (item) => item.productId == product.productId,
                  orElse: () => product.copyWith(quantity: 0),
                );
                final quantity = cartItem.quantity;

                return Column(
                  children: [
                    if (quantity > 0) ...[
                      // Quantity adjustment
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove_circle_outline),
                            onPressed: () {
                              BlocProvider.of<CartBloc>(context).add(DecreaseQuantity(product: product));
                            },
                          ),
                          Text('$quantity', style: Theme.of(context).textTheme.headlineSmall),
                          IconButton(
                            icon: const Icon(Icons.add_circle_outline),
                            onPressed: () {
                              BlocProvider.of<CartBloc>(context).add(IncreaseQuantity(product: product));
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // Remove from cart button
                      ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<CartBloc>(context).add(RemoveFromCart(product: product));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        child: const Text('Remove from Cart'),
                      ),
                    ] else ...[
                      // Add to cart button
                      ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<CartBloc>(context).add(AddToCart(product: product));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                        ),
                        child: const Text('Add to Cart'),
                      ),
                    ],
                    const SizedBox(height: 16),
                    // Favorites button
                    BlocBuilder<FavoritesBloc, FavoritesState>(
                      builder: (context, favoritesState) {
                        final isFavorite = favoritesState.favoriteItems.contains(product);
                        return IconButton(
                          icon: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite ? Colors.red : Colors.grey,
                            size: 30,
                          ),
                          onPressed: () {
                            BlocProvider.of<FavoritesBloc>(context).add(
                              isFavorite ? RemoveFromFavorites(product: product) : AddToFavorites(product: product),
                            );
                          },
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
