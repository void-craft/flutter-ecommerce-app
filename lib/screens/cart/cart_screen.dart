import 'package:buy_it_app/bloc/cart/cart_event.dart';
import 'package:buy_it_app/bloc/favorites/favorites_event.dart';
import 'package:buy_it_app/bloc/favorites/favorites_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:buy_it_app/bloc/cart/cart_bloc.dart';
import 'package:buy_it_app/bloc/cart/cart_state.dart';
import 'package:buy_it_app/bloc/favorites/favorites_bloc.dart';
import 'package:buy_it_app/widgets/custom_appbar_widget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        showBackButton: true,
        isTitleCentered: true,
        title: "Your Cart",
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, cartState) {
          return BlocBuilder<FavoritesBloc, FavoritesState>(
            builder: (context, favoritesState) {
              if (cartState.cartItems.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(
                        'https://images.unsplash.com/photo-1536910467852-a6fded0c5c47?q=80&w=870&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', // Replace with actual URL
                        height: 200, // Adjust as needed
                        width: 200,  // Adjust as needed
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Your cart is empty :(',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              }
              return ListView.builder(
                itemCount: cartState.cartItems.length,
                itemBuilder: (context, index) {
                  final cartItem = cartState.cartItems[index];
                  final isFavorite = favoritesState.favoriteItems.any(
                    (item) => item.productId == cartItem.productId,
                  );

                  return ListTile(
                    leading: SizedBox(
                      height: 70,
                      width: 70,
                      child: Image.network(cartItem.productImage),
                    ),
                    title: Text(
                      cartItem.productTitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Price: €${cartItem.productPrice}',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove_circle_outline, color: Colors.lightBlue),
                              onPressed: () {
                                BlocProvider.of<CartBloc>(context).add(DecreaseQuantity(product: cartItem));
                              },
                            ),
                            Text('${cartItem.quantity}'),
                            IconButton(
                              icon: const Icon(Icons.add_circle_outline, color: Colors.green),
                              onPressed: () {
                                BlocProvider.of<CartBloc>(context).add(IncreaseQuantity(product: cartItem));
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextButton(
                          onPressed: () {
                            BlocProvider.of<CartBloc>(context).add(
                              RemoveFromCart(product: cartItem),
                            );
                          },
                          child: const Text(
                            'Remove from Cart',
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        if (!isFavorite) // Conditionally show the button
                          TextButton(
                            onPressed: () {
                              BlocProvider.of<FavoritesBloc>(context).add(
                                AddToFavorites(product: cartItem),
                              );
                              BlocProvider.of<CartBloc>(context).add(
                                RemoveFromCart(product: cartItem),
                              );
                            },
                            child: const Text(
                              'Move to Favorites',
                              style: TextStyle(
                                color: Colors.purple,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
