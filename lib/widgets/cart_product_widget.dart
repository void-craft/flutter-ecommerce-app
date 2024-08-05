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

class CartProductWidget extends StatelessWidget {
  final Product product;

  const CartProductWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.grey.withOpacity(0.5), width: 0.5),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Fixed-size image container with BoxFit.contain
            Container(
              width: 100, // Fixed width for image container
              height: 100, // Fixed height for image container
              padding: const EdgeInsets.all(8.0),
              child: Image.network(
                product.productImage,
                fit: BoxFit.contain, // Ensures the whole image is visible
              ),
            ),
            // Content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.productTitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Rating and number of reviews
                    Row(
                      children: [
                        RatingBar.builder(
                          initialRating: product.productRating.productRating,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemSize: 16,
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {},
                          ignoreGestures: true, // To make it read-only
                        ),
                        const SizedBox(width: 4),
                        Text(
                          "(${product.productRating.productCount})",
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // Price and Quantity Adjustment Buttons
                    Row(
                      children: [
                        Text(
                          '€${product.productPrice.toString()}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(Icons.remove_circle_outline, color: Colors.lightBlue),
                          onPressed: () {
                            BlocProvider.of<CartBloc>(context).add(
                              DecreaseQuantity(product: product),
                            );
                          },
                        ),
                        BlocBuilder<CartBloc, CartState>(
                          builder: (context, cartState) {
                            final quantity = cartState.cartItems
                                .firstWhere((item) => item.productId == product.productId, orElse: () => product.copyWith(quantity: 0))
                                .quantity;
                            return Text(
                              '$quantity',
                              style: Theme.of(context).textTheme.titleLarge,
                            );
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.add_circle_outline, color: Colors.green),
                          onPressed: () {
                            BlocProvider.of<CartBloc>(context).add(
                              IncreaseQuantity(product: product),
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // Move to Favorites Button
                    BlocBuilder<FavoritesBloc, FavoritesState>(
                      builder: (context, favoritesState) {
                        final isFavorite = favoritesState.favoriteItems.any(
                          (item) => item.productId == product.productId,
                        );
                        return Visibility(
                          visible: !isFavorite, // Show button only if not in favorites
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.purple, // Button color
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            onPressed: () {
                              BlocProvider.of<FavoritesBloc>(context).add(
                                AddToFavorites(product: product),
                              );
                              BlocProvider.of<CartBloc>(context).add(
                                RemoveFromCart(product: product),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('${product.productTitle} moved to favorites')),
                              );
                            },
                            child: const Text("Move To Favorites"),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 8),
                    // Remove Item Link
                    TextButton(
                      onPressed: () {
                        BlocProvider.of<CartBloc>(context).add(
                          RemoveFromCart(product: product),
                        );
                      },
                      child: const Text(
                        "Remove Item",
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
