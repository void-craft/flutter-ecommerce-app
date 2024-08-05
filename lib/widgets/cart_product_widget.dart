import 'package:buy_it_app/screens/item_detail/item_detail_screen.dart';
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
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ItemDetailScreen(product: product),
            ),
          );
        },
        child: ListTile(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.grey.withOpacity(0.5), width: 0.5),
            borderRadius: BorderRadius.circular(5),
          ),
          title: Text(
            product.productTitle,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Colors.black,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.productDescription,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    '€${product.productPrice.toString()}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
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
                  Text(
                    "(${product.productRating.productCount})",
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
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
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  BlocProvider.of<CartBloc>(context).add(
                    RemoveFromCart(product: product),
                  );
                },
              ),
              const SizedBox(width: 8),
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
                        backgroundColor: Colors.purple, // Changed to purple for Move to Favorites
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
            ],
          ),
          leading: SizedBox(
            height: 60,
            width: 60,
            child: Image.network(product.productImage),
          ),
        ),
      ),
    );
  }
}
