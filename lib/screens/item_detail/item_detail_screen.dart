import 'package:buy_it_app/widgets/custom_appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:buy_it_app/bloc/cart/cart_bloc.dart';
import 'package:buy_it_app/bloc/cart/cart_event.dart';
import 'package:buy_it_app/bloc/cart/cart_state.dart';
import 'package:buy_it_app/bloc/favorites/favorites_bloc.dart';
import 'package:buy_it_app/bloc/favorites/favorites_event.dart';
import 'package:buy_it_app/bloc/favorites/favorites_state.dart';
import 'package:buy_it_app/model/product/product.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ItemDetailScreen extends StatelessWidget {
  final Product product;

  const ItemDetailScreen({required this.product, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(showBackButton: true, title: ('Product Detail')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Display product image with maximum size of 200*200
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 250,
                width: 200,
                child: Image.network(
                  product.productImage,
                  fit: BoxFit.cover,
                ),
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
            // Display product price and rating in the same row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '€${product.productPrice.toString()}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 10),
                RatingBar.builder(
                  initialRating: product.productRating.productRating,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: 20,
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {},
                  ignoreGestures: true, // To make it read-only
                ),
                const SizedBox(width: 10),
                Text("(${product.productRating.productCount})"),
              ],
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
                              BlocProvider.of<CartBloc>(context)
                                  .add(DecreaseQuantity(product: product));
                            },
                          ),
                          Text('$quantity',
                              style: Theme.of(context).textTheme.headlineSmall),
                          IconButton(
                            icon: const Icon(Icons.add_circle_outline),
                            onPressed: () {
                              BlocProvider.of<CartBloc>(context)
                                  .add(IncreaseQuantity(product: product));
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // Remove from cart button
                      ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<CartBloc>(context)
                              .add(RemoveFromCart(product: product));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightBlue,
                        ),
                        child: const Text('Remove from Cart',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ] else ...[
                      // Add to cart button
                      ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<CartBloc>(context)
                              .add(AddToCart(product: product));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigoAccent,
                        ),
                        child: const Text('Add to Cart',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ],
                    const SizedBox(height: 16),
                    // Favorites button
                    BlocBuilder<FavoritesBloc, FavoritesState>(
                      builder: (context, favoritesState) {
                        final isFavorite =
                            favoritesState.favoriteItems.contains(product);
                        return IconButton(
                          icon: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite ? Colors.purple : Colors.grey,
                            size: 30,
                          ),
                          onPressed: () {
                            BlocProvider.of<FavoritesBloc>(context).add(
                              isFavorite
                                  ? RemoveFromFavorites(product: product)
                                  : AddToFavorites(product: product),
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
