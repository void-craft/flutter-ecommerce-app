import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:buy_it_app/bloc/cart/cart_bloc.dart';
import 'package:buy_it_app/bloc/cart/cart_state.dart';
import 'package:buy_it_app/bloc/favorites/favorites_bloc.dart'; // Import FavoritesBloc
import 'package:buy_it_app/bloc/favorites/favorites_state.dart'; // Import FavoritesState
import 'package:buy_it_app/screens/cart/cart_screen.dart';
import 'package:buy_it_app/screens/favorites/favorites_screen.dart'; // Import FavoritesScreen

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.pink,
      title: const Text(
        "Buy It - Your Shopping App",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: Colors.white,
        ),
      ),
      actions: [
        BlocBuilder<FavoritesBloc, FavoritesState>(
          builder: (context, state) {
            return IconButton(
              icon: Stack(
                children: [
                  const Icon(
                    Icons.favorite,
                    color: Colors.white,
                    size: 30,
                  ),
                  if (state.favoriteItems.isNotEmpty)
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        child: Text(
                          '${state.favoriteItems.length}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FavoritesScreen()),
                );
              },
            );
          },
        ),
        BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            return Stack(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CartScreen()),
                    );
                  },
                ),
                if (state.cartItems.isNotEmpty)
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      child: Text(
                        '${state.cartItems.length}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
