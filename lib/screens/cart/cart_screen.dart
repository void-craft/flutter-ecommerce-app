import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:buy_it_app/bloc/cart/cart_bloc.dart';
import 'package:buy_it_app/bloc/cart/cart_state.dart';
import 'package:buy_it_app/bloc/favorites/favorites_bloc.dart';
import 'package:buy_it_app/bloc/favorites/favorites_state.dart';
import 'package:buy_it_app/widgets/custom_appbar_widget.dart';
import 'package:buy_it_app/widgets/cart_product_widget.dart';

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
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 20),
                      Text(
                        'Your cart is empty :(',
                        style: TextStyle(
                          fontSize: 18,
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
                  return CartProductWidget(product: cartItem);
                },
              );
            },
          );
        },
      ),
    );
  }
}
